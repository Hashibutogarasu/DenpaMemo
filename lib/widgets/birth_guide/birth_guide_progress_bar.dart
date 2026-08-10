import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class BirthGuideProgressBar extends StatelessWidget {
  const BirthGuideProgressBar({
    super.key,
    required this.current,
    required this.total,
    this.height = 8,
  });

  final int current;
  final int total;
  final double height;

  @override
  Widget build(BuildContext context) {
    final fraction = total <= 0 ? 0.0 : (current / total).clamp(0.0, 1.0);
    return ClipRRect(
      borderRadius: BorderRadius.circular(height / 2),
      child: SizedBox(
        height: height,
        child: Stack(
          children: [
            const ColoredBox(color: AppColors.nestedBorder),
            Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: fraction,
                child: const ColoredBox(color: AppColors.accent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
