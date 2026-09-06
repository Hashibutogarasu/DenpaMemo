import { PrimaryColumn } from 'typeorm';

/**
 * Shared column for every master-data entity: the original JSON "id"
 * string, which is also this row's primary key. Seed loaders, the
 * GraphQL layer, and Flutter's `fromJson` mapping all key off it
 * directly, with no separate internally generated id.
 */
export abstract class BaseEntity {
  @PrimaryColumn({ type: 'varchar' })
  id!: string;
}
