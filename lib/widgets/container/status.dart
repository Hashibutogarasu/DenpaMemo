import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class StatusContainer extends StatelessWidget {
  const StatusContainer({super.key, required this.child, this.padding});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.statusBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}
