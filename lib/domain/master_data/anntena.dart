import 'package:freezed_annotation/freezed_annotation.dart';

part 'anntena.freezed.dart';
part 'anntena.g.dart';

enum AnntenaCategory { attack, support, other }

/// Antenna master data entry, loaded from `assets/data/antennas/*.json`
/// (one file per antenna id, containing a list of its pattern/evolution
/// variants).
@freezed
abstract class Anntena with _$Anntena {
  const factory Anntena({
    required String id,
    required AnntenaCategory category,
    int? targetCount,
    @Default(false) bool targetsAll,
    @Default(false) bool dealsDamage,
    String? attackAttributeId,
    @Default(false) bool isInheritable,
    String? evolvesToId,
    int? maxLevel,
    String? variantGroupId,
  }) = _Anntena;

  factory Anntena.fromJson(Map<String, dynamic> json) =>
      _$AnntenaFromJson(json);
}
