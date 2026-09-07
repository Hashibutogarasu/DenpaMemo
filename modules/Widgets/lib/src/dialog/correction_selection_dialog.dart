import 'package:flutter/material.dart';

import 'package:data_pack/data_pack.dart';

import '../../i18n/gen/strings.g.dart';
import '../list/selectable_list_item_tile.dart';

/// Shows an [AlertDialog] letting the user toggle any number of
/// [Correction]s on/off from a list of tiles, returning the selected
/// corrections or null if cancelled.
Future<List<Correction>?> showCorrectionSelectionDialog(
  BuildContext context, {
  required List<Correction> corrections,
  required List<Correction> selected,
}) {
  return showDialog<List<Correction>>(
    context: context,
    builder: (context) =>
        CorrectionSelectionDialog(corrections: corrections, initial: selected),
  );
}

class CorrectionSelectionDialog extends StatefulWidget {
  const CorrectionSelectionDialog({
    super.key,
    required this.corrections,
    required this.initial,
  });

  final List<Correction> corrections;
  final List<Correction> initial;

  @override
  State<CorrectionSelectionDialog> createState() =>
      _CorrectionSelectionDialogState();
}

class _CorrectionSelectionDialogState extends State<CorrectionSelectionDialog> {
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

    return AlertDialog(
      title: Text(t.editableStatus.correction),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView(
          shrinkWrap: true,
          children: [
            for (final correction in widget.corrections)
              SelectableListItemTile(
                label: t.correction[correction.id] ?? correction.id,
                selected: _selected.any((c) => c.id == correction.id),
                onTap: () => _toggle(correction),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(t.common.cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(_selected),
          child: Text(t.common.confirm),
        ),
      ],
    );
  }
}
