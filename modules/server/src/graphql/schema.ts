import { createSchema } from 'graphql-yoga';
import type { DataSource } from 'typeorm';
import { resolveMasterData } from './resolvers/master-data.resolver';
import { resolveMonsters } from './resolvers/monster.resolver';
import { resolveTranslations } from './resolvers/translation.resolver';
import { resolveCalculateResistances } from './resolvers/calculate.resolver';

const typeDefs = `
  type AttributeCategoryType {
    code: Int!
    name: String!
  }

  type Attribute {
    id: String!
    legacyId: String!
    index: Int!
    category: AttributeCategoryType!
    resistantTo: [Attribute!]!
    weakTo: [Attribute!]!
  }

  type AttributeBonus {
    attribute: Attribute!
    bonus: Int!
  }

  type AntennaCategoryType {
    code: Int!
    name: String!
  }

  type TargetModeType {
    code: Int!
    name: String!
  }

  type Anntena {
    id: String!
    legacyId: String!
    category: AntennaCategoryType!
    targetCount: Int
    targetMode: TargetModeType
    dealsDamage: Boolean!
    attackAttributes: [Attribute!]!
    isInheritable: Boolean!
    evolvesToId: String
    maxLevel: Int
    variantGroupId: String
    hasLevel: Boolean!
  }

  type HeadShape {
    id: String!
    legacyId: String!
    abnormalityResistanceBonuses: JSON!
    attributeResistanceBonuses: [AttributeBonus!]!
    hpBonus: Int!
    apBonus: Int!
    attackBonus: Int!
    defenseBonus: Int!
    speedBonus: Int!
    evasionRateBonus: Int!
  }

  type AbnormalityType {
    id: String!
    legacyId: String!
  }

  type BodyColorResistanceRule {
    id: String!
    legacyId: String!
    attributeResistanceBonuses: [AttributeBonus!]!
  }

  type BodyColorAbnormalityResistanceRule {
    id: String!
    legacyId: String!
    abnormalityResistanceBonuses: JSON!
  }

  type Physique {
    id: String!
    legacyId: String!
  }

  type Personality {
    id: String!
    legacyId: String!
  }

  type Pattern {
    id: String!
    legacyId: String!
  }

  type PhysiqueAntennaCategory {
    category: String!
    anntenaCategory: String!
  }

  type PhysiqueStatusCategory {
    name: String!
    columnCount: Int!
  }

  type PhysiqueAntennaCategoryAntennaLink {
    majorCategoryId: String!
    minorCategoryId: String!
    antennaName: String!
  }

  type Correction {
    id: String!
    legacyId: String!
    hpBonus: Int!
    apBonus: Int!
    attackBonus: Int!
    defenseBonus: Int!
    speedBonus: Int!
    evasionRateBonus: Int!
    abnormalityResistanceBonuses: JSON!
  }

  type MasterData {
    headShapes: [HeadShape!]!
    anntenas: [Anntena!]!
    attributes: [Attribute!]!
    abnormalityTypes: [AbnormalityType!]!
    bodyColorResistanceRules: [BodyColorResistanceRule!]!
    bodyColorAbnormalityResistanceRules: [BodyColorAbnormalityResistanceRule!]!
    physiques: [Physique!]!
    personalities: [Personality!]!
    patterns: [Pattern!]!
    corrections: [Correction!]!
    physiqueAntennaCategories: [PhysiqueAntennaCategory!]!
    physiqueStatusCategories: [PhysiqueStatusCategory!]!
    physiqueAntennaCategoryAntennaLinks: [PhysiqueAntennaCategoryAntennaLink!]!
  }

  type Translation {
    entityLegacyId: String!
    value: String!
  }

  type Monster {
    id: String!
    translateKey: String!
  }

  type AttributeResistance {
    attributeId: String!
    value: Int!
  }

  type AbnormalityResistance {
    abnormalityId: String!
    value: Int!
  }

  type DenpaMenResistances {
    abnormalityResistances: [AbnormalityResistance!]!
    attributeResistance: [AttributeResistance!]!
  }

  input HeadShapeResistanceBonusInput {
    attributeId: String!
    bonus: Int!
  }

  input HeadShapeResistanceInput {
    abnormalityResistanceBonuses: JSON!
    attributeResistanceBonuses: [HeadShapeResistanceBonusInput!]!
  }

  input ResistanceInput {
    bodyColors: [String!]!
    isSpColor: Boolean!
    headShape: HeadShapeResistanceInput!
  }

  scalar JSON

  type Query {
    masterData: MasterData!
    monsters: [Monster!]!
    translations(map: String!, locale: String = "ja"): [Translation!]!
    calculateResistances(input: ResistanceInput!): DenpaMenResistances!
  }
`;

export function buildSchema(dataSource: DataSource) {
  return createSchema({
    typeDefs,
    resolvers: {
      JSON: {
        __serialize: (value: unknown) => value,
        __parseValue: (value: unknown) => value,
        __parseLiteral: () => {
          throw new Error('JSON literal parsing is not supported');
        },
      },
      Query: {
        masterData: () => resolveMasterData(dataSource),
        monsters: () => resolveMonsters(dataSource),
        translations: (_parent: unknown, args: { map: string; locale: string }) =>
          resolveTranslations(dataSource, args.map, args.locale),
        calculateResistances: (_parent: unknown, args: Parameters<typeof resolveCalculateResistances>[1]) =>
          resolveCalculateResistances(dataSource, args),
      },
    },
  });
}
