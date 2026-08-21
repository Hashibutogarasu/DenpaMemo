import 'package:flutter/material.dart';

import '../../domain/denpa_men/denpa_men.dart';
import 'bottom_slide_dialog.dart';
import 'denpa_men_selection_list_tile.dart';

/// Lets the user pick individuals out of [candidates], returning the
/// selected [DenpaMen] list or null if cancelled. Used for `.dm` import
/// merge confirmation.
class DenpaMenSelectionDialog extends StatefulWidget {
  const DenpaMenSelectionDialog._({
    required this.title,
    required List<DenpaMen> candidates,
    required List<DenpaMen> initial,
    required int minSelection,
  }) : _candidates = candidates,
       _initial = initial,
       _minSelection = minSelection;

  final String title;
  final List<DenpaMen> _candidates;
  final List<DenpaMen> _initial;
  final int _minSelection;

  static Future<List<DenpaMen>?> show(
    BuildContext context, {
    required String title,
    required List<DenpaMen> candidates,
    List<DenpaMen> initial = const [],
    int minSelection = 1,
  }) {
    return showBottomSlideDialog<List<DenpaMen>>(
      context: context,
      builder: (context) => DenpaMenSelectionDialog._(
        title: title,
        candidates: candidates,
        initial: initial,
        minSelection: minSelection,
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
            DenpaMenSelectionListTile(
              denpaMen: denpaMen,
              selected: _selected.any((d) => d.id == denpaMen.id),
              onTap: () => _toggle(denpaMen),
            ),
        ],
      ),
    );
  }
}
