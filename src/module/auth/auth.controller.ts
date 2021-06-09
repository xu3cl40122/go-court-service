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
import { LoginDto, AuthLoginDto } from '../../dto/login.dto'
import { UserDto } from '../../dto/user.dto'
import { ApiOkResponse, ApiCreatedResponse, ApiHeader, ApiTags, ApiOperation, ApiQuery } from '@nestjs/swagger';


@Controller('auth')
@ApiTags('auth')
export class AuthController {
  constructor(
    private readonly usersService: UsersService,
    private readonly authService: AuthService
  ) { }

  @Post('/login')
  @ApiOperation({ summary: '登入' })
  @ApiOkResponse({ description: 'JWT 放在 response header 的 Authorization' })
  async login(@Body() body: LoginDto, @Res() res: Response) {
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

  @Post('/social_login')
  @ApiOperation({ summary: '第三方登入' })
  @ApiOkResponse({ description: 'JWT 放在 response header 的 Authorization' })
  async authLogin(@Body() body: AuthLoginDto, @Res() res: Response) {
    let { email, profile_name, external_id, meta, register_by } = body
    let user = await this.usersService.findUserWithPwd({ email })
    // 第一次第三方登入的話先建立 user entity
    if (!user) {
      let userData: UserDto = {
        email,
        profile_name,
        external_id,
        password: external_id,
        register_by,
        meta
      }
      user = await this.usersService.addUser(userData)
    }

 

    let accessToken = this.authService.signAccessToken(user)
    res.append('Authorization', `Bearer ${accessToken}`)
    res.status(200).send()
  }
}