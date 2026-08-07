import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../domain/denpa_men/denpa_men.dart';
import '../domain/denpa_men/denpa_men_correction_calculator.dart';
import '../domain/denpa_men/denpa_men_head_shape_stat_calculator.dart';
import '../domain/denpa_men/denpa_men_stat_bonus.dart';
import '../i18n/gen/strings.g.dart';
import 'field/inline_number_field.dart';
import 'label/correction_bonus_overlay.dart';
import 'label/stat_value.dart';

/// Editable grid of growth stats (HP/AP/attack/defense/speed/evasion),
/// laid out two per row. Any [DenpaMen.corrections] bonus for a stat is
/// overlaid on that stat's container via [CorrectionBonusOverlay], so the
/// base value stays editable while the bonus stays visible.
class EditableStatGrid extends StatelessWidget {
  const EditableStatGrid({
    super.key,
    required this.denpaMen,
    required this.onChanged,
    required this.considerCorrections,
  });

  final DenpaMen denpaMen;
  final ValueChanged<DenpaMen> onChanged;
  final bool considerCorrections;

  static const int _columns = 2;
  static const double _gap = 8;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final bonus =
        denpaMen.headShapeStatBonus() + denpaMen.correctionsStatBonus();
    final entries = <(String, int, int, ValueChanged<int>)>[
      (
        t.stat.hp,
        denpaMen.hp,
        bonus.hp,
        (value) => onChanged(denpaMen.copyWith(hp: value)),
      ),
      (
        t.stat.ap,
        denpaMen.ap,
        bonus.ap,
        (value) => onChanged(denpaMen.copyWith(ap: value)),
      ),
      (
        t.stat.attack,
        denpaMen.attack,
        bonus.attack,
        (value) => onChanged(denpaMen.copyWith(attack: value)),
      ),
      (
        t.stat.defense,
        denpaMen.defense,
        bonus.defense,
        (value) => onChanged(denpaMen.copyWith(defense: value)),
      ),
      (
        t.stat.speed,
        denpaMen.speed,
        bonus.speed,
        (value) => onChanged(denpaMen.copyWith(speed: value)),
      ),
      (
        t.stat.evasionRate,
        denpaMen.evasionRate,
        bonus.evasionRate,
        (value) => onChanged(denpaMen.copyWith(evasionRate: value)),
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final columnWidth = math.max(
          0.0,
          (constraints.maxWidth - _gap * (_columns - 1)) / _columns,
        );
        return Wrap(
          spacing: _gap,
          runSpacing: _gap,
          children: [
            for (final entry in entries)
              SizedBox(
                width: columnWidth,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    StatValueLabel(
                      label: entry.$1,
                      value: InlineNumberField(
                        value: entry.$2,
                        onChanged: entry.$4,
                      ),
                    ),
                    CorrectionBonusOverlay(
                      value: entry.$3,
                      active: considerCorrections,
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}
