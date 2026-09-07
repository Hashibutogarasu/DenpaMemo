import 'package:flutter/material.dart';

import 'package:data_pack/data_pack.dart';

import '../../i18n/gen/strings.g.dart';
import '../list/list_item_container.dart';
import '../list/list_item_tile.dart';
import 'app_dialog.dart';

/// Shows an [AlertDialog] letting the user pick one [HeadShape] from a
/// list of tiles, returning the selected shape or null if cancelled.
Future<HeadShape?> showHeadShapeSelectionDialog(
  BuildContext context, {
  required List<HeadShape> headShapes,
  required HeadShape selected,
}) {
  return AppDialog.show<HeadShape>(
    context: context,
    builder: (context) =>
        HeadShapeSelectionDialog(headShapes: headShapes, initial: selected),
  );
}

class HeadShapeSelectionDialog extends StatefulWidget {
  const HeadShapeSelectionDialog({
    super.key,
    required this.headShapes,
    required this.initial,
  });

  final List<HeadShape> headShapes;
  final HeadShape initial;

  @override
  State<HeadShapeSelectionDialog> createState() =>
      _HeadShapeSelectionDialogState();
}

class _HeadShapeSelectionDialogState extends State<HeadShapeSelectionDialog> {
  late HeadShape _selected = widget.initial;

  @override
  Widget build(BuildContext context) {
    final t = context.t;

    return AlertDialog(
      title: Text(t.editableStatus.headShape),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: ListItemContainer(
            selectedIndex: indexOfOrNull(
              widget.headShapes,
              (headShape) => headShape.id == _selected.id,
            ),
            children: [
              for (final headShape in widget.headShapes)
                ListItemTile(
                  label: t.headShape[headShape.id] ?? headShape.id,
                  trailing: const SizedBox.shrink(),
                  onTap: () => setState(() => _selected = headShape),
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
          onPressed: () => Navigator.of(context).pop(_selected),
          child: Text(t.common.confirm),
        ),
      ],
    );
  }
}
