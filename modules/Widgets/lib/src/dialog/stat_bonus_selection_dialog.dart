import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:data_pack/data_pack.dart';

import '../../i18n/gen/strings.g.dart';
import '../container/status.dart';
import '../field/inline_number_field.dart';
import '../label/stat_value.dart';
import 'app_dialog.dart';

/// Shows an [AlertDialog] letting the user name a bundle of user-added
/// growth-stat bonuses (HP/AP/attack/defense/speed/evasion) and set each
/// one's value, reusing [StatusContainer] and the same
/// [StatValueLabel]/`InlineNumberField` layout `EditableStatGrid` uses for
/// a `DenpaMen`'s base stats. Returns [initial] with just the stat-bonus
/// fields replaced, or null if cancelled. The name field sits above the
/// stat grid at a fixed position, matching
/// `ResistanceBonusSelectionDialog`'s layout.
Future<AdditionalCorrection?> showStatBonusSelectionDialog(
  BuildContext context, {
  required AdditionalCorrection initial,
}) {
  return AppDialog.show<AdditionalCorrection>(
    context: context,
    builder: (context) => StatBonusSelectionDialog(initial: initial),
  );
}

class StatBonusSelectionDialog extends StatefulWidget {
  const StatBonusSelectionDialog({super.key, required this.initial});

  final AdditionalCorrection initial;

  @override
  State<StatBonusSelectionDialog> createState() =>
      _StatBonusSelectionDialogState();
}

class _StatBonusSelectionDialogState extends State<StatBonusSelectionDialog> {
  late final TextEditingController _nameController = TextEditingController(
    text: widget.initial.statBonusName,
  );
  late int _hp = widget.initial.hpBonus;
  late int _ap = widget.initial.apBonus;
  late int _attack = widget.initial.attackBonus;
  late int _defense = widget.initial.defenseBonus;
  late int _speed = widget.initial.speedBonus;
  late int _evasionRate = widget.initial.evasionRateBonus;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final entries = <(String, int, ValueChanged<int>)>[
      (t.stat.hp, _hp, (value) => setState(() => _hp = value)),
      (t.stat.ap, _ap, (value) => setState(() => _ap = value)),
      (t.stat.attack, _attack, (value) => setState(() => _attack = value)),
      (t.stat.defense, _defense, (value) => setState(() => _defense = value)),
      (t.stat.speed, _speed, (value) => setState(() => _speed = value)),
      (
        t.stat.evasionRate,
        _evasionRate,
        (value) => setState(() => _evasionRate = value),
      ),
    ];

    return AlertDialog(
      title: Text(t.editableStatus.additionalStatBonus),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: t.editableStatus.correctionName,
              ),
            ),
            const SizedBox(height: 8),
            Flexible(
              child: SingleChildScrollView(
                child: StatusContainer(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      const columns = 2;
                      const gap = 8.0;
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
                                value: InlineNumberField(
                                  value: entry.$2,
                                  onChanged: entry.$3,
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(t.common.cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(
            widget.initial.copyWith(
              hpBonus: _hp,
              apBonus: _ap,
              attackBonus: _attack,
              defenseBonus: _defense,
              speedBonus: _speed,
              evasionRateBonus: _evasionRate,
              statBonusName: _nameController.text.trim(),
            ),
          ),
          child: Text(t.common.confirm),
        ),
      ],
    );
  }
}
