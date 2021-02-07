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
} from '@nestjs/common';
import { UsersService } from './users.service';
import { MessageService } from '../message/message.service';
import { JwtAuthGuard } from '../auth/jwt.guard';

@Controller()
export class UserController {
  constructor(
    private readonly userService: UsersService,
    private readonly messageService: MessageService
  ) { }

  @Post('register')
  async register(@Body() reqBody) {
    return this.userService.addUser(reqBody)
      .catch(error => {
        if (error.code === '23505')
          throw new HttpException('duplicate email', HttpStatus.BAD_REQUEST)
        throw new HttpException('INTERNAL_SERVER_ERROR', HttpStatus.INTERNAL_SERVER_ERROR)
      })
  }

  // 發 email 驗證碼
  @Put('users/verification')
  @UseGuards(JwtAuthGuard)
  async sendVerification(@Req() req) {
    let verification_type = 'ENABLE_ACCOUNT'
    return this.userService.sendVerification(req.payload.user_id, verification_type)
      .catch(error => {
        if (error === 'not initial user')
          throw new HttpException(error, HttpStatus.BAD_REQUEST)
        if (error === 'request later')
          throw new HttpException(error, HttpStatus.BAD_REQUEST)
      })
  }

  // 透過 email 驗證碼啟用帳號
  @Put('users/enable')
  @UseGuards(JwtAuthGuard)
  async enableUser(@Req() req, @Body() body) {
    let { verification_code } = body

    return this.userService.enableUser(req.payload.user_id, verification_code)
      .catch(error => {
        if (error === 'code expired')
          throw new HttpException(error, HttpStatus.BAD_REQUEST)
        if (error === 'wrong verification code')
          throw new HttpException(error, HttpStatus.BAD_REQUEST)
      })
  }

  @Get('profile')
  @UseGuards(JwtAuthGuard)
  async getSelfProfile(@Req() req): Promise<Object> {
    return this.userService.findUser({ user_id: req.payload.user_id })
  }

  @Put('profile')
  @UseGuards(JwtAuthGuard)
  async updateSelfProfile(@Req() req, @Body() userData): Promise<Object> {
    let { raw, affected } = await this.userService.editUser(req.payload.user_id, userData);
    if (affected === 0 || !raw?.[0])
      throw new HttpException('user_id not found', HttpStatus.BAD_REQUEST)
    return raw[0]
  }

  @Get('users')
  @UseGuards(JwtAuthGuard)
  async queryUsers(@Query() reqQuery): Promise<Object> {
    return this.userService.queryUsers(reqQuery);
  }

  @Get('users/:user_id')
  @UseGuards(JwtAuthGuard)
  async user(@Param('user_id') user_id: string): Promise<Object> {
    return this.userService.findUser({ user_id })
  }

  @Put('users/:user_id')
  @UseGuards(JwtAuthGuard)
  async updateUserById(@Param('user_id') id: string, @Body() userData): Promise<Object> {
    let user = await this.userService.editUser(id, userData);
    if (!user) throw new HttpException('user_id not found', HttpStatus.BAD_REQUEST)

    return user
  }

  // @Delete('user/:userId')
  // async deleteUserById(@Param('userId') id: number): Promise<Object> {
  //   return this.userService.deleteUserById(id);
  // }
}