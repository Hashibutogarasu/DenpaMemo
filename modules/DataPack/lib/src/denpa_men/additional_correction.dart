import 'package:freezed_annotation/freezed_annotation.dart';

import 'abnormality_resistance.dart';
import 'attribute_resistance.dart';

part 'additional_correction.freezed.dart';
part 'additional_correction.g.dart';

/// A free-form correction bundle a user can attach directly to a single
/// [DenpaMen](denpa_men.dart) — distinct from the shared, master-data-defined
/// `Correction`s (e.g. "protagonist correction") a `DenpaMen` can also carry.
/// Groups every user-added growth-stat/resistance bonus the "additional
/// corrections" edit-screen section lets a user add (plus each bundle's
/// free-text name) into one value, so `DenpaMen` carries a single field
/// instead of many independent ones.
@freezed
abstract class AdditionalCorrection with _$AdditionalCorrection {
  const factory AdditionalCorrection({
    @Default(0) int hpBonus,
    @Default(0) int apBonus,
    @Default(0) int attackBonus,
    @Default(0) int defenseBonus,
    @Default(0) int speedBonus,
    @Default(0) int evasionRateBonus,
    @Default('') String statBonusName,
    @Default(<AttributeResistance>[])
    List<AttributeResistance> attributeResistances,
    @Default('') String attributeResistanceName,
    @Default(<AbnormalityResistance>[])
    List<AbnormalityResistance> abnormalityResistances,
    @Default('') String abnormalityResistanceName,
  }) = _AdditionalCorrection;

  factory AdditionalCorrection.fromJson(Map<String, dynamic> json) =>
      _$AdditionalCorrectionFromJson(json);
}
