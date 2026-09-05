import 'package:flutter/material.dart';

/// Generic "pick one of [candidates]" modal: a [SimpleDialog] listing
/// each candidate via [label], popping with the tapped one. Not specific
/// to any one candidate shape — the caller decides what [T] is. [leading]
/// and [subtitle] are optional per-candidate extras (e.g. a disambiguating
/// icon and a secondary line of text) rendered alongside [label].
class CandidateSelectionDialog<T> extends StatelessWidget {
  const CandidateSelectionDialog({
    super.key,
    required this.title,
    required this.candidates,
    required this.label,
    this.leading,
    this.subtitle,
  });

  final String title;
  final List<T> candidates;
  final String Function(T candidate) label;
  final Widget? Function(T candidate)? leading;
  final String? Function(T candidate)? subtitle;

  static Future<T?> show<T>(
    BuildContext context, {
    required String title,
    required List<T> candidates,
    required String Function(T candidate) label,
    Widget? Function(T candidate)? leading,
    String? Function(T candidate)? subtitle,
  }) {
    return showDialog<T>(
      context: context,
      builder: (context) => CandidateSelectionDialog<T>(
        title: title,
        candidates: candidates,
        label: label,
        leading: leading,
        subtitle: subtitle,
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
            ),
          ),
      ],
    );
  }
}
