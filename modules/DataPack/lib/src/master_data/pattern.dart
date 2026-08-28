import 'package:freezed_annotation/freezed_annotation.dart';

part 'pattern.freezed.dart';
part 'pattern.g.dart';

/// Pattern-rank master data entry, loaded from `assets/data/patterns.json`.
@freezed
abstract class Pattern with _$Pattern {
  const factory Pattern({required String id}) = _Pattern;

  factory Pattern.fromJson(Map<String, dynamic> json) =>
      _$PatternFromJson(json);
}
