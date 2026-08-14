import 'package:flutter/material.dart';

import '../domain/denpa_men/denpa_men.dart';
import '../domain/qr_code/qr_code_record.dart';
import '../i18n/gen/strings.g.dart';
import 'container/selection_tile.dart';
import 'dialog/qr_code_selection_dialog.dart';

/// Field for picking which [QrCodeRecord] [DenpaMen.qrCodeId] refers to (or
/// none), chosen from [candidates] via [showQrCodeSelectionDialog].
class EditableQrCode extends StatelessWidget {
  const EditableQrCode({
    super.key,
    required this.denpaMen,
    required this.candidates,
    required this.onChanged,
    this.enabled = true,
  });

  final DenpaMen denpaMen;
  final List<QrCodeRecord> candidates;
  final ValueChanged<DenpaMen> onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    QrCodeRecord? selected;
    for (final record in candidates) {
      if (record.qrCode.id == denpaMen.qrCodeId) {
        selected = record;
        break;
      }
    }

    return SelectionTile(
      label: t.editableStatus.qrCode,
      onTap: !enabled
          ? null
          : () async {
              final result = await showQrCodeSelectionDialog(
                context,
                candidates: candidates,
                selected: selected,
              );
              if (result != null) {
                onChanged(
                  denpaMen.copyWith(qrCodeId: result.record?.qrCode.id),
                );
              }
            },
      child: Text(
        selected == null
            ? t.common.unset
            : selected.qrCode.name ?? selected.qrCode.id,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
