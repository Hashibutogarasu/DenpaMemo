import 'package:data_pack/data_pack.dart';
import 'package:flutter/material.dart';

import '../../i18n/gen/strings.g.dart';

/// Shows an [AlertDialog] letting the user pick one [HeadShape] from a
/// list of tiles, returning the selected shape or null if cancelled.
Future<HeadShape?> showHeadShapeSelectionDialog(
  BuildContext context, {
  required List<HeadShape> headShapes,
  required HeadShape selected,
}) {
  return showDialog<HeadShape>(
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
        child: ListView(
          shrinkWrap: true,
          children: [
            for (final headShape in widget.headShapes)
              ListTile(
                title: Text(t.headShape[headShape.id] ?? headShape.id),
                selected: headShape.id == _selected.id,
                trailing: headShape.id == _selected.id
                    ? const Icon(Icons.check)
                    : null,
                onTap: () => setState(() => _selected = headShape),
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
