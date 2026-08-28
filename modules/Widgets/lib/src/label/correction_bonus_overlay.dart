import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'signed_number.dart';

/// Positioned, right-aligned overlay showing a correction bonus on top of
/// an editable stat container, in [AppColors.maxedValue] — the same color
/// a maxed level/happiness gauge uses — or struck through in
/// [AppColors.inactiveBonus] when [active] is false, signaling the bonus
/// isn't currently applied to the preview. Must be a direct [Stack] child.
/// Renders nothing when [value] is zero.
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
              color: active ? AppColors.maxedValue : AppColors.inactiveBonus,
              decoration: active ? null : TextDecoration.lineThrough,
            ),
          ),
        ),
      ),
    );
  }
}
