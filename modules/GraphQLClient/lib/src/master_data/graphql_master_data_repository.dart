import 'package:data_pack/data_pack.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../dio_graphql_link.dart';
import 'master_data_graphql_queries.dart';
import '../graphql_network_extensions.dart';

/// [MasterDataRepository] implementation backed by the `modules/server`
/// GraphQL API. Every server type's `id` is the original semantic id the
/// JSON assets used, so this repository maps it directly onto each Freezed
/// model's `id` field; `copyWith` then fills in the fields `fromJson`
/// intentionally excludes with the already-resolved nested objects.
class GraphqlMasterDataRepository implements MasterDataRepository {
  GraphqlMasterDataRepository({required GraphQLClient client})
    : _client = client;

  final GraphQLClient _client;

  /// Runs the `masterData` GraphQL query, returning its raw response map
  /// and the [DioLoggingInterceptor] request id that logged it (see
  /// [DioRequestIdContext]), without mapping the data yet — used instead
  /// of [load] by callers that need to cache the response verbatim.
  Future<({Map<String, dynamic> data, String? requestId})> fetchRaw() async {
    final result = await _client.networkQuery(
      QueryOptions(
        document: gql(masterDataQuery),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    return (
      data: result.data!['masterData'] as Map<String, dynamic>,
      requestId: result.context.entry<DioRequestIdContext>()?.requestId,
    );
  }

  @override
  Future<MasterData> load() async {
    return masterDataFromGraphqlJson((await fetchRaw()).data);
  }
}

/// Maps a `masterData` GraphQL response (as returned by
/// [GraphqlMasterDataRepository.fetchRaw]) to [MasterData]. Shared by the
/// live network path and any code that replays a cached response through
/// the same mapping.
MasterData masterDataFromGraphqlJson(Map<String, dynamic> masterData) {
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
        AbnormalityType.fromJson({'id': json['id']}),
    ],
    bodyColorResistanceRules: [
      for (final json
          in masterData['bodyColorResistanceRules'] as List<dynamic>)
        _bodyColorResistanceRuleFromGraphql(json as Map<String, dynamic>),
    ],
    bodyColorAbnormalityResistanceRules: [
      for (final json
          in masterData['bodyColorAbnormalityResistanceRules'] as List<dynamic>)
        BodyColorAbnormalityResistanceRule.fromJson({
          'colorId': json['id'],
          'abnormalityResistanceBonuses': json['abnormalityResistanceBonuses'],
        }),
    ],
    physiques: [
      for (final json in masterData['physiques'] as List<dynamic>)
        Physique.fromJson({'id': json['id']}),
    ],
    personalities: [
      for (final json in masterData['personalities'] as List<dynamic>)
        Personality.fromJson({'id': json['id']}),
    ],
    patterns: [
      for (final json in masterData['patterns'] as List<dynamic>)
        Pattern.fromJson({'id': json['id']}),
    ],
    corrections: [
      for (final json in masterData['corrections'] as List<dynamic>)
        Correction.fromJson({
          'id': json['id'],
          'hpBonus': json['hpBonus'],
          'apBonus': json['apBonus'],
          'attackBonus': json['attackBonus'],
          'defenseBonus': json['defenseBonus'],
          'speedBonus': json['speedBonus'],
          'evasionRateBonus': json['evasionRateBonus'],
          'abnormalityResistanceBonuses': json['abnormalityResistanceBonuses'],
        }),
    ],
  );
}

Attribute _attributeFromGraphql(Map<String, dynamic> json) {
  return Attribute.fromJson({
    'id': json['id'],
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
    'id': json['id'],
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
    'id': json['id'],
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
    'id': json['id'],
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
  return BodyColorResistanceRule.fromJson({'colorId': json['id']}).copyWith(
    attributeResistanceBonuses: _attributeBonusesFromGraphql(
      json['attributeResistanceBonuses'] as List<dynamic>,
    ),
  );
}
