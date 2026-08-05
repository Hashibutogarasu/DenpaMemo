import 'package:freezed_annotation/freezed_annotation.dart';

part 'attribute.freezed.dart';
part 'attribute.g.dart';

/// Attribute master data entry, loaded from `assets/data/attributes.json`.
@freezed
abstract class Attribute with _$Attribute {
  const factory Attribute({required String id, required String displayName}) =
      _Attribute;

  factory Attribute.fromJson(Map<String, dynamic> json) =>
      _$AttributeFromJson(json);
}
