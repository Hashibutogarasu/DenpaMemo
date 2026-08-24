import 'package:flutter/material.dart';

import 'catch_order_badge_background.dart';

/// A catch-order number overlaid on a [CatchOrderBadgeBackground].
class CatchOrderBadge extends StatelessWidget {
  const CatchOrderBadge({super.key, required this.value});

  final int value;

  @override
  Widget build(BuildContext context) {
    return CatchOrderBadgeBackground(
      child: Text('$value', style: Theme.of(context).textTheme.labelSmall),
    );
  }
}
