import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class NestedContainer extends StatelessWidget {
  const NestedContainer({super.key, required this.child, this.padding});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.nestedBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.nestedBorder, width: 2),
      ),
      child: child,
    );
  }
}
