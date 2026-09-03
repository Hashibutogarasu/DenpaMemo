import 'package:flutter/material.dart';

import '../theme/denpa_men_container_theme.dart';

class NestedContainer extends StatelessWidget {
  const NestedContainer({super.key, required this.child, this.padding});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<DenpaMenContainerThemeData>()!;
    return Container(
      padding: padding ?? const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.nestedBackgroundColor,
        borderRadius: BorderRadius.circular(theme.nestedBorderRadius),
        border: Border.all(
          color: theme.nestedBorderColor,
          width: theme.nestedBorderWidth,
        ),
      ),
      child: child,
    );
  }
}
