import 'package:flutter/material.dart';

import '../../i18n/gen/strings.g.dart';

/// Generic "run [task], show a spinner while it's in flight, then show its
/// result" modal: [loadingMessage] + a [CircularProgressIndicator] while
/// [task] is pending, then [successMessage] + [resultLabel] of the
/// resolved value once it completes, with an OK button that pops the
/// dialog with that value. If [task] throws, [errorMessage] is shown
/// instead, with its own OK button popping with `null` — the dialog never
/// closes itself without the user tapping one of these buttons. Not
/// specific to any one [task] shape — the caller decides what [T] is and
/// how to render it. [extraActions], when given, renders additional
/// buttons between the result label and the OK button on success (e.g. a
/// "view detail" shortcut) without affecting what the dialog pops with.
class ProgressResultDialog<T> extends StatefulWidget {
  const ProgressResultDialog({
    super.key,
    required this.loadingMessage,
    required this.successMessage,
    required this.errorMessage,
    required this.task,
    required this.resultLabel,
    this.extraActions,
  });

  final String loadingMessage;
  final String successMessage;
  final String errorMessage;
  final Future<T> Function() task;
  final String Function(T result) resultLabel;
  final List<Widget> Function(BuildContext context, T result)? extraActions;

  static Future<T?> show<T>(
    BuildContext context, {
    required String loadingMessage,
    required String successMessage,
    required String errorMessage,
    required Future<T> Function() task,
    required String Function(T result) resultLabel,
    List<Widget> Function(BuildContext context, T result)? extraActions,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: false,
      builder: (context) => ProgressResultDialog<T>(
        loadingMessage: loadingMessage,
        successMessage: successMessage,
        errorMessage: errorMessage,
        task: task,
        resultLabel: resultLabel,
        extraActions: extraActions,
      ),
    );
  }

  @override
  State<ProgressResultDialog<T>> createState() =>
      _ProgressResultDialogState<T>();
}

class _ProgressResultDialogState<T> extends State<ProgressResultDialog<T>> {
  late final Future<T> _future = widget.task();

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder<T>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(widget.errorMessage, textAlign: TextAlign.center),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(t.common.confirm),
                  ),
                ],
              );
            }
            if (!snapshot.hasData) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(widget.loadingMessage, textAlign: TextAlign.center),
                  const SizedBox(height: 20),
                  const CircularProgressIndicator(),
                ],
              );
            }
            final result = snapshot.requireData;
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(widget.successMessage, textAlign: TextAlign.center),
                const SizedBox(height: 20),
                Text(
                  widget.resultLabel(result),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                ...?widget.extraActions?.call(context, result).map(
                  (action) => Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: action,
                  ),
                ),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: () => Navigator.of(context).pop(result),
                  child: Text(t.common.confirm),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
