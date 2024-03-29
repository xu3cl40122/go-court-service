import { FilesService } from './files.service';
import { JwtAuthGuard } from '../auth/jwt.guard';
import { Express, Response } from 'express'
import { FileInterceptor } from '@nestjs/platform-express'
import {
  Controller,
  Get,
  Post,
  Put,
  Delete,
  Param,
  Body,
  Query,
  HttpException,
  HttpStatus,
  UseGuards,
  Req,
  UseInterceptors,
  UploadedFile,
  Res
} from '@nestjs/common';
import { ApiOkResponse, ApiCreatedResponse, ApiHeader, ApiTags, ApiOperation, ApiBody } from '@nestjs/swagger';
import { FileQueryDto } from '../../dto/query.dto'
import { FileDto } from '../../dto/file.dto'
import { getManyResponseFor } from '../../methods/spec'
import { File } from '../../entity/file.entity'


@Controller('files')
@ApiTags('files')
export class FilesController {
  constructor(private readonly filesService: FilesService) { }

  @Get()
  @ApiOperation({ summary: '搜尋 file entity' })
  @ApiOkResponse({ type: getManyResponseFor(File) })
  async queryGames(@Query() query: FileQueryDto): Promise<Object> {
    return await this.filesService.queryFiles(query);
  }

  @Get('/:file_id')
  @ApiOperation({ summary: '搜尋 file entity by id' })
  @ApiOkResponse({ type: File })
  async getGameById(@Param('file_id') file_id): Promise<Object> {
    return await this.filesService.findFile({ file_id });
  }

  @Post()
  @ApiOperation({ summary: '建立 file entity' })
  @UseGuards(JwtAuthGuard)
  @ApiHeader({ name: 'Authorization', description: 'JWT' })
  @ApiCreatedResponse({ type: File })
  async addFile(@Req() req, @Body() body: FileDto): Promise<Object> {
    body.created_by = req.payload.user_id
    return await this.filesService.addFile(body);
  }


  @Put('/:file_id')
  @ApiOperation({ summary: '修改 file entity' })
  @UseGuards(JwtAuthGuard)
  @ApiHeader({ name: 'Authorization', description: 'JWT' })
  @ApiCreatedResponse({ type: File })
  async updateFile(@Req() req, @Param('file_id') file_id, @Body() body): Promise<Object> {
    let file = await this.filesService.findFile({ file_id })
    if (file.created_by !== req.payload.user_id)
      throw new HttpException('only admin or file owner can update', HttpStatus.FORBIDDEN)

    return await this.filesService.updateFile(file_id, body);
  }

  @Put('/:file_id/content')
  @ApiOperation({ summary: '上傳 file content' })
  @ApiBody({description: 'use form-data, key "file"', })
  @UseGuards(JwtAuthGuard)
  @ApiHeader({ name: 'Authorization', description: 'JWT' })
  @UseInterceptors(FileInterceptor('file', {
    limits: {
      fieldSize: 1024 * 1024 * 20,
    }
  }))
  async updateFileContent(@Req() req, @Param('file_id') file_id, @UploadedFile() fileContent: Express.Multer.File): Promise<Object> {
    let file = await this.filesService.findFile({ file_id })
    if (!file)
      throw new HttpException('file not found', HttpStatus.BAD_REQUEST)
    if (file.created_by !== req.payload.user_id)
      throw new HttpException('only admin or file owner can update', HttpStatus.FORBIDDEN)

    return await this.filesService.updateFileContent(file, fileContent);
  }


  @Get('/:file_id/content')
  @ApiOperation({ summary: '下載 file content' })
  @UseGuards(JwtAuthGuard)
  @ApiHeader({ name: 'Authorization', description: 'JWT' })
  async getFileContent(@Req() req, @Param('file_id') file_id, @Res() res: Response): Promise<Object> {
    let file = await this.filesService.findFile({ file_id })
    if (!file)
      throw new HttpException('file not found', HttpStatus.BAD_REQUEST)
    if (!file.is_public && file.created_by !== req.payload.user_id)
      throw new HttpException('only file owner can acceess', HttpStatus.FORBIDDEN)

    let fileContent = await this.filesService.getFileContent(file);
    res.set({
      'Content-Type': fileContent.ContentType,
    });
    return res.send(fileContent.Body)
  }


  @Delete('/:file_id')
  @ApiOperation({ summary: '刪除 file' })
  @UseGuards(JwtAuthGuard)
  @ApiHeader({ name: 'Authorization', description: 'JWT' })
  async deleteFile(@Req() req, @Param('file_id') file_id): Promise<Object> {
    let file = await this.filesService.findFile({ file_id })
    if (!file)
      throw new HttpException('file not found', HttpStatus.BAD_REQUEST)
    if (file.created_by !== req.payload.user_id)
      throw new HttpException('only admin or file owner can update', HttpStatus.FORBIDDEN)

    return await this.filesService.deleteFile(file_id);
  }

}
