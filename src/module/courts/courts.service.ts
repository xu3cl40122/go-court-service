import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Court } from '../../entity/court.entity';
import { ILike } from "typeorm";

@Injectable()
export class CourtService {
  constructor(
    @InjectRepository(Court) private courtsRepository: Repository<Court>,
  ) { }

  async queryCourts(query: { page, size, city_code, dist_code }): Promise<Object> {
    let [page, size] = [Number(query.page ?? 0), Number(query.size ?? 10)]
    let where = {}
    let filters = ['city_code', 'dist_code']
    filters.forEach(key => query[key] ? where[key] = query[key] : '')
    let [content, total] = await this.courtsRepository.findAndCount({
      where,
      take: size,
      skip: page * size,
      order: {
        created_at: "DESC"
      }
    })

    let totalPage = Math.ceil(total / size)
    return { content, page, size, total, totalPage }
  }

  async findCourt(query: { court_id?: string }) {
    return await this.courtsRepository.findOne({
      where: query,
    })
  }

  /**
   * 待研究 like 好像不能和其他參數混用 
   */
  async searchCourt(query: { name }): Promise<Object> {
    let option: any = {}
    if (query.name)
      option.name = ILike(`%${query.name}%`)
    let courts = await this.courtsRepository.find(option)

    // let courts = await this.courtsRepository.find({
    //   name: ILike(`%${query.name}%`)
    // })

    return courts
  }

  async addCourt(courtData: Court): Promise<Object> {
    const court = new Court();
    let columns = [
      'name',
      'address',
      'city_code',
      'dist_code',
      'latitude',
      'longitude',
      'phone',
      'logo_url',
      'description',
      'open_status',
    ]
    columns.forEach(key => court[key] = courtData[key])

    let { raw } = await this.courtsRepository
      .createQueryBuilder()
      .insert()
      .into('court')
      .values({
        ...court,
        geometry: () => `ST_SetSRID(ST_MakePoint(${court.longitude}, ${court.latitude}), 4326)`,
      })
      .returning('*')
      .execute();

    return raw[0]
  }

  async updateCourtById(court_id: string, courtData: Court): Promise<Object> {
    const court = new Court();
    let columns = [
      'name',
      'address',
      'city_code',
      'dist_code',
      'latitude',
      'longitude',
      'phone',
      'logo_url',
      'description',
      'open_status',
    ]
    columns.forEach(key => court[key] = courtData[key])

    let { raw } = await this.courtsRepository
      .createQueryBuilder()
      .update(Court)
      .set({
        ...court,
        geometry: () => `ST_SetSRID(ST_MakePoint(${court.longitude}, ${court.latitude}), 4326)`,
      })
      .where("court_id = :court_id", { court_id })
      .returning('*')
      .execute();

    return raw?.[0]
  }


}
