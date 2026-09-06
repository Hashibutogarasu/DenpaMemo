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
import { MajorCategoryEntity } from '../entities/major-category.entity';
import { MinorCategoryEntity } from '../entities/minor-category.entity';
import { MonsterEntity } from '../entities/monster.entity';
import { PatternEntity } from '../entities/pattern.entity';
import { PersonalityEntity } from '../entities/personality.entity';
import { PhysiqueAntennaCategoryAntennaEntity } from '../entities/physique-antenna-category-antenna.entity';
import { PhysiqueAntennaCategoryEntity } from '../entities/physique-antenna-category.entity';
import { PhysiqueEvasionRateTableEntity } from '../entities/physique-evasion-rate-table.entity';
import { PhysiqueStatusCategoryEntity } from '../entities/physique-status-category.entity';
import { PhysiqueTableEntity } from '../entities/physique-table.entity';
import { PhysiqueEntity } from '../entities/physique.entity';
import { TableDefinitionEntity } from '../entities/table-definition.entity';
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
    MajorCategoryEntity,
    MinorCategoryEntity,
    MonsterEntity,
    PatternEntity,
    PersonalityEntity,
    PhysiqueAntennaCategoryAntennaEntity,
    PhysiqueAntennaCategoryEntity,
    PhysiqueEntity,
    PhysiqueEvasionRateTableEntity,
    PhysiqueStatusCategoryEntity,
    PhysiqueTableEntity,
    TableDefinitionEntity,
    TargetModeEntity,
    TranslationEntity,
  ],
  migrations: ['src/migrations/*.ts'],
});
