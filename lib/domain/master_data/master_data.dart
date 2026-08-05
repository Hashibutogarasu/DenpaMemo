import 'package:freezed_annotation/freezed_annotation.dart';

import 'abnormality_type.dart';
import 'anntena.dart';
import 'attribute.dart';
import 'body_color_resistance_rule.dart';
import 'head_shape.dart';
import 'pattern.dart';
import 'personality.dart';
import 'physique.dart';

part 'master_data.freezed.dart';

/// Aggregate of all JSON-driven master data used to build a [DenpaMen].
@freezed
abstract class MasterData with _$MasterData {
  const factory MasterData({
    required List<HeadShape> headShapes,
    required List<Anntena> anntenas,
    required List<Attribute> attributes,
    required List<AbnormalityType> abnormalityTypes,
    required List<BodyColorResistanceRule> bodyColorResistanceRules,
    required List<Physique> physiques,
    required List<Personality> personalities,
    required List<Pattern> patterns,
  }) = _MasterData;
}

/// Domain-facing abstraction over the master data source. Implementations
/// decide where the data comes from (e.g. bundled JSON assets).
abstract class MasterDataRepository {
  Future<MasterData> load();
}
