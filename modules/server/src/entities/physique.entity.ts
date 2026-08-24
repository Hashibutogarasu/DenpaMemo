import { Entity } from 'typeorm';
import { BaseEntity } from './base.entity';

/** Ports `lib/domain/master_data/physique.dart` (id-only). */
@Entity('physique')
export class PhysiqueEntity extends BaseEntity {}
