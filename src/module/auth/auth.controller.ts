import {
  Controller,
  Post,
  Body,
  Res,
  HttpException,
  HttpStatus
} from '@nestjs/common';
import { Response } from 'express';
import { UsersService } from '../users/users.service';
import { AuthService } from './auth.service';
import * as bcrypt from 'bcrypt'


@Controller('auth')
export class AuthController {
  constructor(
    private readonly usersService: UsersService,
    private readonly authService: AuthService
  ) { }

  @Post('/login')
  async login(@Body() body, @Res() res: Response) {
    let { email, password } = body
    let user = await this.usersService.findUserWithPwd({ email })
    if (!user)
      throw new HttpException('email not fund', HttpStatus.BAD_REQUEST)
    if (user.user_status === 'DISABLED')
      throw new HttpException('user is disabled', HttpStatus.FORBIDDEN)

    let isLoginSuccess = await bcrypt.compare(password, user.password).catch(() => false)
    if (!isLoginSuccess)
      throw new HttpException('password wrong', HttpStatus.UNAUTHORIZED)
    if (user.user_status === 'INITIAL')
      throw new HttpException('initial user should enable account before login', HttpStatus.NOT_ACCEPTABLE)

    let accessToken = this.authService.signAccessToken(user)
    res.append('Authorization', `Bearer ${accessToken}`)
    res.status(200).send()
  }
}