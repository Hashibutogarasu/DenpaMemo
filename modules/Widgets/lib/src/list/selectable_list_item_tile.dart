import 'package:flutter/material.dart';

import 'list_item_tile.dart';

/// [ListItemTile] view for a single row in a "pick one of these" list:
/// no chevron, just a sliding check mark on the row currently [selected].
class SelectableListItemTile extends StatelessWidget {
  const SelectableListItemTile({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.trailing,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListItemTile(
      label: label,
      selected: selected,
      checkable: true,
      trailing: trailing,
      onTap: onTap,
    );
  }
}
