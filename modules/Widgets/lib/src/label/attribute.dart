import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AttributeLabel extends StatelessWidget {
  const AttributeLabel({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.pillBackground,
        borderRadius: BorderRadius.circular(999),
      ),
      child: DefaultTextStyle.merge(
        style: const TextStyle(color: AppColors.pillText),
        child: child,
      ),
    );
  }
}
