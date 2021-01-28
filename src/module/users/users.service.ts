import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { User } from '../../entity/user.entity';
import * as bcrypt from 'bcrypt'

@Injectable()
export class UsersService {
  constructor(
    @InjectRepository(User) private usersRepository: Repository<User>,
  ) { }

  async addUser(reqBody: User): Promise<Object> {
    const user = new User();
    let columns = [
      'user_id',
      'profile_name',
      'email',
    ]
    columns.forEach(key => user[key] = reqBody[key])
    let saltRound = 10
    let hashedPwd = await bcrypt.hash(reqBody.password, saltRound)
    user.password = hashedPwd
    return await this.usersRepository.save(user);
  }
}