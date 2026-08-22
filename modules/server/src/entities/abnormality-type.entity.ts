import { Entity } from 'typeorm';
import { BaseEntity } from './base.entity';

/** Ports `lib/domain/master_data/abnormality_type.dart` (id-only). */
@Entity('abnormality_type')
export class AbnormalityTypeEntity extends BaseEntity {}
