import 'package:freezed_annotation/freezed_annotation.dart';

part 'abnormality_type.freezed.dart';
part 'abnormality_type.g.dart';

/// Abnormality-status master data entry, loaded from
/// `assets/data/abnormality_types.json`.
@freezed
abstract class AbnormalityType with _$AbnormalityType {
  const factory AbnormalityType({
    required String id,
    required String displayName,
  }) = _AbnormalityType;

  factory AbnormalityType.fromJson(Map<String, dynamic> json) =>
      _$AbnormalityTypeFromJson(json);
}
