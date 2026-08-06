import 'package:flutter/material.dart';

import '../domain/denpa_men/abnormality_resistance.dart';
import '../domain/denpa_men/attribute_resistance.dart';
import '../i18n/gen/strings.g.dart';
import '../theme/app_colors.dart';
import 'container/nested.dart';
import 'container/status.dart';
import 'label/abnormality_resistance_entry.dart';
import 'label/attribute_resistance_entry.dart';
import 'label/happiness.dart';
import 'label/level.dart';
import 'label/outlined_title.dart';
import 'label/stat_value.dart';
import 'label/status.dart';

class DenpaMenStatus extends StatelessWidget {
  const DenpaMenStatus({
    super.key,
    required this.name,
    required this.level,
    required this.happiness,
    required this.expProgress,
    required this.expLabel,
    required this.attributeResistances,
    required this.abnormalityResistances,
    required this.hp,
    required this.ap,
    required this.attack,
    required this.defense,
    required this.speed,
    required this.evasionRate,
    this.memo,
  });

  final String name;
  final int level;
  final int happiness;
  final double expProgress;
  final String expLabel;
  final List<AttributeResistance> attributeResistances;
  final List<AbnormalityResistance> abnormalityResistances;
  final int hp;
  final int ap;
  final int attack;
  final int defense;
  final int speed;
  final int evasionRate;
  final String? memo;

  @override
  Widget build(BuildContext context) {
    final t = context.t;

    return StatusContainer(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LevelLabel(level: level),
              HappinessLabel(happiness: happiness),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14),
            child: OutlinedTitleText(
              text: name,
              outlineColor: AppColors.accent,
              fontSize:
                  Theme.of(context).textTheme.titleLarge?.fontSize ?? 22,
            ),
          ),
          Container(
            height: 2,
            margin: const EdgeInsets.only(left: 14, top: 4, bottom: 4),
            color: AppColors.accent,
          ),
          Row(
            children: [
              StatusLabel(child: Text(t.denpaMenStatus.untilNextLevel)),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    value: expProgress,
                    minHeight: 12,
                    backgroundColor: Colors.white,
                    valueColor: const AlwaysStoppedAnimation(
                      AppColors.accent,
                    ),
                  ),
                ),
              ),
              Text(expLabel),
            ],
          ),
          NestedContainer(
            padding: const EdgeInsets.all(8),
            child: _StatWrap(
              columns: 2,
              entries: [
                _StatData(label: t.stat.hp, value: hp),
                _StatData(label: t.stat.ap, value: ap),
                _StatData(label: t.stat.attack, value: attack),
                _StatData(label: t.stat.defense, value: defense),
                _StatData(label: t.stat.speed, value: speed),
                _StatData(label: t.stat.evasionRate, value: evasionRate),
              ],
            ),
          ),
          NestedContainer(
            padding: const EdgeInsets.all(8),
            child: _ResistanceWrap(
              columns: 4,
              entries: [
                for (final resistance in attributeResistances)
                  _ResistanceData(
                    label: t.attribute[resistance.attributeId] ??
                        resistance.attributeId,
                    value: resistance.value,
                  ),
              ],
            ),
          ),
          NestedContainer(
            padding: const EdgeInsets.all(8),
            child: _AbnormalityResistanceWrap(
              columns: 3,
              entries: [
                for (final resistance in abnormalityResistances)
                  _ResistanceData(
                    label: t.abnormality[resistance.abnormalityId] ??
                        resistance.abnormalityId,
                    value: resistance.value,
                  ),
              ],
            ),
          ),
          NestedContainer(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              width: double.infinity,
              child: Text(memo ?? ''),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatData {
  const _StatData({required this.label, required this.value});

  final String label;
  final int value;
}

/// Lays growth stats out left-packed with a fixed 5dp gap in both
/// directions, sized so exactly [columns] fit per row.
class _StatWrap extends StatelessWidget {
  const _StatWrap({required this.columns, required this.entries});

  static const double _gap = 5;

  final int columns;
  final List<_StatData> entries;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columnWidth =
            (constraints.maxWidth - _gap * (columns - 1)) / columns;
        return Wrap(
          spacing: _gap,
          runSpacing: _gap,
          children: [
            for (final entry in entries)
              SizedBox(
                width: columnWidth,
                child: StatValueLabel(
                  label: entry.label,
                  value: Text('${entry.value}'),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _ResistanceData {
  const _ResistanceData({required this.label, required this.value});

  final String label;
  final int value;
}

/// Lays [entries] out left-packed with a fixed 5dp gap in both directions,
/// sized so exactly [columns] fit per row. Each entry's [AttributeLabel]
/// pill stretches to fill its column (see [AttributeResistanceEntry]), so
/// entries sit packed against each other instead of leaving gaps around
/// content narrower than the column.
class _ResistanceWrap extends StatelessWidget {
  const _ResistanceWrap({required this.columns, required this.entries});

  static const double _gap = 5;

  final int columns;
  final List<_ResistanceData> entries;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columnWidth =
            (constraints.maxWidth - _gap * (columns - 1)) / columns;
        return Wrap(
          spacing: _gap,
          runSpacing: _gap,
          children: [
            for (final entry in entries)
              SizedBox(
                width: columnWidth,
                child: AttributeResistanceEntry(
                  label: entry.label,
                  value: entry.value,
                ),
              ),
          ],
        );
      },
    );
  }
}

/// Lays [entries] out left-packed with a fixed 5dp gap in both directions,
/// sized so exactly [columns] fit per row.
class _AbnormalityResistanceWrap extends StatelessWidget {
  const _AbnormalityResistanceWrap({
    required this.columns,
    required this.entries,
  });

  static const double _gap = 5;

  final int columns;
  final List<_ResistanceData> entries;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columnWidth =
            (constraints.maxWidth - _gap * (columns - 1)) / columns;
        return Wrap(
          spacing: _gap,
          runSpacing: _gap,
          children: [
            for (final entry in entries)
              SizedBox(
                width: columnWidth,
                child: AbnormalityResistanceEntry(
                  label: entry.label,
                  value: entry.value,
                ),
              ),
          ],
        );
      },
    );
  }
}
