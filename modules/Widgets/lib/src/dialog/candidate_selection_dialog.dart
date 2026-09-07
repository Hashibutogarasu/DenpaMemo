import 'package:flutter/material.dart';

import 'app_dialog.dart';

/// Generic "pick one of [candidates]" modal: a [SimpleDialog] listing
/// each candidate via [label], popping with the tapped one. Not specific
/// to any one candidate shape — the caller decides what [T] is. [leading]
/// and [subtitle] are optional per-candidate extras (e.g. a disambiguating
/// icon and a secondary line of text) rendered alongside [label].
/// [trailingActionIcon]/[onTrailingAction] add an optional per-candidate
/// trailing button that fires [onTrailingAction] without selecting the
/// candidate or closing the dialog — e.g. to preview a candidate's detail
/// page before committing to it.
class CandidateSelectionDialog<T> extends StatelessWidget {
  const CandidateSelectionDialog({
    super.key,
    required this.title,
    required this.candidates,
    required this.label,
    this.leading,
    this.subtitle,
    this.trailingActionIcon,
    this.onTrailingAction,
  });

  final String title;
  final List<T> candidates;
  final String Function(T candidate) label;
  final Widget? Function(T candidate)? leading;
  final String? Function(T candidate)? subtitle;
  final IconData? trailingActionIcon;
  final void Function(T candidate)? onTrailingAction;

  static Future<T?> show<T>(
    BuildContext context, {
    required String title,
    required List<T> candidates,
    required String Function(T candidate) label,
    Widget? Function(T candidate)? leading,
    String? Function(T candidate)? subtitle,
    IconData? trailingActionIcon,
    void Function(T candidate)? onTrailingAction,
  }) {
    return AppDialog.show<T>(
      context: context,
      builder: (context) => CandidateSelectionDialog<T>(
        title: title,
        candidates: candidates,
        label: label,
        leading: leading,
        subtitle: subtitle,
        trailingActionIcon: trailingActionIcon,
        onTrailingAction: onTrailingAction,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(title),
      children: [
        for (final candidate in candidates)
          SimpleDialogOption(
            onPressed: () => Navigator.of(context).pop(candidate),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: leading?.call(candidate),
              title: Text(label(candidate)),
              subtitle: switch (subtitle?.call(candidate)) {
                final text? => Text(text),
                null => null,
              },
              trailing: onTrailingAction == null
                  ? null
                  : IconButton(
                      icon: Icon(trailingActionIcon ?? Icons.search),
                      onPressed: () => onTrailingAction!(candidate),
                    ),
            ),
          ),
      ],
    );
  }
}
