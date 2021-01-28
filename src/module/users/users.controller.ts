import {
  Controller,
  Get,
  Post,
  Put,
  Delete,
  Param,
  Body
} from '@nestjs/common';
import { UsersService } from './users.service';

@Controller('users')
export class UserController {
  constructor(
    private readonly userService: UsersService
  ) { }

  @Get()
  async allUsers(): Promise<Object> {
    return 'users'
    // return this.userService.getAllUser();
  }

  // @Get('user/:userId')
  // async user(@Param('userId') id: number): Promise<Object> {
  //   return this.userService.getUserById(id);
  // }

  @Post()
  async addUser(@Body() reqBody): Promise<Object> {
    return this.userService.addUser(reqBody)
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