import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, getManager } from 'typeorm';
import { File } from '../../entity/file.entity'
import { FileQueryDto } from '../../dto/query.dto'
import { FileDto } from '../../dto/file.dto'
import { Express } from 'express'
// import entire SDK
import * as AWS from 'aws-sdk';



@Injectable()
export class FilesService {
  constructor(
    @InjectRepository(File) private filesRepository: Repository<File>,
  ) {
    this.bucketName = process.env.NODE_ENV === 'production' ? 'gc-file-service' : 'gc-file-service-dev'
  }

  bucketName = 'gc-file-service-dev'

  async findFile(query: { file_id?: string }) {
    return await this.filesRepository.findOne({
      where: query,
    })
  }

  // game part 
  async queryFiles(query: FileQueryDto) {
    let [page, size] = [Number(query.page ?? 0), Number(query.size ?? 10)]
    let { tag, reference_id, created_by } = query
    let where: any = {}

    if (tag)
      where.tag = tag
    if (reference_id)
      where.tag = reference_id
    if (created_by)
      where.created_by = created_by

    let [content, total] = await this.filesRepository.findAndCount({
      where,
      take: size,
      skip: page * size,
    })

    let totalPage = Math.ceil(total / size)
    return { content, page, size, total, totalPage }
  }

  async addFile(fileData: FileDto): Promise<Object> {
    const file = new File();
    let columns = [
      'file_name',
      'tag',
      'file_url',
      'created_by',
      'reference_id',
      'is_public',
      'description',
      'meta',
    ]
    columns.forEach(key => file[key] = fileData[key])
    return await this.filesRepository.save(file);
  }

  async updateFile(file_id: string, fileData: File): Promise<Object> {
    const file = new File();
    let columns = [
      'file_name',
      'tag',
      'file_url',
      'reference_id',
      'is_public',
      'description',
      'meta',
    ]
    columns.forEach(key => file[key] = fileData[key])

    let { raw } = await this.filesRepository
      .createQueryBuilder()
      .update(File)
      .set(file)
      .where("file_id = :file_id", { file_id })
      .returning('*')
      .execute();

    return raw?.[0]
  }

  async deleteFile(file_id: string): Promise<Object> {
    let s3 = new AWS.S3()
    let params = {
      Bucket: this.bucketName,
      Key: file_id,
    }
    s3.deleteObject(params).promise()
    return this.filesRepository.delete(file_id)
  }

  async updateFileContent(file: File, fileContent: Express.Multer.File) {
    let s3 = new AWS.S3()
    let params = {
      Body: fileContent.buffer,
      Bucket: this.bucketName,
      Key: file.file_id,
      ACL: file.is_public ? 'public-read' : 'authenticated-read',
      ContentType: fileContent.mimetype
    };

    await s3.putObject(params).promise().catch(() => { throw 'upload failed' })
    file.file_url = `https://${this.bucketName}.s3-us-west-2.amazonaws.com/${file.file_id}`
    return this.updateFile(file.file_id, file)
  }

  async getFileContent(file: File) {
    let s3 = new AWS.S3()
    let params = {
      Bucket: this.bucketName,
      Key: file.file_id,
    };
    let res:any = await s3.getObject(params).promise().catch((err) => { throw err })
    return res
    // file.file_url = `https://${this.bucketName}.s3-us-west-2.amazonaws.com/${file.file_id}`
    // return this.updateFile(file.file_id, file)
  }

}
