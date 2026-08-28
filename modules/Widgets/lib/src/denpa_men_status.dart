import 'dart:io';
import 'dart:math' as math;

import 'package:data_pack/data_pack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../i18n/gen/strings.g.dart';
import 'container/indented_header.dart';
import 'container/nested.dart';
import 'container/status.dart';
import 'domain/antenna_display_name.dart';
import 'icon/entity_icon.dart';
import 'label/abnormality_resistance_entry.dart';
import 'label/attribute_resistance_entry.dart';
import 'label/exp_progress.dart';
import 'label/gauge_label.dart';
import 'label/gauge_value.dart';
import 'label/outlined_title.dart';
import 'label/stat_value.dart';
import 'label/status.dart';
import 'responsive/responsive_provider.dart';
import 'theme/app_colors.dart';

class DenpaMenStatus extends ConsumerWidget {
  const DenpaMenStatus({
    super.key,
    required this.name,
    required this.level,
    required this.happiness,
    required this.expProgress,
    required this.attributeResistances,
    required this.abnormalityResistances,
    required this.anntena,
    this.antennaLevel = 0,
    required this.hp,
    required this.ap,
    required this.attack,
    required this.defense,
    required this.speed,
    required this.evasionRate,
    required this.totalAttributeCount,
    this.memo,
    this.showContainer = true,
    this.showIcon = false,
    this.iconFile,
    this.attributeResistanceColumns = 4,
    this.entryHeight = 20,
  });

  /// Builds the preview for [denpaMen] with corrections applied, resolving
  /// [totalAttributeCount] against the master data it was created from.
  factory DenpaMenStatus.fromDenpaMen(
    DenpaMen denpaMen, {
    Key? key,
    required int totalAttributeCount,
    bool showContainer = true,
    bool includeStatBonus = true,
    bool showIcon = false,
    File? iconFile,
  }) {
    final corrected = denpaMen.applyCorrections(
      includeStatBonus: includeStatBonus,
    );
    return DenpaMenStatus(
      key: key,
      name: corrected.name,
      level: GaugeValue(current: corrected.level, max: corrected.maxLevel),
      happiness: GaugeValue(
        current: corrected.happiness,
        max: corrected.maxHappiness,
      ),
      expProgress:
          corrected.currentExp != null &&
              corrected.maxExp != null &&
              corrected.maxExp! > 0
          ? corrected.currentExp! / corrected.maxExp!
          : null,
      attributeResistances: corrected.attributeResistance,
      abnormalityResistances: corrected.abnormalityResistances,
      anntena: corrected.anntena,
      antennaLevel: corrected.antennaLevel,
      hp: corrected.hp,
      ap: corrected.ap,
      attack: corrected.attack,
      defense: corrected.defense,
      speed: corrected.speed,
      evasionRate: corrected.evasionRate,
      totalAttributeCount: totalAttributeCount,
      memo: corrected.memo,
      showContainer: showContainer,
      showIcon: showIcon,
      iconFile: iconFile,
    );
  }

  final String name;
  final GaugeValue level;
  final GaugeValue happiness;
  final double? expProgress;
  final List<AttributeResistance> attributeResistances;
  final List<AbnormalityResistance> abnormalityResistances;
  final Anntena anntena;
  final int antennaLevel;
  final int hp;
  final int ap;
  final int attack;
  final int defense;
  final int speed;
  final int evasionRate;
  final int totalAttributeCount;
  final String? memo;
  final bool showContainer;
  final bool showIcon;

  /// Already-resolved icon file shown when [showIcon] is true; renders a
  /// placeholder while null. Resolving the icon (which `DenpaMen` it
  /// belongs to, where it's stored) is the caller's responsibility.
  final File? iconFile;
  final int attributeResistanceColumns;
  final double entryHeight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMobile = ref.watch(isMobileLayoutProvider);
    final content = _buildContent(context, isMobile);
    if (!showContainer) {
      return content;
    }
    return StatusContainer(padding: const EdgeInsets.all(8), child: content);
  }

  Widget _buildContent(BuildContext context, bool isMobile) {
    final t = context.t;
    const resistanceGap = 5.0;
    final attributeResistanceRows =
        (totalAttributeCount / attributeResistanceColumns).ceil();
    final attributeResistanceHeight =
        attributeResistanceRows * entryHeight +
        (attributeResistanceRows - 1) * resistanceGap;

    final gaugesRow = isMobile
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GaugeLabel(label: t.denpaMenStatus.level, value: level),
              const SizedBox(height: 4),
              GaugeLabel(label: t.denpaMenStatus.happiness, value: happiness),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: GaugeLabel(label: t.denpaMenStatus.level, value: level),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: GaugeLabel(
                  label: t.denpaMenStatus.happiness,
                  value: happiness,
                ),
              ),
            ],
          );
    final nameText = OutlinedTitleText(
      text: name,
      outlineColor: AppColors.accent,
      fontSize: Theme.of(context).textTheme.titleLarge?.fontSize ?? 22,
    );

    final header = IndentedHeader(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (showIcon)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ResolvedEntityIcon(file: iconFile, size: 56),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [gaugesRow, nameText],
                    ),
                  ),
                ),
              ],
            )
          else ...[
            gaugesRow,
            nameText,
          ],
          Container(
            height: 2,
            margin: const EdgeInsets.only(top: 4, bottom: 4),
            color: AppColors.accent,
          ),
        ],
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        header,
        Row(
          children: [
            StatusLabel(child: Text(t.denpaMenStatus.untilNextLevel)),
            Expanded(child: ExpProgress(progress: expProgress)),
          ],
        ),
        NestedContainer(
          padding: const EdgeInsets.all(8),
          child: _StatWrap(
            columns: isMobile ? 1 : 2,
            gap: resistanceGap,
            entries: [
              _StatData(
                label: t.stat.antenna,
                textValue: antennaDisplayName(t, anntena, antennaLevel),
                span: 2,
              ),
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
          child: SizedBox(
            height: attributeResistanceHeight,
            child: attributeResistances.isEmpty
                ? Center(child: Text(t.denpaMenStatus.noAttributeResistance))
                : _ResistanceWrap(
                    columns: attributeResistanceColumns,
                    gap: resistanceGap,
                    entryHeight: entryHeight,
                    entries: [
                      for (final resistance in attributeResistances)
                        _ResistanceData(
                          label:
                              t.attribute[resistance.attribute.id] ??
                              resistance.attribute.id,
                          value: resistance.value,
                        ),
                    ],
                  ),
          ),
        ),
        NestedContainer(
          padding: const EdgeInsets.all(8),
          child: _AbnormalityResistanceWrap(
            columns: 3,
            gap: resistanceGap,
            entries: [
              for (final resistance in abnormalityResistances)
                _ResistanceData(
                  label:
                      t.abnormality[resistance.abnormalityId] ??
                      resistance.abnormalityId,
                  value: resistance.value,
                ),
            ],
          ),
        ),
        if (memo != null) ...[
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(memo!),
          ),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class _StatData {
  const _StatData({
    required this.label,
    this.value,
    this.textValue,
    this.span = 1,
  }) : assert(value != null || textValue != null);

  final String label;
  final int? value;
  final String? textValue;
  final int span;
}

/// Lays growth stats out left-packed with a fixed 5dp gap in both
/// directions, sized so exactly [columns] fit per row.
class _StatWrap extends StatelessWidget {
  const _StatWrap({required this.columns, required this.entries, this.gap = 5});

  final int columns;
  final List<_StatData> entries;
  final double gap;

  @override
  Widget build(BuildContext context) {
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
                width: columnWidth * entry.span + gap * (entry.span - 1),
                child: StatValueLabel(
                  label: entry.label,
                  value: Text(entry.textValue ?? '${entry.value}'),
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
  const _ResistanceWrap({
    required this.columns,
    required this.entries,
    this.gap = 5,
    this.entryHeight = 20,
  });

  final int columns;
  final List<_ResistanceData> entries;
  final double gap;
  final double entryHeight;

  @override
  Widget build(BuildContext context) {
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
                child: AttributeResistanceEntry(
                  label: entry.label,
                  value: entry.value,
                  height: entryHeight,
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
    this.gap = 5,
  });

  final int columns;
  final List<_ResistanceData> entries;
  final double gap;

  @override
  Widget build(BuildContext context) {
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
