import 'package:flutter/material.dart';

import '../domain/denpa_men/abnormality_resistance.dart';
import '../domain/denpa_men/attribute_resistance.dart';
import '../i18n/gen/strings.g.dart';
import 'container/nested.dart';
import 'container/status.dart';
import 'icon/attribute.dart' as attribute_icon;
import 'label/attribute.dart';
import 'label/happiness.dart';
import 'label/level.dart';
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
    this.memo,
  });

  final String name;
  final int level;
  final int happiness;
  final double expProgress;
  final String expLabel;
  final List<AttributeResistance> attributeResistances;
  final List<AbnormalityResistance> abnormalityResistances;
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
          Text(name, style: Theme.of(context).textTheme.titleLarge),
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
                      Color(0xFF056193),
                    ),
                  ),
                ),
              ),
              Text(expLabel),
            ],
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
            child: _ResistanceWrap(
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

class _ResistanceData {
  const _ResistanceData({required this.label, required this.value});

  final String label;
  final int value;
}

/// Lays [entries] out left-packed with a fixed 5dp gap in both directions,
/// sized so exactly [columns] fit per row.
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
                child: _ResistanceEntry(label: entry.label, value: entry.value),
              ),
          ],
        );
      },
    );
  }
}

class _ResistanceEntry extends StatelessWidget {
  const _ResistanceEntry({required this.label, required this.value});

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const attribute_icon.AttributeIcon(),
        Flexible(
          child: AttributeLabel(text: '$label ${value >= 0 ? '+' : ''}$value'),
        ),
      ],
    );
  }
}
