import 'package:freezed_annotation/freezed_annotation.dart';

part 'correction.freezed.dart';
part 'correction.g.dart';

/// Correction master data entry, loaded from `assets/data/corrections.json`.
/// A correction is a bonus applied to a pool of growth stats and/or
/// abnormality resistances (see `DenpaMenCorrectionCalculation` in
/// `domain/denpa_men/`), layered on top of body-color/head-shape
/// resistances as the last step before a [DenpaMen] is finalized.
@freezed
abstract class Correction with _$Correction {
  const factory Correction({
    required String id,
    @Default(0) int hpBonus,
    @Default(0) int apBonus,
    @Default(0) int attackBonus,
    @Default(0) int defenseBonus,
    @Default(0) int speedBonus,
    @Default(0) int evasionRateBonus,
    @Default({}) Map<String, int> abnormalityResistanceBonuses,
  }) = _Correction;

  factory Correction.fromJson(Map<String, dynamic> json) =>
      _$CorrectionFromJson(json);
}
