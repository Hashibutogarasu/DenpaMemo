import 'package:flutter/material.dart';

import '../../domain/denpa_men/denpa_men_record.dart';
import '../../i18n/gen/strings.g.dart';
import 'bottom_slide_dialog.dart';

/// Shows [BottomSlideDialog] letting the user pick exactly 0 or 2 parents
/// from [candidates], returning the selected records or null if cancelled.
Future<List<DenpaMenRecord>?> showParentDenpaMenSelectionDialog(
  BuildContext context, {
  required List<DenpaMenRecord> candidates,
  required List<DenpaMenRecord> selected,
}) {
  return showBottomSlideDialog<List<DenpaMenRecord>>(
    context: context,
    builder: (context) => _ParentDenpaMenSelectionDialog(
      candidates: candidates,
      initial: selected,
    ),
  );
}

class _ParentDenpaMenSelectionDialog extends StatefulWidget {
  const _ParentDenpaMenSelectionDialog({
    required this.candidates,
    required this.initial,
  });

  final List<DenpaMenRecord> candidates;
  final List<DenpaMenRecord> initial;

  @override
  State<_ParentDenpaMenSelectionDialog> createState() =>
      _ParentDenpaMenSelectionDialogState();
}

class _ParentDenpaMenSelectionDialogState
    extends State<_ParentDenpaMenSelectionDialog> {
  late final List<DenpaMenRecord> _selected = List.of(widget.initial);

  void _toggle(DenpaMenRecord record) {
    setState(() {
      if (_selected.any((r) => r.id == record.id)) {
        _selected.removeWhere((r) => r.id == record.id);
      } else if (_selected.length < 2) {
        _selected.add(record);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;

    return BottomSlideDialog(
      title: t.editableStatus.parents,
      confirmEnabled: _selected.isEmpty || _selected.length == 2,
      onConfirm: () => Navigator.of(context).pop(_selected),
      content: ListView(
        shrinkWrap: true,
        children: [
          for (final record in widget.candidates)
            ListTile(
              title: Text(record.denpaMen.name),
              selected: _selected.any((r) => r.id == record.id),
              trailing: _selected.any((r) => r.id == record.id)
                  ? const Icon(Icons.check)
                  : null,
              onTap: () => _toggle(record),
            ),
        ],
      ),
    );
  }
}
