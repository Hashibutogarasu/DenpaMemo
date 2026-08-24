import 'reflect-metadata';
import { DataSource } from 'typeorm';
import { env } from './env';
import { AbnormalityTypeEntity } from '../entities/abnormality-type.entity';
import { AnntenaEntity } from '../entities/anntena.entity';
import { AntennaCategoryEntity } from '../entities/antenna-category.entity';
import { AttributeEntity } from '../entities/attribute.entity';
import { AttributeBonusEntity } from '../entities/attribute-bonus.entity';
import { AttributeCategoryEntity } from '../entities/attribute-category.entity';
import { BodyColorAbnormalityResistanceRuleEntity } from '../entities/body-color-abnormality-resistance-rule.entity';
import { BodyColorResistanceRuleEntity } from '../entities/body-color-resistance-rule.entity';
import { CorrectionEntity } from '../entities/correction.entity';
import { HeadShapeEntity } from '../entities/head-shape.entity';
import { PatternEntity } from '../entities/pattern.entity';
import { PersonalityEntity } from '../entities/personality.entity';
import { PhysiqueEntity } from '../entities/physique.entity';
import { TargetModeEntity } from '../entities/target-mode.entity';
import { TranslationEntity } from '../entities/translation.entity';

export const AppDataSource = new DataSource({
  type: 'postgres',
  url: env.DATABASE_URL,
  synchronize: false,
  logging: false,
  entities: [
    AbnormalityTypeEntity,
    AnntenaEntity,
    AntennaCategoryEntity,
    AttributeEntity,
    AttributeBonusEntity,
    AttributeCategoryEntity,
    BodyColorAbnormalityResistanceRuleEntity,
    BodyColorResistanceRuleEntity,
    CorrectionEntity,
    HeadShapeEntity,
    PatternEntity,
    PersonalityEntity,
    PhysiqueEntity,
    TargetModeEntity,
    TranslationEntity,
  ],
  migrations: ['src/migrations/*.ts'],
});
