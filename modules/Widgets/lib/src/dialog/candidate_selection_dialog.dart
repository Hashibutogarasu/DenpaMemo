import 'package:flutter/material.dart';

/// Generic "pick one of [candidates]" modal: a [SimpleDialog] listing
/// each candidate via [label], popping with the tapped one. Not specific
/// to any one candidate shape — the caller decides what [T] is.
class CandidateSelectionDialog<T> extends StatelessWidget {
  const CandidateSelectionDialog({
    super.key,
    required this.title,
    required this.candidates,
    required this.label,
  });

  final String title;
  final List<T> candidates;
  final String Function(T candidate) label;

  static Future<T?> show<T>(
    BuildContext context, {
    required String title,
    required List<T> candidates,
    required String Function(T candidate) label,
  }) {
    return showDialog<T>(
      context: context,
      builder: (context) => CandidateSelectionDialog<T>(
        title: title,
        candidates: candidates,
        label: label,
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
            child: Text(label(candidate)),
          ),
      ],
    );
  }
}
