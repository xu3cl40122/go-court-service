import {
  Controller,
  Get,
  Post,
  Put,
  Delete,
  Param,
  Body,
  Query,
  UseFilters,
  HttpException,
  HttpStatus,
  UseGuards,
  Req,
} from '@nestjs/common';
import { UsersService } from './users.service';
import { JwtAuthGuard } from '../auth/jwt.guard';

@Controller()
export class UserController {
  constructor(
    private readonly userService: UsersService
  ) { }

  @Get('profile')
  @UseGuards(JwtAuthGuard)
  async getSelfProfile(@Req() req): Promise<Object> {
    console.log('req', req.payload)
    return 'profile'
    // return this.userService.findOne(reqQuery);
  }

  @Get('users')
  async queryUsers(@Query() reqQuery): Promise<Object> {
    return this.userService.queryUsers(reqQuery);
  }

  // @Get('user/:userId')
  // async user(@Param('userId') id: number): Promise<Object> {
  //   return this.userService.getUserById(id);
  // }

  @Post('users')
  async register(@Body() reqBody) {
    return this.userService.addUser(reqBody)
      .catch(error => {
        if (error.code === '23505')
          throw new HttpException('duplicate email', HttpStatus.BAD_REQUEST)
        throw new HttpException('INTERNAL_SERVER_ERROR', HttpStatus.INTERNAL_SERVER_ERROR)
      })
  }

  // @Put('user/:userId')
  // async updateUserById(
  //   @Param('userId') id: number,
  //   @Body() userData,
  // ): Promise<Object> {
  //   return this.userService.updateUserById(id, userData);
  // }

  // @Delete('user/:userId')
  // async deleteUserById(@Param('userId') id: number): Promise<Object> {
  //   return this.userService.deleteUserById(id);
  // }
}