import 'package:freezed_annotation/freezed_annotation.dart';

import '../master_data/anntena.dart';
import '../master_data/head_shape.dart';
import '../master_data/pattern.dart';
import '../master_data/personality.dart';
import '../master_data/physique.dart';
import 'abnormality_resistance.dart';
import 'attribute_resistance.dart';

part 'denpa_men.freezed.dart';
part 'denpa_men.g.dart';

/// Instances must be created through `createDenpaMen` in
/// `denpa_men_factory.dart`, which validates [bodyColors] and derives
/// [abnormalityResistances] / [attributeResistance] from master data.
@freezed
abstract class DenpaMen with _$DenpaMen {
  const factory DenpaMen({
    required List<AbnormalityResistance> abnormalityResistances,
    required List<String> bodyColors,
    required List<AttributeResistance> attributeResistance,
    required Physique physique,
    required Personality personality,
    required Pattern pattern,
    required HeadShape headShape,
    required Anntena anntena,
    required bool isSpColor,
  }) = _DenpaMen;

  factory DenpaMen.fromJson(Map<String, dynamic> json) =>
      _$DenpaMenFromJson(json);
}
