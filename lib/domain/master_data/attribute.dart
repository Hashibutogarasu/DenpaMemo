import 'package:freezed_annotation/freezed_annotation.dart';

part 'attribute.freezed.dart';
part 'attribute.g.dart';

/// Attribute master data entry, loaded from `assets/data/attributes.json`.
/// [index] determines display order in the UI (e.g. resistance lists),
/// independent of the order entries happen to appear in the source JSON.
@freezed
abstract class Attribute with _$Attribute {
  const factory Attribute({
    required String id,
    required String displayName,
    required int index,
  }) = _Attribute;

  factory Attribute.fromJson(Map<String, dynamic> json) =>
      _$AttributeFromJson(json);
}
