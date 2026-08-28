import 'package:data_pack/data_pack.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../domain/master_data/master_data_load_error.dart';
import 'master_data_graphql_queries.dart';

/// [MasterDataRepository] implementation backed by the `modules/server`
/// GraphQL API, replacing the JSON-asset-bundled
/// `JsonMasterDataRepository`. Every server type carries both a
/// server-only cuid `id` and a `legacyId` (the original semantic id the
/// JSON assets used, e.g. `"beam_all"`, `"blue"`); this repository maps
/// `legacyId` onto each Freezed model's `id` field, so domain code that
/// already looks entities up by that id (e.g.
/// `masterData.headShapes.firstWhere((h) => h.id == ...)`) is unaffected.
///
/// Each model is built through its own `fromJson` (reusing
/// `json_serializable`'s generated parsing) with the reshaped GraphQL map,
/// then `copyWith` fills in fields `fromJson` intentionally excludes
/// (`attributeResistanceBonuses`, `attackAttributes`, `resistantTo`,
/// `weakTo`) with the already-resolved nested objects the server returned
/// — mirroring how `JsonMasterDataRepository` resolves those from raw id
/// lists today.
class GraphqlMasterDataRepository implements MasterDataRepository {
  GraphqlMasterDataRepository({required GraphQLClient client})
    : _client = client;

  final GraphQLClient _client;

  @override
  Future<MasterData> load() async {
    final result = await _client.query(
      QueryOptions(
        document: gql(masterDataQuery),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      throw MasterDataLoadError.fromOperationException(result.exception!);
    }

    final masterData = result.data!['masterData'] as Map<String, dynamic>;

    final attributes = [
      for (final json in masterData['attributes'] as List<dynamic>)
        _attributeFromGraphql(json as Map<String, dynamic>),
    ];

    return MasterData(
      headShapes: [
        for (final json in masterData['headShapes'] as List<dynamic>)
          _headShapeFromGraphql(json as Map<String, dynamic>),
      ],
      anntenas: [
        for (final json in masterData['anntenas'] as List<dynamic>)
          _anntenaFromGraphql(json as Map<String, dynamic>),
      ],
      attributes: attributes,
      abnormalityTypes: [
        for (final json in masterData['abnormalityTypes'] as List<dynamic>)
          AbnormalityType.fromJson({'id': json['legacyId']}),
      ],
      bodyColorResistanceRules: [
        for (final json
            in masterData['bodyColorResistanceRules'] as List<dynamic>)
          _bodyColorResistanceRuleFromGraphql(json as Map<String, dynamic>),
      ],
      bodyColorAbnormalityResistanceRules: [
        for (final json
            in masterData['bodyColorAbnormalityResistanceRules']
                as List<dynamic>)
          BodyColorAbnormalityResistanceRule.fromJson({
            'colorId': json['legacyId'],
            'abnormalityResistanceBonuses': json['abnormalityResistanceBonuses'],
          }),
      ],
      physiques: [
        for (final json in masterData['physiques'] as List<dynamic>)
          Physique.fromJson({'id': json['legacyId']}),
      ],
      personalities: [
        for (final json in masterData['personalities'] as List<dynamic>)
          Personality.fromJson({'id': json['legacyId']}),
      ],
      patterns: [
        for (final json in masterData['patterns'] as List<dynamic>)
          Pattern.fromJson({'id': json['legacyId']}),
      ],
      corrections: [
        for (final json in masterData['corrections'] as List<dynamic>)
          Correction.fromJson({
            'id': json['legacyId'],
            'hpBonus': json['hpBonus'],
            'apBonus': json['apBonus'],
            'attackBonus': json['attackBonus'],
            'defenseBonus': json['defenseBonus'],
            'speedBonus': json['speedBonus'],
            'evasionRateBonus': json['evasionRateBonus'],
            'abnormalityResistanceBonuses':
                json['abnormalityResistanceBonuses'],
          }),
      ],
    );
  }
}

Attribute _attributeFromGraphql(Map<String, dynamic> json) {
  return Attribute.fromJson({
    'id': json['legacyId'],
    'index': json['index'],
    'isElemental': json['category']['name'] == 'elemental',
  }).copyWith(
    resistantTo: [
      for (final entry in json['resistantTo'] as List<dynamic>)
        _shallowAttributeFromGraphql(entry as Map<String, dynamic>),
    ],
    weakTo: [
      for (final entry in json['weakTo'] as List<dynamic>)
        _shallowAttributeFromGraphql(entry as Map<String, dynamic>),
    ],
  );
}

Attribute _shallowAttributeFromGraphql(Map<String, dynamic> json) {
  return Attribute.fromJson({
    'id': json['legacyId'],
    'index': json['index'],
    'isElemental': json['category']['name'] == 'elemental',
  });
}

List<AttributeBonus> _attributeBonusesFromGraphql(List<dynamic> entries) => [
  for (final entry in entries)
    (
      attribute: _shallowAttributeFromGraphql(
        (entry as Map<String, dynamic>)['attribute'] as Map<String, dynamic>,
      ),
      bonus: entry['bonus'] as int,
    ),
];

HeadShape _headShapeFromGraphql(Map<String, dynamic> json) {
  return HeadShape.fromJson({
    'id': json['legacyId'],
    'abnormalityResistanceBonuses': json['abnormalityResistanceBonuses'],
    'hpBonus': json['hpBonus'],
    'apBonus': json['apBonus'],
    'attackBonus': json['attackBonus'],
    'defenseBonus': json['defenseBonus'],
    'speedBonus': json['speedBonus'],
    'evasionRateBonus': json['evasionRateBonus'],
  }).copyWith(
    attributeResistanceBonuses: _attributeBonusesFromGraphql(
      json['attributeResistanceBonuses'] as List<dynamic>,
    ),
  );
}

Anntena _anntenaFromGraphql(Map<String, dynamic> json) {
  final targetMode = json['targetMode'] as Map<String, dynamic>?;
  return Anntena.fromJson({
    'id': json['legacyId'],
    'category': json['category']['name'],
    'targetCount': json['targetCount'],
    'targetsAll': targetMode != null && targetMode['code'] == 1,
    'dealsDamage': json['dealsDamage'],
    'isInheritable': json['isInheritable'],
    'evolvesToId': json['evolvesToId'],
    'maxLevel': json['maxLevel'],
    'variantGroupId': json['variantGroupId'],
    'hasLevel': json['hasLevel'],
  }).copyWith(
    attackAttributes: [
      for (final entry in json['attackAttributes'] as List<dynamic>)
        _shallowAttributeFromGraphql(entry as Map<String, dynamic>),
    ],
  );
}

BodyColorResistanceRule _bodyColorResistanceRuleFromGraphql(
  Map<String, dynamic> json,
) {
  return BodyColorResistanceRule.fromJson({
    'colorId': json['legacyId'],
  }).copyWith(
    attributeResistanceBonuses: _attributeBonusesFromGraphql(
      json['attributeResistanceBonuses'] as List<dynamic>,
    ),
  );
}
