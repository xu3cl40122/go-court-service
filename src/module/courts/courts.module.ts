import { Module } from '@nestjs/common';
import { CourtService } from './courts.service';
import { CourtController } from './courts.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Court } from '../../entity/court.entity';

@Module({
  // 要把要用到 Repository import 進來
  imports: [TypeOrmModule.forFeature([Court])],
  providers: [CourtService],
  controllers: [CourtController]
})
export class CourtModule {}
