import 'package:flutter/material.dart';

import '../domain/denpa_men/denpa_men.dart';
import '../i18n/gen/strings.g.dart';
import 'field/inline_nullable_number_field.dart';
import 'label/exp_bar.dart';
import 'label/outlined_title.dart';
import 'label/status.dart';

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
            StatusLabel(child: Text(t.denpaMenStatus.untilNextLevel)),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (isMax)
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: OutlinedTitleText(
                            text: t.denpaMenStatus.max,
                            outlineColor: Colors.red,
                            fontSize: 16,
                          ),
                        ),
                      SizedBox(
                        width: constraints.maxWidth * 0.3,
                        child: ExpBar(value: isMax ? 1 : progress),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(t.stat.currentExp),
            const SizedBox(width: 4),
            SizedBox(
              width: 60,
              child: InlineNullableNumberField(
                value: denpaMen.currentExp,
                onChanged: (value) =>
                    onChanged(denpaMen.copyWith(currentExp: value)),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(t.stat.maxExp),
            const SizedBox(width: 4),
            SizedBox(
              width: 60,
              child: InlineNullableNumberField(
                value: denpaMen.maxExp,
                onChanged: (value) =>
                    onChanged(denpaMen.copyWith(maxExp: value)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
