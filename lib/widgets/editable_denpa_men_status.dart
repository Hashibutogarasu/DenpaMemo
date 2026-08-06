import 'package:flutter/material.dart';

import '../domain/denpa_men/denpa_men.dart';
import '../domain/master_data/head_shape.dart';
import '../i18n/gen/strings.g.dart';
import 'color/body_color_palette.dart';
import 'container/nested.dart';
import 'container/status.dart';
import 'dialog/body_color_selection_dialog.dart';
import 'dialog/head_shape_selection_dialog.dart';
import 'field/inline_number_field.dart';
import 'field/inline_text_field.dart';
import 'label/stat_value.dart';
import 'label/status.dart';

/// Right-hand desktop pane letting the user edit [denpaMen] in place. Name
/// and numeric stats are edited inline; head shape and body color open a
/// [showHeadShapeSelectionDialog] / [showBodyColorSelectionDialog].
///
/// Every edit produces a full draft [DenpaMen] via [onChanged] so the caller
/// can re-derive resistances (e.g. through `createDenpaMen`) and update the
/// read-only status area immediately.
class EditableDenpaMenStatus extends StatelessWidget {
  const EditableDenpaMenStatus({
    super.key,
    required this.denpaMen,
    required this.headShapes,
    required this.onChanged,
  });

  final DenpaMen denpaMen;
  final List<HeadShape> headShapes;
  final ValueChanged<DenpaMen> onChanged;

  @override
  Widget build(BuildContext context) {
    final t = context.t;

    return StatusContainer(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Align(
            alignment: Alignment.topLeft,
            child: Icon(Icons.edit, size: 20),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _InlineNumberStatusLabel(
                label: t.denpaMenStatus.level,
                value: denpaMen.level,
                onChanged: (value) =>
                    onChanged(denpaMen.copyWith(level: value)),
              ),
              _InlineNumberStatusLabel(
                label: t.denpaMenStatus.happiness,
                value: denpaMen.happiness,
                onChanged: (value) =>
                    onChanged(denpaMen.copyWith(happiness: value)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          InlineTextField(
            value: denpaMen.name,
            style: Theme.of(context).textTheme.titleLarge,
            onChanged: (value) => onChanged(denpaMen.copyWith(name: value)),
          ),
          Row(
            children: [
              StatusLabel(child: Text(t.denpaMenStatus.untilNextLevel)),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    value: denpaMen.maxExp > 0
                        ? denpaMen.currentExp / denpaMen.maxExp
                        : 0,
                    minHeight: 12,
                    backgroundColor: Colors.white,
                    valueColor: const AlwaysStoppedAnimation(
                      Color(0xFF056193),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 32,
                child: InlineNumberField(
                  value: denpaMen.currentExp,
                  textAlign: TextAlign.end,
                  onChanged: (value) =>
                      onChanged(denpaMen.copyWith(currentExp: value)),
                ),
              ),
              const Text('/'),
              SizedBox(
                width: 32,
                child: InlineNumberField(
                  value: denpaMen.maxExp,
                  onChanged: (value) =>
                      onChanged(denpaMen.copyWith(maxExp: value)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          NestedContainer(
            padding: const EdgeInsets.all(8),
            child: _EditableStatGrid(denpaMen: denpaMen, onChanged: onChanged),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _SelectionTile(
                  label: t.editableStatus.headShape,
                  onTap: () async {
                    final selected = await showHeadShapeSelectionDialog(
                      context,
                      headShapes: headShapes,
                      selected: denpaMen.headShape,
                    );
                    if (selected != null) {
                      onChanged(denpaMen.copyWith(headShape: selected));
                    }
                  },
                  child: Text(
                    t.headShape[denpaMen.headShape.id] ??
                        denpaMen.headShape.displayName,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _SelectionTile(
                  label: t.editableStatus.bodyColor,
                  onTap: () async {
                    final selected = await showBodyColorSelectionDialog(
                      context,
                      selected: denpaMen.bodyColors,
                    );
                    if (selected != null) {
                      onChanged(denpaMen.copyWith(bodyColors: selected));
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (final colorId in denpaMen.bodyColors)
                        Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: _ColorDot(colorId: colorId),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InlineNumberStatusLabel extends StatelessWidget {
  const _InlineNumberStatusLabel({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return StatusLabel(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label),
          const SizedBox(width: 4),
          SizedBox(
            width: 32,
            child: InlineNumberField(value: value, onChanged: onChanged),
          ),
        ],
      ),
    );
  }
}

class _EditableStatGrid extends StatelessWidget {
  const _EditableStatGrid({required this.denpaMen, required this.onChanged});

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

class _SelectionTile extends StatelessWidget {
  const _SelectionTile({
    required this.label,
    required this.child,
    required this.onTap,
  });

  final String label;
  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: NestedContainer(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label, style: Theme.of(context).textTheme.labelSmall),
            Row(
              children: [
                Expanded(child: child),
                const Icon(Icons.chevron_right),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ColorDot extends StatelessWidget {
  const _ColorDot({required this.colorId});

  final String colorId;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: bodyColorPalette[colorId],
        border: Border.all(color: Colors.black26),
      ),
    );
  }
}
