import { Module, forwardRef } from '@nestjs/common';
import { TicketsController } from './tickets.controller';
import { TicketsService } from './tickets.service';
import { GamesModule } from '../games/games.module'
import { TypeOrmModule } from '@nestjs/typeorm';
import { Game } from '../../entity/game.entity';
import { GameUser } from '../../entity/game_user.entity';
import { GameTicket } from '../../entity/game_ticket.entity';
import { GameStock } from '../../entity/game_stock.entity';
import { UsersModule } from '../users/users.module'

@Module({
  imports: [
    UsersModule,
    // 解決 module 循環引用問題
    forwardRef(() => GamesModule),
    TypeOrmModule.forFeature([Game, GameUser, GameTicket, GameStock])
  ],
  controllers: [TicketsController],
  providers: [TicketsService],
  // 要給別的 module 用的部分
  exports: [TicketsService]
})
export class TicketsModule { }
