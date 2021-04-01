import { Module } from '@nestjs/common';
import { FilesController } from './files.controller';
import { File } from '../../entity/file.entity';
import { TypeOrmModule } from '@nestjs/typeorm';
import { FilesService } from './files.service';

@Module({
  // 要把要用到 Repository import 進來
  imports: [
    TypeOrmModule.forFeature([File])
  ],
  controllers: [FilesController],
  providers: [FilesService]
})
export class FilesModule {}
