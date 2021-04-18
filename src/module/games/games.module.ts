import { Module } from '@nestjs/common';
import { GamesService } from './games.service';
import { GamesController } from './games.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { UsersModule } from '../users/users.module';
import { Game } from '../../entity/game.entity';
import { GameUser } from '../../entity/game_user.entity';
import { GameTicket } from '../../entity/game_ticket.entity';
import { GameStock } from '../../entity/game_stock.entity';

@Module({
  // 要把要用到 Repository import 進來
  imports: [
    UsersModule,
    TypeOrmModule.forFeature([Game, GameUser, GameTicket, GameStock])
  ],
  providers: [GamesService],
  controllers: [GamesController]
})
export class GamesModule { }
