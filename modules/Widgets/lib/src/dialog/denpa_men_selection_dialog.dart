import 'package:data_pack/data_pack.dart';
import 'package:flutter/material.dart';

import '../denpa_men_list_tile.dart';
import 'bottom_slide_dialog.dart';
import 'denpa_men_preview_dialog.dart';

/// Lets the user pick individuals out of [candidates], returning the
/// selected [DenpaMen] list or null if cancelled. Used for `.dm` import
/// merge confirmation. [totalAttributeCount] backs the long-press preview
/// each candidate tile opens.
class DenpaMenSelectionDialog extends StatefulWidget {
  const DenpaMenSelectionDialog.internal({
    super.key,
    required this.title,
    required List<DenpaMen> candidates,
    required List<DenpaMen> initial,
    required int minSelection,
    required int totalAttributeCount,
  }) : _candidates = candidates,
       _initial = initial,
       _minSelection = minSelection,
       _totalAttributeCount = totalAttributeCount;

  final String title;
  final List<DenpaMen> _candidates;
  final List<DenpaMen> _initial;
  final int _minSelection;
  final int _totalAttributeCount;

  static Future<List<DenpaMen>?> show(
    BuildContext context, {
    required String title,
    required List<DenpaMen> candidates,
    required int totalAttributeCount,
    List<DenpaMen> initial = const [],
    int minSelection = 1,
  }) {
    return showBottomSlideDialog<List<DenpaMen>>(
      context: context,
      builder: (context) => DenpaMenSelectionDialog.internal(
        title: title,
        candidates: candidates,
        initial: initial,
        minSelection: minSelection,
        totalAttributeCount: totalAttributeCount,
      ),
    );
  }

  @override
  State<DenpaMenSelectionDialog> createState() => _DenpaMenSelectionDialogState();
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
    return BottomSlideDialog(
      title: widget.title,
      confirmEnabled: _selected.length >= widget._minSelection,
      onConfirm: () => Navigator.of(context).pop(_selected),
      content: ListView(
        shrinkWrap: true,
        children: [
          for (final denpaMen in widget._candidates)
            DenpaMenListTile(
              denpaMen: denpaMen,
              selected: _selected.any((d) => d.id == denpaMen.id),
              onTap: () => _toggle(denpaMen),
              onLongPress: (denpaMen) => DenpaMenPreviewDialog.show(
                context,
                denpaMen: denpaMen,
                totalAttributeCount: widget._totalAttributeCount,
              ),
            ),
        ],
      ),
    );
  }
}
