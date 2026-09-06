import 'package:flutter/material.dart';

import '../list/list_item_tile.dart';

/// [ListItemTile] view for a dialog-backed filter row on the search page
/// (head shape, body color, antenna). [onApply] and [onClear] are given
/// the query-transform result directly; how that maps onto the caller's
/// state is up to the caller.
class SearchFilterTile<T> extends StatelessWidget {
  const SearchFilterTile({
    super.key,
    required this.label,
    required this.isSet,
    required this.subtitle,
    required this.openDialog,
    required this.onApply,
    required this.onClear,
  });

  final String label;
  final bool isSet;
  final Widget subtitle;
  final Future<T?> Function(BuildContext context) openDialog;
  final ValueChanged<T> onApply;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return ListItemTile(
      label: label,
      subtitle: subtitle,
      trailing: isSet
          ? IconButton(icon: const Icon(Icons.close), onPressed: onClear)
          : const Icon(Icons.chevron_right),
      onTap: () async {
        FocusScope.of(context).unfocus();
        final result = await openDialog(context);
        if (result != null) {
          onApply(result);
        }
      },
    );
  }
}
