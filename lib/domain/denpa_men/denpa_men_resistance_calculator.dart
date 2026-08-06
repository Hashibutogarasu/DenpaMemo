import '../master_data/master_data.dart';
import 'abnormality_resistance.dart';
import 'attribute_resistance.dart';
import 'attribute_resistance_calculator.dart';
import 'color_abnormality_resistance_calculator.dart';
import 'denpa_men.dart';

/// The abnormality/attribute resistance a [DenpaMen] ends up with, as
/// produced by [DenpaMenResistanceCalculation.calculateResistances].
typedef DenpaMenResistances = ({
  List<AbnormalityResistance> abnormalityResistances,
  List<AttributeResistance> attributeResistance,
});

/// Derives a [DenpaMen]'s resistances in a fixed pipeline:
/// 1. Read the body colors and apply their abnormality resistance, then
///    their attribute resistance.
/// 2. Read the head shape and layer its abnormality resistance, then its
///    attribute resistance, on top.
/// 3. Return the combined result.
extension DenpaMenResistanceCalculation on DenpaMen {
  DenpaMenResistances calculateResistances(MasterData masterData) {
    final colorSelection = (bodyColors: bodyColors, isSpColor: isSpColor);

    final abnormalityTotals = <String, int>{
      for (final resistance
          in colorSelection.calculateColorAbnormalityResistance(masterData))
        resistance.abnormalityId: resistance.value,
    };
    final attributeTotals = <String, int>{
      for (final resistance
          in colorSelection.calculateAttributeResistance(masterData))
        resistance.attributeId: resistance.value,
    };

    headShape.abnormalityResistanceBonuses.forEach((abnormalityId, bonus) {
      abnormalityTotals[abnormalityId] =
          (abnormalityTotals[abnormalityId] ?? 0) + bonus;
    });
    headShape.attributeResistanceBonuses.forEach((attributeId, bonus) {
      attributeTotals[attributeId] = (attributeTotals[attributeId] ?? 0) + bonus;
    });

    final attributeIndexById = {
      for (final attribute in masterData.attributes)
        attribute.id: attribute.index,
    };

    return (
      abnormalityResistances: [
        for (final entry in abnormalityTotals.entries)
          if (entry.value != 0)
            AbnormalityResistance(
              abnormalityId: entry.key,
              value: entry.value,
            ),
      ],
      attributeResistance:
          [
            for (final entry in attributeTotals.entries)
              if (entry.value != 0)
                AttributeResistance(attributeId: entry.key, value: entry.value),
          ]..sort(
            (a, b) => (attributeIndexById[a.attributeId] ?? 0).compareTo(
              attributeIndexById[b.attributeId] ?? 0,
            ),
          ),
    );
  }
}
