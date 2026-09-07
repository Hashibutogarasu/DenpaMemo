import 'package:flutter/material.dart';

import '../../i18n/gen/strings.g.dart';
import '../theme/denpa_men_label_theme.dart';
import 'exp_bar.dart';
import 'outlined_title.dart';

/// Right-hand portion of the exp row: a right-aligned [ExpBar], always 30%
/// of the row's width regardless of state. When [progress] is null (no
/// more leveling up), the bar is forced full (100% filled) and a
/// red-outlined "MAX" sits to its left.
class ExpProgress extends StatelessWidget {
  const ExpProgress({super.key, required this.progress});

  final double? progress;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final theme = Theme.of(context).extension<DenpaMenLabelThemeData>()!;
    final isMax = progress == null;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (isMax)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: OutlinedTitleText(
                  text: t.denpaMenStatus.max,
                  outlineColor: theme.inactiveBonusColor,
                  fontSize: 16,
                ),
              ),
            SizedBox(
              width: constraints.maxWidth * 0.3,
              child: ExpBar(value: isMax ? 1 : progress!),
            ),
          ],
        );
      },
    );
  }
}
