import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Court } from '../../entity/court.entity';

@Injectable()
export class CourtService {
  constructor(
    @InjectRepository(Court) private courtsRepository: Repository<Court>,
  ) { }

  async queryCourts(reqQuery: { page, size, city_code, dist_code }): Promise<Object> {
    let [page, size] = [Number(reqQuery.page ?? 0), Number(reqQuery.size ?? 10)]
    let where = {}
    let filters = ['city_code', 'dist_code']
    filters.forEach(key => reqQuery[key] ? where[key] = reqQuery[key] : '')

    let [content, total] = await this.courtsRepository.findAndCount({
      where,
      take: size,
      skip: page * size,
      order: {
        created_at: "DESC"
      }
    })

    return { content, page, size, total }
  }

  async addCourt(courtData: Court): Promise<Object> {
    const court = new Court();
    let columns = [
      'name',
      'address',
      'city_code',
      'dist_code',
      'latitude',
      'longitude',
      'phone',
      'logo_url',
      'description',
      'open_status',
    ]
    columns.forEach(key => court[key] = courtData[key])

    let { raw } = await this.courtsRepository
      .createQueryBuilder()
      .insert()
      .into('court')
      .values({
        ...court,
        geometry: () => `ST_SetSRID(ST_MakePoint(${court.longitude}, ${court.latitude}), 4326)`,
      })
      .returning('*')
      .execute();

    return raw[0]
  }

  async updateCourtById(court_id: string, courtData: Court): Promise<Object> {
    const court = new Court();
    let columns = [
      'name',
      'address',
      'city_code',
      'dist_code',
      'latitude',
      'longitude',
      'phone',
      'logo_url',
      'description',
      'open_status',
    ]
    columns.forEach(key => court[key] = courtData[key])

    let { raw } = await this.courtsRepository
      .createQueryBuilder()
      .update(Court)
      .set({
        ...court,
        geometry: () => `ST_SetSRID(ST_MakePoint(${court.longitude}, ${court.latitude}), 4326)`,
      })
      .where("court_id = :court_id", { court_id })
      .returning('*')
      .execute();

    return raw?.[0]
  }


}
