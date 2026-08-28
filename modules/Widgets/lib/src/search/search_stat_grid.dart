import 'dart:math' as math;

import 'package:data_pack/data_pack.dart';
import 'package:flutter/material.dart';

import '../../i18n/gen/strings.g.dart';
import '../field/inline_nullable_number_field.dart';
import '../label/stat_value.dart';

/// Editable grid of minimum-stat search filters (HP/AP/attack/defense/
/// speed/evasion), laid out two per row like [EditableStatGrid]. Each field
/// left blank means that stat is not filtered on.
class SearchStatGrid extends StatelessWidget {
  const SearchStatGrid({
    super.key,
    required this.query,
    required this.onChanged,
    this.columns = 2,
    this.gap = 8,
  });

  final DenpaMenSearchQuery query;
  final ValueChanged<DenpaMenSearchQuery> onChanged;
  final int columns;
  final double gap;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final entries = <(String, int?, ValueChanged<int?>)>[
      (t.stat.hp, query.minHp, (value) => onChanged(query.copyWith(minHp: value))),
      (t.stat.ap, query.minAp, (value) => onChanged(query.copyWith(minAp: value))),
      (
        t.stat.attack,
        query.minAttack,
        (value) => onChanged(query.copyWith(minAttack: value)),
      ),
      (
        t.stat.defense,
        query.minDefense,
        (value) => onChanged(query.copyWith(minDefense: value)),
      ),
      (
        t.stat.speed,
        query.minSpeed,
        (value) => onChanged(query.copyWith(minSpeed: value)),
      ),
      (
        t.stat.evasionRate,
        query.minEvasionRate,
        (value) => onChanged(query.copyWith(minEvasionRate: value)),
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final columnWidth = math.max(
          0.0,
          (constraints.maxWidth - gap * (columns - 1)) / columns,
        );
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (final entry in entries)
              SizedBox(
                width: columnWidth,
                child: StatValueLabel(
                  label: entry.$1,
                  value: InlineNullableNumberField(
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
