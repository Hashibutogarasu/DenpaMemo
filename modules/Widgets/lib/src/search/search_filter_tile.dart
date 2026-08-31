import 'package:flutter/material.dart';

import '../unfocus_on_tap.dart';

/// A dialog-backed filter row on the search page (head shape, body color,
/// antenna). [onApply] and [onClear] are given the query-transform result
/// directly; how that maps onto the caller's state is up to the caller.
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
    return UnfocusOnTap(
      onTap: () async {
        final result = await openDialog(context);
        if (result != null) {
          onApply(result);
        }
      },
      child: Material(
        type: MaterialType.transparency,
        child: ListTile(
          title: Text(label),
          subtitle: subtitle,
          trailing: isSet
              ? IconButton(icon: const Icon(Icons.close), onPressed: onClear)
              : const Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}
