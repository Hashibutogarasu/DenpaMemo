import 'package:flutter/material.dart';

import 'package:data_pack/data_pack.dart';

import '../i18n/gen/strings.g.dart';
import 'field/inline_nullable_number_field.dart';
import 'label/exp_progress.dart';
import 'label/status.dart';
import 'theme/denpa_men_container_theme.dart';

/// Editable exp section: the level-up progress bar (30% of the row's
/// width, right-aligned) stacked above the current/max exp fields. Leaving
/// both current and max exp empty (`null`) is treated as "no more leveling
/// up" and shows "MAX" to the bar's left instead of a 0% bar.
class EditableExp extends StatelessWidget {
  const EditableExp({
    super.key,
    required this.denpaMen,
    required this.onChanged,
  });

  final DenpaMen denpaMen;
  final ValueChanged<DenpaMen> onChanged;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final theme = Theme.of(context).extension<DenpaMenContainerThemeData>()!;
    final isMax = denpaMen.currentExp == null && denpaMen.maxExp == null;
    final progress =
        denpaMen.currentExp != null &&
            denpaMen.maxExp != null &&
            denpaMen.maxExp! > 0
        ? denpaMen.currentExp! / denpaMen.maxExp!
        : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            StatusLabel(
              textColor: theme.accentColor,
              child: Text(t.denpaMenStatus.untilNextLevel),
            ),
            Expanded(child: ExpProgress(progress: isMax ? null : progress)),
          ],
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(left: 14),
          child: Row(
            children: [
              Text(t.stat.currentExp),
              const Spacer(),
              SizedBox(
                width: 60,
                child: InlineNullableNumberField(
                  value: denpaMen.currentExp,
                  textAlign: TextAlign.end,
                  onChanged: (value) =>
                      onChanged(denpaMen.copyWith(currentExp: value)),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 14),
          child: Row(
            children: [
              Text(t.stat.maxExp),
              const Spacer(),
              SizedBox(
                width: 60,
                child: InlineNullableNumberField(
                  value: denpaMen.maxExp,
                  textAlign: TextAlign.end,
                  onChanged: (value) =>
                      onChanged(denpaMen.copyWith(maxExp: value)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
