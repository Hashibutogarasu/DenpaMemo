import 'package:data_pack/data_pack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/search_providers.dart';
import '../unfocus_on_tap.dart';

/// A dialog-backed filter row on the search page (head shape, body color,
/// antenna). Owns the read-dialog-write cycle against
/// [searchFormDraftProvider] itself, so call sites only describe how to
/// open their dialog and how its result maps onto the query.
class SearchFilterTile<T> extends ConsumerWidget {
  const SearchFilterTile({
    super.key,
    required this.label,
    required this.isSet,
    required this.subtitle,
    required this.openDialog,
    required this.apply,
    required this.clear,
  });

  final String label;
  final bool isSet;
  final Widget subtitle;
  final Future<T?> Function(BuildContext context) openDialog;
  final DenpaMenSearchQuery Function(DenpaMenSearchQuery query, T result)
  apply;
  final DenpaMenSearchQuery Function(DenpaMenSearchQuery query) clear;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return UnfocusOnTap(
      onTap: () async {
        final result = await openDialog(context);
        if (result != null) {
          ref
              .read(searchFormDraftProvider.notifier)
              .update((q) => apply(q, result));
        }
      },
      child: Material(
        type: MaterialType.transparency,
        child: ListTile(
          title: Text(label),
          subtitle: subtitle,
          trailing: isSet
              ? IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => ref
                      .read(searchFormDraftProvider.notifier)
                      .update(clear),
                )
              : const Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}
