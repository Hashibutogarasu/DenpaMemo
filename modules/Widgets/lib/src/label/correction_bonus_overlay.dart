import 'package:flutter/material.dart';

import '../theme/denpa_men_label_theme.dart';
import 'signed_number.dart';

/// Positioned, right-aligned overlay showing a correction bonus on top of
/// an editable stat container, or struck through when [active] is false,
/// signaling the bonus isn't currently applied to the preview. Must be a
/// direct [Stack] child. Renders nothing when [value] is zero.
class CorrectionBonusOverlay extends StatelessWidget {
  const CorrectionBonusOverlay({
    super.key,
    required this.value,
    this.active = true,
  });

  final int value;
  final bool active;

  @override
  Widget build(BuildContext context) {
    if (value == 0) return const SizedBox.shrink();
    final theme = Theme.of(context).extension<DenpaMenLabelThemeData>()!;

    return Positioned(
      right: 8,
      top: 0,
      bottom: 0,
      child: IgnorePointer(
        child: Align(
          alignment: Alignment.centerRight,
          child: SignedNumberText(
            value: value,
            style: TextStyle(
              color: active ? theme.maxedValueColor : theme.inactiveBonusColor,
              decoration: active ? null : TextDecoration.lineThrough,
            ),
          ),
        ),
      ),
    );
  }
}
