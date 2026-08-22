import { Entity } from 'typeorm';
import { BaseEntity } from './base.entity';

/** Ports `lib/domain/master_data/personality.dart` (id-only). */
@Entity('personality')
export class PersonalityEntity extends BaseEntity {}
