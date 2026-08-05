import 'package:freezed_annotation/freezed_annotation.dart';

part 'attribute_resistance.freezed.dart';
part 'attribute_resistance.g.dart';

@freezed
abstract class AttributeResistance with _$AttributeResistance {
  const factory AttributeResistance({
    required String attributeId,
    required int value,
  }) = _AttributeResistance;

  factory AttributeResistance.fromJson(Map<String, dynamic> json) =>
      _$AttributeResistanceFromJson(json);
}
