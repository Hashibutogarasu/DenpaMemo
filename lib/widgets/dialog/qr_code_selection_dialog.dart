import 'package:flutter/material.dart';

import '../../domain/qr_code/qr_code_record.dart';
import '../../i18n/gen/strings.g.dart';
import 'bottom_slide_dialog.dart';

/// Wraps the result of [showQrCodeSelectionDialog]: distinguishes "cancelled"
/// (the `Future` resolves to null) from "explicitly cleared" ([record] is
/// null but the dialog was confirmed).
class QrCodeSelection {
  const QrCodeSelection(this.record);

  final QrCodeRecord? record;
}

/// Shows [BottomSlideDialog] letting the user pick one [QrCodeRecord] from
/// [candidates], or clear the selection, returning a [QrCodeSelection] or
/// null if cancelled.
Future<QrCodeSelection?> showQrCodeSelectionDialog(
  BuildContext context, {
  required List<QrCodeRecord> candidates,
  required QrCodeRecord? selected,
}) {
  return showBottomSlideDialog<QrCodeSelection>(
    context: context,
    builder: (context) => _QrCodeSelectionDialog(
      candidates: candidates,
      initial: selected,
    ),
  );
}

class _QrCodeSelectionDialog extends StatefulWidget {
  const _QrCodeSelectionDialog({required this.candidates, required this.initial});

  final List<QrCodeRecord> candidates;
  final QrCodeRecord? initial;

  @override
  State<_QrCodeSelectionDialog> createState() =>
      _QrCodeSelectionDialogState();
}

class _QrCodeSelectionDialogState extends State<_QrCodeSelectionDialog> {
  late QrCodeRecord? _selected = widget.initial;

  @override
  Widget build(BuildContext context) {
    final t = context.t;

    return BottomSlideDialog(
      title: t.editableStatus.qrCode,
      onConfirm: () =>
          Navigator.of(context).pop(QrCodeSelection(_selected)),
      content: ListView(
        shrinkWrap: true,
        children: [
          ListTile(
            title: Text(t.editableStatus.qrCodeUnset),
            selected: _selected == null,
            trailing: _selected == null ? const Icon(Icons.check) : null,
            onTap: () => setState(() => _selected = null),
          ),
          for (final record in widget.candidates)
            ListTile(
              title: Text(record.qrCode.name ?? record.qrCode.id),
              selected: _selected?.id == record.id,
              trailing: _selected?.id == record.id
                  ? const Icon(Icons.check)
                  : null,
              onTap: () => setState(() => _selected = record),
            ),
        ],
      ),
    );
  }
}
