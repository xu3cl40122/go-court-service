import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { User } from '../../entity/user.entity';
import { Verification, VerificationType } from '../../entity/verification.entity';
import { generateVerificationCode } from '../../methods/'
import { MessageService } from '../message/message.service'
import * as dayjs from 'dayjs'
import * as bcrypt from 'bcrypt'

@Injectable()
export class UsersService {
  constructor(
    @InjectRepository(User) private usersRepository: Repository<User>,
    @InjectRepository(Verification) private verificationRepository: Repository<Verification>,
    private messageService: MessageService
  ) { }

  async addUser(userData: User, user_status = 'INITIAL'): Promise<Object> {
    const user = new User();
    let columns = [
      'profile_name',
      'email',
      'phone',
      'gender',
      'avatar_url',
      'description',
      'meta',
    ]
    columns.forEach(key => user[key] = userData[key])
    let saltRound = 10
    let hashedPwd = await bcrypt.hash(userData.password, saltRound)
    user.password = hashedPwd
    user.user_status = user_status
    return await this.usersRepository.save(user);
  }

  async sendVerification(email: string, verification_type: string, expireMinute = 5, resendMinute = 3) {
    let user = await this.findUser({ email })
    if (!user) throw 'user not found'
    if (verification_type === 'ENABLE_ACCOUNT' && user.user_status !== 'INITIAL') throw 'not initial user'

    let { user_id } = user
    let lastVerification = await this.findVerification({ user_id })
    if (lastVerification && !dayjs(lastVerification.created_at).add(resendMinute, 'minute').isBefore(dayjs()))
      throw 'request later'

    let verification_code = generateVerificationCode()
    let expires_at = dayjs().add(expireMinute, 'minute')
    let verifaction = new Verification({ user_id, verification_type, verification_code, expires_at })
    await this.verificationRepository.save(verifaction)
    return await this.messageService.sendMessage({
      ToAddresses: [user.email],
      template: 'VERIFY_EMAIL',
      args: { verification_code }
    })

  }

  async enableUser(email: string, verification_code: string) {
    let user = await this.findUser({ email })
    if (!user)
      throw 'user not found'
    let { user_id } = user
    let verification_type = 'ENABLE_ACCOUNT'
    let verification = await this.verificationRepository.findOne({
      where: { user_id, verification_type },
      order: { created_at: 'DESC' }
    })

    if (dayjs(verification.expires_at).isBefore(dayjs()))
      throw 'code expired'
    if (verification.verification_code !== verification_code)
      throw 'wrong verification code'

    return await this.usersRepository
      .createQueryBuilder()
      .update(User)
      .set({ user_status: 'ENABLED' })
      .where("user_id = :user_id", { user_id })
      .returning('*')
      .execute();
  }

  async editUser(user_id: string, userData: User): Promise<any> {
    let columns = [
      'profile_name',
      'phone',
      'gender',
      'avatar_url',
      'description',
      'meta',
    ]
    userData.meta = userData.meta ?? {}
    let changedPart = {}
    columns.forEach(key => userData[key] != null ? changedPart[key] = userData[key] : null)
    let { raw } = await this.usersRepository
      .createQueryBuilder()
      .update(User)
      .set(changedPart)
      .where("user_id = :user_id", { user_id })
      .returning('*')
      .execute();

    raw.forEach(user => delete user.password)
    return raw?.[0]
  }

  // async editUser(user_id: string, userData: User) {
  //   let user = await this.findUser({user_id})
  // }

  async queryUsers(reqQuery: { page, size }): Promise<Object> {
    let [page, size] = [Number(reqQuery.page ?? 0), Number(reqQuery.size ?? 10)]
    let [content, total] = await this.usersRepository.findAndCount({
      take: size,
      skip: page * size,
      order: {
        created_at: "DESC"
      }
    })

    let totalPage = Math.ceil(total / size)
    return { content, page, size, total, totalPage }
  }

  async findUser(query: { email?: string, user_id?: string }) {
    return await this.usersRepository.findOne(query)
  }

  async findUserWithPwd({ email }) {
    return await this.usersRepository
      .createQueryBuilder('user')
      .where("user.email = :email", { email })
      .addSelect("user.password")
      .getOne();
  }

  async findVerification(query: { user_id?: string, verification_id?: string }) {
    return await this.verificationRepository.findOne({
      where: query,
      order: { created_at: 'DESC' }
    })
  }

}