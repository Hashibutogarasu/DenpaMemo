import { Entity } from 'typeorm';
import { BaseEntity } from './base.entity';

/** Ports `lib/domain/master_data/pattern.dart` (id-only). */
@Entity('pattern')
export class PatternEntity extends BaseEntity {}
