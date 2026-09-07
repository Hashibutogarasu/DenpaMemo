import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// [FloatingActionButton] for a "save" action. Pass the operation itself as
/// [save]; this widget tracks its outcome as an [AsyncValue] internally and
/// swaps to a circular loading indicator while it runs, so the caller never
/// has to track a separate "is saving" flag. Shows a check mark, not text,
/// when idle. Passing null for [save] disables the button, matching a
/// disabled [FloatingActionButton]'s `onPressed: null`.
class SaveButton extends StatefulWidget {
  const SaveButton({super.key, required this.save, this.heroTag});

  final Future<void> Function()? save;
  final Object? heroTag;

  @override
  State<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  AsyncValue<void> _state = const AsyncValue.data(null);

  Future<void> _onPressed() async {
    final save = widget.save;
    if (save == null) {
      return;
    }
    setState(() => _state = const AsyncValue.loading());
    try {
      await save();
      if (mounted) {
        setState(() => _state = const AsyncValue.data(null));
      }
    } catch (error, stackTrace) {
      if (mounted) {
        setState(() => _state = AsyncValue.error(error, stackTrace));
      }
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final loading = _state.isLoading;
    return FloatingActionButton(
      heroTag: widget.heroTag,
      onPressed: (widget.save == null || loading) ? null : _onPressed,
      child: loading
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2.5),
            )
          : const Icon(Icons.check),
    );
  }
}
