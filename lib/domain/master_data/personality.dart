import 'package:freezed_annotation/freezed_annotation.dart';

part 'personality.freezed.dart';
part 'personality.g.dart';

/// Personality master data entry, loaded from
/// `assets/data/personalities.json`.
@freezed
abstract class Personality with _$Personality {
  const factory Personality({
    required String id,
    required String displayName,
  }) = _Personality;

  factory Personality.fromJson(Map<String, dynamic> json) =>
      _$PersonalityFromJson(json);
}
