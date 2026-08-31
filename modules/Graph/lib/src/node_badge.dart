import 'package:flutter/material.dart';

import 'node_badge_background.dart';

/// A number overlaid on a [NodeBadgeBackground].
class NodeBadge extends StatelessWidget {
  const NodeBadge({super.key, required this.value});

  final int value;

  @override
  Widget build(BuildContext context) {
    return NodeBadgeBackground(
      child: Text('$value', style: Theme.of(context).textTheme.labelSmall),
    );
  }
}
