import 'package:freezed_annotation/freezed_annotation.dart';

part 'anntena.freezed.dart';
part 'anntena.g.dart';

/// Antenna master data entry, loaded from `assets/data/antennas/*.json`
/// (one file per antenna).
@freezed
abstract class Anntena with _$Anntena {
  const factory Anntena({
    required String id,
    /// Number of targets the antenna's move hits, or null if it hits every
    /// opposing target instead of a fixed count.
    int? targetCount,
    @Default(false) bool dealsDamage,
    /// Attribute id (see attributes.json) of the damage this antenna deals,
    /// or null if it deals no attribute-typed damage.
    String? attackAttributeId,
    @Default(false) bool isInheritable,
    String? evolvesToId,
  }) = _Anntena;

  factory Anntena.fromJson(Map<String, dynamic> json) =>
      _$AnntenaFromJson(json);
}
