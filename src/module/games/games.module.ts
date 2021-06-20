import { Module, forwardRef } from '@nestjs/common';
import { GamesService } from './games.service';
import { GamesController } from './games.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { UsersModule } from '../users/users.module';
import { TicketsModule } from '../tickets/tickets.module';
import { Game } from '../../entity/game.entity';
import { GameUser } from '../../entity/game_user.entity';
import { GameTicket } from '../../entity/game_ticket.entity';
import { GameStock } from '../../entity/game_stock.entity';

@Module({
  // 要把要用到 Repository import 進來
  imports: [
    UsersModule,
    forwardRef(() => TicketsModule),
    TypeOrmModule.forFeature([Game, GameUser, GameTicket, GameStock])
  ],
  providers: [GamesService],
  controllers: [GamesController],
  exports: [GamesService]
})
export class GamesModule { }
