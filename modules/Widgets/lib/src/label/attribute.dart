import 'package:flutter/material.dart';

import '../theme/denpa_men_label_theme.dart';

class AttributeLabel extends StatelessWidget {
  const AttributeLabel({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<DenpaMenLabelThemeData>()!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: theme.pillBackgroundColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: DefaultTextStyle.merge(
        style: TextStyle(color: theme.pillTextColor),
        child: child,
      ),
    );
  }
}
