import 'abnormality_resistance.dart';
import 'attribute_resistance.dart';
import 'denpa_men.dart';
import 'denpa_men_resistance_calculator.dart';

/// The components a resistance calculation was derived from, kept as a real
/// type (with its own [toJson]/[fromJson]) instead of an ad-hoc map, so the
/// cached shape is owned by this library rather than by whatever code
/// happens to call `CacheIndexRepository.save`.
class DenpaMenResistanceCacheInput {
  const DenpaMenResistanceCacheInput({
    required this.bodyColors,
    required this.bodyColorShades,
    required this.isSpColor,
    required this.headShapeId,
    required this.anntenaId,
    required this.antennaLevel,
  });

  factory DenpaMenResistanceCacheInput.fromDenpaMen(DenpaMen denpaMen) =>
      DenpaMenResistanceCacheInput(
        bodyColors: denpaMen.bodyColors,
        bodyColorShades: denpaMen.bodyColorShades,
        isSpColor: denpaMen.isSpColor,
        headShapeId: denpaMen.headShape.id,
        anntenaId: denpaMen.anntena.id,
        antennaLevel: denpaMen.antennaLevel,
      );

  factory DenpaMenResistanceCacheInput.fromJson(Map<String, dynamic> json) =>
      DenpaMenResistanceCacheInput(
        bodyColors: (json['bodyColors'] as List<dynamic>).cast<String>(),
        bodyColorShades: (json['bodyColorShades'] as List<dynamic>).cast<int>(),
        isSpColor: json['isSpColor'] as bool,
        headShapeId: json['headShapeId'] as String,
        anntenaId: json['anntenaId'] as String,
        antennaLevel: json['antennaLevel'] as int,
      );

  final List<String> bodyColors;
  final List<int> bodyColorShades;
  final bool isSpColor;
  final String headShapeId;
  final String anntenaId;
  final int antennaLevel;

  Map<String, dynamic> toJson() => {
    'bodyColors': bodyColors,
    'bodyColorShades': bodyColorShades,
    'isSpColor': isSpColor,
    'headShapeId': headShapeId,
    'anntenaId': anntenaId,
    'antennaLevel': antennaLevel,
  };
}

/// The [DenpaMenResistances] a resistance calculation produced, wrapped as
/// a real type so it can be cached through `CacheIndexRepository` without
/// exposing its JSON shape outside this library.
class DenpaMenResistanceCacheOutput {
  const DenpaMenResistanceCacheOutput(this.resistances);

  factory DenpaMenResistanceCacheOutput.fromJson(Map<String, dynamic> json) =>
      DenpaMenResistanceCacheOutput((
        abnormalityResistances: [
          for (final entry in json['abnormalityResistances'] as List<dynamic>)
            AbnormalityResistance.fromJson(entry as Map<String, dynamic>),
        ],
        attributeResistance: [
          for (final entry in json['attributeResistance'] as List<dynamic>)
            AttributeResistance.fromJson(entry as Map<String, dynamic>),
        ],
      ));

  final DenpaMenResistances resistances;

  Map<String, dynamic> toJson() => {
    'abnormalityResistances': [
      for (final resistance in resistances.abnormalityResistances)
        resistance.toJson(),
    ],
    'attributeResistance': [
      for (final resistance in resistances.attributeResistance)
        resistance.toJson(),
    ],
  };
}
