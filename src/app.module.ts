import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { TypeOrmModule } from '@nestjs/typeorm'
import { Connection } from 'typeorm';
import { UsersModule } from './module/users/users.module'
import { AuthModule } from './module/auth/auth.module'
import { ConfigModule } from '@nestjs/config';
import { CourtModule } from './module/courts/courts.module';
import { GamesModule } from './module/games/games.module';
import { MessageModule } from './module/message/message.module';

@Module({
  imports: [
    TypeOrmModule.forRoot(),
    // can get env setting
    ConfigModule.forRoot({
      isGlobal: true,
      envFilePath: 'app.env'
    }),
   
    UsersModule,
    AuthModule,
    CourtModule,
    GamesModule,
    MessageModule
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {
  constructor(private connection: Connection) {}
}
