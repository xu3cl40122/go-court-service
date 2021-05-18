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


@Controller('files')
export class FilesController {
  constructor(private readonly filesService: FilesService) { }

  @Get()
  @UseGuards(JwtAuthGuard)
  async queryGames(@Query() query): Promise<Object> {
    return await this.filesService.queryFiles(query);
  }

  @Get('/:file_id')
  @UseGuards(JwtAuthGuard)
  async getGameById(@Param('file_id') file_id): Promise<Object> {
    return await this.filesService.findFile({ file_id });
  }

  @Post()
  @UseGuards(JwtAuthGuard)
  async addFile(@Req() req, @Body() body): Promise<Object> {
    body.created_by = req.payload.user_id
    return await this.filesService.addFile(body);
  }

  @Put('/:file_id/content')
  @UseGuards(JwtAuthGuard)
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
  @UseGuards(JwtAuthGuard)
  async getFileContent(@Req() req, @Param('file_id') file_id,  @Res() res: Response): Promise<Object> {
    let file = await this.filesService.findFile({ file_id })
    if (!file)
      throw new HttpException('file not found', HttpStatus.BAD_REQUEST)
    if (!file.is_public && file.created_by !== req.payload.user_id)
      throw new HttpException('only file owner can acceess', HttpStatus.FORBIDDEN)

    let fileContent =  await this.filesService.getFileContent(file);
    res.set({
      'Content-Type': fileContent.ContentType,
    });
    return res.send(fileContent.Body)
  }

  @Put('/:file_id')
  @UseGuards(JwtAuthGuard)
  async updateFile(@Req() req, @Param('file_id') file_id, @Body() body): Promise<Object> {
    let file = await this.filesService.findFile({ file_id })
    if (file.created_by !== req.payload.user_id)
      throw new HttpException('only admin or file owner can update', HttpStatus.FORBIDDEN)

    return await this.filesService.updateFile(file_id, body);
  }

  @Delete('/:file_id')
  @UseGuards(JwtAuthGuard)
  async deleteFile(@Req() req, @Param('file_id') file_id): Promise<Object> {
    let file = await this.filesService.findFile({ file_id })
    if (!file)
      throw new HttpException('file not found', HttpStatus.BAD_REQUEST)
    if (file.created_by !== req.payload.user_id)
      throw new HttpException('only admin or file owner can update', HttpStatus.FORBIDDEN)

    return await this.filesService.deleteFile(file_id);
  }


}
