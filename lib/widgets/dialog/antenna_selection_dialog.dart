import 'package:flutter/material.dart';

import '../../domain/master_data/anntena.dart';
import '../../i18n/gen/strings.g.dart';
import 'bottom_slide_dialog.dart';

/// Shows [BottomSlideDialog] letting the user pick one [Anntena] from a
/// list of tiles, returning the selected antenna or null if cancelled.
Future<Anntena?> showAntennaSelectionDialog(
  BuildContext context, {
  required List<Anntena> anntenas,
  required Anntena selected,
}) {
  return showBottomSlideDialog<Anntena>(
    context: context,
    builder: (context) =>
        _AntennaSelectionDialog(anntenas: anntenas, initial: selected),
  );
}

class _AntennaSelectionDialog extends StatefulWidget {
  const _AntennaSelectionDialog({required this.anntenas, required this.initial});

  final List<Anntena> anntenas;
  final Anntena initial;

  @override
  State<_AntennaSelectionDialog> createState() =>
      _AntennaSelectionDialogState();
}

class _AntennaSelectionDialogState extends State<_AntennaSelectionDialog> {
  late Anntena _selected = widget.initial;

  @override
  Widget build(BuildContext context) {
    final t = context.t;

    return BottomSlideDialog(
      title: t.editableStatus.antenna,
      onConfirm: () => Navigator.of(context).pop(_selected),
      content: ListView(
        shrinkWrap: true,
        children: [
          for (final anntena in widget.anntenas)
            ListTile(
              title: Text(t.antenna[anntena.id] ?? anntena.id),
              selected: anntena.id == _selected.id,
              trailing: anntena.id == _selected.id
                  ? const Icon(Icons.check)
                  : null,
              onTap: () => setState(() => _selected = anntena),
            ),
        ],
      ),
    );
  }
}
