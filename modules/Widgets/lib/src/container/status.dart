import 'package:flutter/material.dart';

import '../theme/denpa_men_container_theme.dart';

class StatusContainer extends StatelessWidget {
  const StatusContainer({super.key, required this.child, this.padding});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<DenpaMenContainerThemeData>()!;
    return Container(
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.statusBackgroundColor,
        borderRadius: BorderRadius.circular(theme.statusBorderRadius),
      ),
      child: child,
    );
  }
}
