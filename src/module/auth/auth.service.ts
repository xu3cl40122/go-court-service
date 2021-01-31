import { Injectable } from '@nestjs/common';
import { UsersService } from '../users/users.service';
import { JwtService } from '@nestjs/jwt';
import { User } from '../../entity/user.entity';


@Injectable()
export class AuthService {
  constructor(
    private usersService: UsersService,
    private jwtService: JwtService
    ) { }

  signAccessToken(user: User) {
    const payload = { email: user.email, user_id: user.user_id };
    return this.jwtService.sign(payload)
  }

}