import 'package:flutter/material.dart';

import '../domain/denpa_men/denpa_men.dart';
import '../i18n/gen/strings.g.dart';
import 'field/inline_number_field.dart';
import 'label/stat_value.dart';

/// Editable grid of growth stats (HP/AP/attack/defense/speed/evasion),
/// laid out two per row.
class EditableStatGrid extends StatelessWidget {
  const EditableStatGrid({
    super.key,
    required this.denpaMen,
    required this.onChanged,
  });

  final DenpaMen denpaMen;
  final ValueChanged<DenpaMen> onChanged;

  static const int _columns = 2;
  static const double _gap = 8;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final entries = <(String, int, ValueChanged<int>)>[
      (
        t.stat.hp,
        denpaMen.hp,
        (value) => onChanged(denpaMen.copyWith(hp: value)),
      ),
      (
        t.stat.ap,
        denpaMen.ap,
        (value) => onChanged(denpaMen.copyWith(ap: value)),
      ),
      (
        t.stat.attack,
        denpaMen.attack,
        (value) => onChanged(denpaMen.copyWith(attack: value)),
      ),
      (
        t.stat.defense,
        denpaMen.defense,
        (value) => onChanged(denpaMen.copyWith(defense: value)),
      ),
      (
        t.stat.speed,
        denpaMen.speed,
        (value) => onChanged(denpaMen.copyWith(speed: value)),
      ),
      (
        t.stat.evasionRate,
        denpaMen.evasionRate,
        (value) => onChanged(denpaMen.copyWith(evasionRate: value)),
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final columnWidth =
            (constraints.maxWidth - _gap * (_columns - 1)) / _columns;
        return Wrap(
          spacing: _gap,
          runSpacing: _gap,
          children: [
            for (final entry in entries)
              SizedBox(
                width: columnWidth,
                child: StatValueLabel(
                  label: entry.$1,
                  value: InlineNumberField(
                    value: entry.$2,
                    onChanged: entry.$3,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
