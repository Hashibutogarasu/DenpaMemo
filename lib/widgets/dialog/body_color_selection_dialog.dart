import 'package:flutter/material.dart';

import '../../i18n/gen/strings.g.dart';
import '../color/body_color_palette.dart';
import 'bottom_slide_dialog.dart';

const int _maxSelectableColors = 2;

/// Shows [BottomSlideDialog] letting the user pick up to
/// [_maxSelectableColors] body color ids from a grid of round swatches. At
/// least one color must remain selected to confirm.
Future<List<String>?> showBodyColorSelectionDialog(
  BuildContext context, {
  required List<String> selected,
}) {
  return showBottomSlideDialog<List<String>>(
    context: context,
    builder: (context) => _BodyColorSelectionDialog(initial: selected),
  );
}

class _BodyColorSelectionDialog extends StatefulWidget {
  const _BodyColorSelectionDialog({required this.initial});

  final List<String> initial;

  @override
  State<_BodyColorSelectionDialog> createState() =>
      _BodyColorSelectionDialogState();
}

class _BodyColorSelectionDialogState
    extends State<_BodyColorSelectionDialog> {
  late final List<String> _selected = List.of(widget.initial);

  void _toggle(String colorId) {
    setState(() {
      if (_selected.contains(colorId)) {
        _selected.remove(colorId);
      } else if (_selected.length < _maxSelectableColors) {
        _selected.add(colorId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;

    return BottomSlideDialog(
      title: t.editableStatus.bodyColor,
      confirmEnabled: _selected.isNotEmpty,
      onConfirm: () => Navigator.of(context).pop(_selected),
      content: SingleChildScrollView(
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 12,
          runSpacing: 12,
          children: [
            for (final colorId in bodyColorPalette.keys)
              _ColorSwatch(
                colorId: colorId,
                label: t.bodyColor[colorId] ?? colorId,
                selected: _selected.contains(colorId),
                onTap: () => _toggle(colorId),
              ),
          ],
        ),
      ),
    );
  }
}

class _ColorSwatch extends StatelessWidget {
  const _ColorSwatch({
    required this.colorId,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  static const double _diameter = 32;

  final String colorId;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = bodyColorPalette[colorId]!;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: SizedBox(
        width: 56,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: _diameter,
              height: _diameter,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
                border: Border.all(
                  color: selected
                      ? Theme.of(context).colorScheme.primary
                      : Colors.black26,
                  width: selected ? 3 : 1,
                ),
              ),
              alignment: Alignment.center,
              child: selected
                  ? Icon(
                      Icons.check,
                      size: 16,
                      color: ThemeData.estimateBrightnessForColor(color) ==
                              Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    )
                  : null,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
