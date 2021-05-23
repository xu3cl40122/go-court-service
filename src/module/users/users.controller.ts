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
import { UserDto, PasswordDto } from '../../dto/user.dto'
import { VerificationDto, SendEmailDto } from '../../dto/verification.dto'
import { User } from '../../entity/user.entity';
import { ApiOkResponse, ApiCreatedResponse, ApiHeader, ApiTags, ApiOperation, ApiQuery } from '@nestjs/swagger';
import { getManyResponseFor } from '../../methods/spec'
import { PageQueryDto } from '../../dto/query.dto'

@ApiTags('users')
@Controller()
export class UserController {
  constructor(
    private readonly userService: UsersService,
    private readonly messageService: MessageService
  ) { }

  // admin create user (省略驗證 email)
  @Post('admin/users')
  @ApiOperation({ summary: 'Admin 建立使用者(省略 email 驗證)' })
  @UseGuards(JwtAuthGuard)
  @ApiHeader({ name: 'Authorization', description: 'JWT' })
  @ApiCreatedResponse({ type: User })
  async adminAddUser(@Req() req, @Body() reqBody: UserDto): Promise<User> {
    if (req.payload.user_role !== 'ADMIN')
      throw new HttpException('permission denied', HttpStatus.FORBIDDEN)
    return this.userService.addUser(reqBody, 'ENABLED')
      .catch(error => {
        if (error.code === '23505')
          throw new HttpException('duplicate email', HttpStatus.BAD_REQUEST)
        throw new HttpException('INTERNAL_SERVER_ERROR', HttpStatus.INTERNAL_SERVER_ERROR)
      })
  }

  @Put('admin/users/:user_id')
  @ApiOperation({ summary: 'Admin 修改使用者' })
  @UseGuards(JwtAuthGuard)
  @ApiHeader({ name: 'Authorization', description: 'JWT' })
  @ApiOkResponse({ type: User })
  async adminUpdateUser(@Req() req, @Param('user_id') id: string, @Body() userData): Promise<Object> {
    if (req.payload.user_role !== 'ADMIN')
      throw new HttpException('permission denied', HttpStatus.FORBIDDEN)
    let user = await this.userService.editUser(id, userData);
    if (!user) throw new HttpException('user_id not found', HttpStatus.BAD_REQUEST)

    return user
  }

  @Delete('admin/users/:user_id')
  @ApiOperation({ summary: 'admin 停用帳號' })
  @UseGuards(JwtAuthGuard)
  @ApiHeader({ name: 'Authorization', description: 'JWT' })
  @ApiOkResponse({ type: User })
  async adminDisableUser(@Req() req, @Param('user_id') user_id) {
    if (req.payload.user_role !== 'ADMIN')
      throw new HttpException('permission denied', HttpStatus.FORBIDDEN)
    return this.userService.deleteUser(user_id)
  }

  @Post('register')
  @ApiOperation({ summary: '註冊帳號(產生的 user entity 需透過 email 驗證才能啟用)' })
  @ApiCreatedResponse({ type: User })
  async register(@Body() reqBody: UserDto): Promise<User> {
    return this.userService.addUser(reqBody)
      .catch(error => {
        if (error.code === '23505')
          throw new HttpException('duplicate email', HttpStatus.BAD_REQUEST)
        throw new HttpException('INTERNAL_SERVER_ERROR', HttpStatus.INTERNAL_SERVER_ERROR)
      })
  }

  @Put('users/verification')
  @ApiOperation({ summary: '發送啟用帳號驗證信' })
  async sendVerification(@Body() reqBody: SendEmailDto) {
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

  @Put('users/enable')
  @ApiOperation({ summary: '用驗證碼啟用帳號' })
  async enableUser(@Req() req, @Body() body: VerificationDto) {
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

  @Put('users/password')
  @ApiOperation({ summary: '變更密碼' })
  @UseGuards(JwtAuthGuard)
  @ApiHeader({ name: 'Authorization', description: 'JWT' })
  async changePassword(@Req() req, @Body() body: PasswordDto) {
    let user = await this.userService.findUserWithPwd({ user_id: req.payload.user_id })
    return this.userService.changePassword(user, body)
  }

  // // 發 email 驗證碼
  // @Put('forgot/verification')
  // async forgotPassword(@Body() reqBody) {
  //   let verification_type = 'FORGOT_PASSWORD'
  //   return this.userService.sendVerification(reqBody.email, verification_type)
  //     .catch(error => {
  //       if (error === 'user not found')
  //         throw new HttpException(error, HttpStatus.BAD_REQUEST)
  //       if (error === 'request later')
  //         throw new HttpException(error, HttpStatus.NOT_ACCEPTABLE)
  //       throw new HttpException('INTERNAL_SERVER_ERROR', HttpStatus.INTERNAL_SERVER_ERROR)
  //     })
  // }

  @Get('profile')
  @ApiOperation({ summary: '取得登入帳號 profile' })
  @UseGuards(JwtAuthGuard)
  @ApiHeader({ name: 'Authorization', description: 'JWT' })
  @ApiOkResponse({ type: User })
  async getSelfProfile(@Req() req): Promise<User> {
    return this.userService.findUser({ user_id: req.payload.user_id })
  }

  @Put('profile')
  @ApiOperation({ summary: '修改登入帳號 profile' })
  @UseGuards(JwtAuthGuard)
  @ApiHeader({ name: 'Authorization', description: 'JWT' })
  @ApiOkResponse({ type: User })
  async updateSelfProfile(@Req() req, @Body() userData): Promise<Object> {
    let res = await this.userService.editUser(req.payload.user_id, userData);
    if (!res)
      throw new HttpException('user_id not found', HttpStatus.BAD_REQUEST)
    return res
  }

  @Get('users')
  @ApiOperation({ summary: '查詢所有使用者' })
  @UseGuards(JwtAuthGuard)
  @ApiHeader({ name: 'Authorization', description: 'JWT' })
  @ApiQuery({ name: 'page', type: Number, required: false })
  @ApiQuery({ name: 'size', type: Number, required: false })
  @ApiOkResponse({ type: getManyResponseFor(User) })
  async queryUsers(@Query() reqQuery: PageQueryDto): Promise<Object> {
    return this.userService.queryUsers(reqQuery);
  }

  @Get('users/:user_id')
  @ApiOperation({ summary: '用 user_id 取回使用者' })
  @UseGuards(JwtAuthGuard)
  @ApiHeader({ name: 'Authorization', description: 'JWT' })
  @ApiOkResponse({ type: User })
  async user(@Param('user_id') user_id: string): Promise<Object> {
    return this.userService.findUser({ user_id })
  }

  @Delete('users')
  @ApiOperation({ summary: '停用自己的帳號' })
  @UseGuards(JwtAuthGuard)
  @ApiHeader({ name: 'Authorization', description: 'JWT' })
  @ApiOkResponse({ type: User })
  async disableSelfUser(@Req() req) {
    let sender_id = req.payload.user_id
    return this.userService.deleteUser(sender_id)
  }
}