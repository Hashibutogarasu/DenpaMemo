import 'package:flutter/material.dart';

import '../unfocus_on_tap.dart';
import 'nested.dart';

/// Tappable [NestedContainer] with a small label above arbitrary content
/// and a trailing chevron, used to open a selection dialog. See
/// [UnfocusOnTap] for why [onTap] runs through it rather than a plain
/// [InkWell].
class SelectionTile extends StatelessWidget {
  const SelectionTile({
    super.key,
    required this.label,
    required this.child,
    required this.onTap,
    this.enabled = true,
  });

  final String label;
  final Widget child;
  final VoidCallback onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return UnfocusOnTap(
      borderRadius: BorderRadius.circular(20),
      enabled: enabled,
      onTap: onTap,
      child: NestedContainer(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label, style: Theme.of(context).textTheme.labelSmall),
            Row(
              children: [
                Expanded(child: child),
                const Icon(Icons.chevron_right),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
