import '../master_data/master_data.dart';
import 'abnormality_resistance.dart';
import 'color_abnormality_resistance_calculator.dart';
import 'denpa_men.dart';

/// Derives [DenpaMen.abnormalityResistances] by merging [DenpaMen.headShape]'s
/// own bonuses with the bonuses [DenpaMen.bodyColors] grant.
extension DenpaMenAbnormalityResistanceCalculation on DenpaMen {
  List<AbnormalityResistance> calculateAbnormalityResistance(
    MasterData masterData,
  ) {
    final totals = <String, int>{
      for (final entry in headShape.abnormalityResistanceBonuses.entries)
        entry.key: entry.value,
    };

    final colorBonuses = (
      bodyColors: bodyColors,
      isSpColor: isSpColor,
    ).calculateColorAbnormalityResistance(masterData);
    for (final resistance in colorBonuses) {
      totals[resistance.abnormalityId] =
          (totals[resistance.abnormalityId] ?? 0) + resistance.value;
    }

    return [
      for (final entry in totals.entries)
        AbnormalityResistance(abnormalityId: entry.key, value: entry.value),
    ];
  }
}
