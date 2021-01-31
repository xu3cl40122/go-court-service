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

  async addUser(userData: User): Promise<Object> {
    const user = new User();
    let columns = [
      'profile_name',
      'email',
    ]
    columns.forEach(key => user[key] = userData[key])
    let saltRound = 10
    let hashedPwd = await bcrypt.hash(userData.password, saltRound)
    user.password = hashedPwd
    return await this.usersRepository.save(user);
  }

  async editUser(user_id: string, userData: User): Promise<any> {
    let columns = [
      'profile_name',
    ]
    let changedPart = {}
    columns.forEach(key => changedPart[key] = userData[key])
    let { raw, affected } = await this.usersRepository
      .createQueryBuilder()
      .update(User)
      .set(changedPart)
      .where("user_id = :user_id", { user_id })
      .returning('*')
      .execute();

    raw.forEach(user => delete user.email)
    return { raw, affected }
  }

  async queryUsers(reqQuery: { page, size }): Promise<Object> {
    let [page, size] = [Number(reqQuery.page), Number(reqQuery.size)]
    let [content, total] = await this.usersRepository.findAndCount({
      take: size,
      skip: page * size,
      order: {
        created_at: "DESC"
      }
    })

    return { content, page, size, total }
  }

  async findOne(queryObj: { email?: string, user_id?: string }) {
    return await this.usersRepository.findOne(queryObj)
  }

  async findUserWithPwd({ email }) {
    return await this.usersRepository
      .createQueryBuilder('user')
      .where("user.email = :email", { email })
      .addSelect("user.password")
      .getOne();
  }

}