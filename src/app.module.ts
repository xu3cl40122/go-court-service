import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { TypeOrmModule, } from '@nestjs/typeorm'
import { Connection, getConnectionOptions } from 'typeorm';
import { UsersModule } from './module/users/users.module'
import { AuthModule } from './module/auth/auth.module'
import { ConfigModule } from '@nestjs/config';
import { CourtModule } from './module/courts/courts.module';
import { GamesModule } from './module/games/games.module';
import { MessageModule } from './module/message/message.module';
import { FilesModule } from './module/files/files.module';
import { TicketsModule } from './module/tickets/tickets.module';
import { ScheduleModule } from '@nestjs/schedule';
import { RedisModule } from 'nestjs-redis'

import * as AWS from 'aws-sdk';

@Module({
  imports: [
    TypeOrmModule.forRootAsync({
      useFactory: async () => {
        let setting = await getConnectionOptions()
        console.log('process.env.NODE_ENV', process.env.NODE_ENV)
        return Object.assign(setting, {
          // 只有在開發模式啟用同步 避免損害 production 資料
          synchronize: process.env.NODE_ENV === 'development',
        })
      }
    }),
    // can get env setting
    ConfigModule.forRoot({
      isGlobal: true,
      envFilePath: 'app.env'
    }),

    RedisModule.forRootAsync({
      useFactory: async () => {
        return {
          host: process.env.REDIS_HOST,
          port: Number(process.env.REDIS_PORT),
        }
      }
    }),

    ScheduleModule.forRoot(),
    UsersModule,
    AuthModule,
    CourtModule,
    GamesModule,
    MessageModule,
    FilesModule,
    TicketsModule,
    RedisModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {
  constructor(private connection: Connection) {
    AWS.config.loadFromPath('./aws.config.json');
  }
}
