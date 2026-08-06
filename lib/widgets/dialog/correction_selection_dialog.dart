import 'package:flutter/material.dart';

import '../../domain/master_data/correction.dart';
import '../../i18n/gen/strings.g.dart';
import 'bottom_slide_dialog.dart';

/// Shows [BottomSlideDialog] letting the user toggle any number of
/// [Correction]s on/off from a list of tiles, returning the selected
/// corrections or null if cancelled.
Future<List<Correction>?> showCorrectionSelectionDialog(
  BuildContext context, {
  required List<Correction> corrections,
  required List<Correction> selected,
}) {
  return showBottomSlideDialog<List<Correction>>(
    context: context,
    builder: (context) => _CorrectionSelectionDialog(
      corrections: corrections,
      initial: selected,
    ),
  );
}

class _CorrectionSelectionDialog extends StatefulWidget {
  const _CorrectionSelectionDialog({
    required this.corrections,
    required this.initial,
  });

  final List<Correction> corrections;
  final List<Correction> initial;

  @override
  State<_CorrectionSelectionDialog> createState() =>
      _CorrectionSelectionDialogState();
}

class _CorrectionSelectionDialogState
    extends State<_CorrectionSelectionDialog> {
  late final List<Correction> _selected = List.of(widget.initial);

  void _toggle(Correction correction) {
    setState(() {
      if (_selected.any((c) => c.id == correction.id)) {
        _selected.removeWhere((c) => c.id == correction.id);
      } else {
        _selected.add(correction);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;

    return BottomSlideDialog(
      title: t.editableStatus.correction,
      onConfirm: () => Navigator.of(context).pop(_selected),
      content: ListView(
        shrinkWrap: true,
        children: [
          for (final correction in widget.corrections)
            ListTile(
              title: Text(t.correction[correction.id] ?? correction.id),
              selected: _selected.any((c) => c.id == correction.id),
              trailing: _selected.any((c) => c.id == correction.id)
                  ? const Icon(Icons.check)
                  : null,
              onTap: () => _toggle(correction),
            ),
        ],
      ),
    );
  }
}
