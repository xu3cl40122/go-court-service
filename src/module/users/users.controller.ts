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

  // admin create user (省略驗證 email)
  @Post('admin/users')
  @UseGuards(JwtAuthGuard)
  async adminAddUser(@Req() req, @Body() reqBody) {
    if (req.payload.user_role !== 'ADMIN')
      throw new HttpException('permission denied', HttpStatus.FORBIDDEN)
    return this.userService.addUser(reqBody, 'ENABLED')
      .catch(error => {
        if (error.code === '23505')
          throw new HttpException('duplicate email', HttpStatus.BAD_REQUEST)
        throw new HttpException('INTERNAL_SERVER_ERROR', HttpStatus.INTERNAL_SERVER_ERROR)
      })
  }

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
  async sendVerification(@Body() reqBody) {
    let verification_type = 'ENABLE_ACCOUNT'
    return this.userService.sendVerification(reqBody.email, verification_type)
      .catch(error => {
        if (error === 'user not found')
          throw new HttpException(error, HttpStatus.BAD_REQUEST)
        if (error === 'not initial user')
          throw new HttpException(error, HttpStatus.BAD_REQUEST)
        if (error === 'request later')
          throw new HttpException(error, HttpStatus.NOT_ACCEPTABLE)
        throw new HttpException('INTERNAL_SERVER_ERROR', HttpStatus.INTERNAL_SERVER_ERROR)
      })
  }

  // 透過 email 驗證碼啟用帳號
  @Put('users/enable')
  async enableUser(@Req() req, @Body() body: { verification_code, email }) {
    let { verification_code, email } = body

    return this.userService.enableUser(email, verification_code)
      .catch(error => {
        if (error === 'user not found')
          throw new HttpException(error, HttpStatus.BAD_REQUEST)
        if (error === 'code expired')
          throw new HttpException(error, HttpStatus.NOT_ACCEPTABLE)
        if (error === 'wrong verification code')
          throw new HttpException(error, HttpStatus.BAD_REQUEST)
        throw new HttpException('INTERNAL_SERVER_ERROR', HttpStatus.INTERNAL_SERVER_ERROR)
      })
  }

  // 發 email 驗證碼
  @Put('forgot/verification')
  async forgotPassword(@Body() reqBody) {
    let verification_type = 'FORGOT_PASSWORD'
    return this.userService.sendVerification(reqBody.email, verification_type)
      .catch(error => {
        if (error === 'user not found')
          throw new HttpException(error, HttpStatus.BAD_REQUEST)
        if (error === 'request later')
          throw new HttpException(error, HttpStatus.NOT_ACCEPTABLE)
        throw new HttpException('INTERNAL_SERVER_ERROR', HttpStatus.INTERNAL_SERVER_ERROR)
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
    let res = await this.userService.editUser(req.payload.user_id, userData);
    if (!res)
      throw new HttpException('user_id not found', HttpStatus.BAD_REQUEST)
    return res
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