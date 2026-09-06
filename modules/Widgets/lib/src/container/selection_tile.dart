import 'package:flutter/material.dart';

import '../list/list_item_tile.dart';

/// [ListItemTile] view over a selection-triggering row: [label] as the
/// title, [child] plus a chevron as trailing, unfocusing before [onTap]
/// opens a selection dialog.
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
    return ListItemTile(
      label: label,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(child: child),
          const Icon(Icons.chevron_right),
        ],
      ),
      onTap: enabled
          ? () {
              FocusScope.of(context).unfocus();
              onTap();
            }
          : null,
    );
  }
}
