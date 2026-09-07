import 'package:data_pack/data_pack.dart';
import 'package:flutter/material.dart';

import '../../i18n/gen/strings.g.dart';
import '../list/list_item_container.dart';
import '../list/list_item_tile.dart';

/// Wraps the result of [showQrCodeSelectionDialog]: distinguishes "cancelled"
/// (the `Future` resolves to null) from "explicitly cleared" ([record] is
/// null but the dialog was confirmed).
class QrCodeSelection {
  const QrCodeSelection(this.record);

  final QrCodeRecord? record;
}

/// Shows an [AlertDialog] letting the user pick one [QrCodeRecord] from
/// [candidates], or clear the selection, returning a [QrCodeSelection] or
/// null if cancelled.
Future<QrCodeSelection?> showQrCodeSelectionDialog(
  BuildContext context, {
  required List<QrCodeRecord> candidates,
  required QrCodeRecord? selected,
}) {
  return showDialog<QrCodeSelection>(
    context: context,
    builder: (context) =>
        QrCodeSelectionDialog(candidates: candidates, initial: selected),
  );
}

class QrCodeSelectionDialog extends StatefulWidget {
  const QrCodeSelectionDialog({
    super.key,
    required this.candidates,
    required this.initial,
  });

  final List<QrCodeRecord> candidates;
  final QrCodeRecord? initial;

  @override
  State<QrCodeSelectionDialog> createState() => _QrCodeSelectionDialogState();
}

class _QrCodeSelectionDialogState extends State<QrCodeSelectionDialog> {
  late QrCodeRecord? _selected = widget.initial;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final selected = _selected;
    final candidateIndex = selected == null
        ? null
        : indexOfOrNull(widget.candidates, (r) => r.id == selected.id);
    final selectedIndex = selected == null
        ? 0
        : candidateIndex == null
        ? null
        : 1 + candidateIndex;

    return AlertDialog(
      title: Text(t.editableStatus.qrCode),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: ListItemContainer(
            selectedIndex: selectedIndex,
            children: [
              ListItemTile(
                label: t.common.unset,
                trailing: const SizedBox.shrink(),
                onTap: () => setState(() => _selected = null),
              ),
              for (final record in widget.candidates)
                ListItemTile(
                  label: record.qrCode.name ?? record.qrCode.id,
                  trailing: const SizedBox.shrink(),
                  onTap: () => setState(() => _selected = record),
                ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(t.common.cancel),
        ),
        FilledButton(
          onPressed: () =>
              Navigator.of(context).pop(QrCodeSelection(_selected)),
          child: Text(t.common.confirm),
        ),
      ],
    );
  }
}
