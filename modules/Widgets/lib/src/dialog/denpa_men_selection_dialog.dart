import 'dart:io';

import 'package:data_pack/data_pack.dart';
import 'package:flutter/material.dart';

import '../../i18n/gen/strings.g.dart';
import '../denpa_men_list_tile.dart';
import '../icon/denpa_men_icon_builder.dart';
import 'denpa_men_preview_dialog.dart';

/// Lets the user pick individuals out of [candidates], returning the
/// selected [DenpaMen] list or null if cancelled. Used for `.dm` import
/// merge confirmation. [totalAttributeCount] backs the long-press preview
/// each candidate tile opens.
///
/// This widget has no Riverpod access of its own, so [iconsById] (each
/// candidate's already-resolved icon file, by [DenpaMen.id]) must be
/// resolved by the caller — see `BackupResultSection.iconsById`.
class DenpaMenSelectionDialog extends StatefulWidget {
  const DenpaMenSelectionDialog.internal({
    super.key,
    required this.title,
    required List<DenpaMen> candidates,
    required List<DenpaMen> initial,
    required int minSelection,
    required int totalAttributeCount,
    required Map<String, File?> iconsById,
  }) : _candidates = candidates,
       _initial = initial,
       _minSelection = minSelection,
       _totalAttributeCount = totalAttributeCount,
       _iconsById = iconsById;

  final String title;
  final List<DenpaMen> _candidates;
  final List<DenpaMen> _initial;
  final int _minSelection;
  final int _totalAttributeCount;
  final Map<String, File?> _iconsById;

  static Future<List<DenpaMen>?> show(
    BuildContext context, {
    required String title,
    required List<DenpaMen> candidates,
    required int totalAttributeCount,
    List<DenpaMen> initial = const [],
    int minSelection = 1,
    Map<String, File?> iconsById = const {},
  }) {
    return showDialog<List<DenpaMen>>(
      context: context,
      builder: (context) => DenpaMenSelectionDialog.internal(
        title: title,
        candidates: candidates,
        initial: initial,
        minSelection: minSelection,
        totalAttributeCount: totalAttributeCount,
        iconsById: iconsById,
      ),
    );
  }

  @override
  State<DenpaMenSelectionDialog> createState() =>
      _DenpaMenSelectionDialogState();
}

class _DenpaMenSelectionDialogState extends State<DenpaMenSelectionDialog> {
  late final List<DenpaMen> _selected = List.of(widget._initial);

  void _toggle(DenpaMen denpaMen) {
    setState(() {
      if (_selected.any((d) => d.id == denpaMen.id)) {
        _selected.removeWhere((d) => d.id == denpaMen.id);
      } else {
        _selected.add(denpaMen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;

    return AlertDialog(
      title: Text(widget.title),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView(
          shrinkWrap: true,
          children: [
            for (final denpaMen in widget._candidates)
              DenpaMenListTile(
                denpaMen: denpaMen,
                selected: _selected.any((d) => d.id == denpaMen.id),
                iconFile: widget._iconsById[denpaMen.id],
                onTap: () => _toggle(denpaMen),
                onLongPress: (denpaMen) => DenpaMenPreviewDialog.show(
                  context,
                  denpaMen: denpaMen,
                  totalAttributeCount: widget._totalAttributeCount,
                  iconBuilder: staticDenpaMenIconBuilder(
                    widget._iconsById[denpaMen.id],
                  ),
                ),
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
          onPressed: _selected.length >= widget._minSelection
              ? () => Navigator.of(context).pop(_selected)
              : null,
          child: Text(t.common.confirm),
        ),
      ],
    );
  }
}
