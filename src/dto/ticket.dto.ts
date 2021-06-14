import { ApiProperty } from '@nestjs/swagger';
import { IsUUID } from 'class-validator';
export class TransferTicketDto {
  @IsUUID()
  @ApiProperty({ required: false })
  receiver_id?: string

}



