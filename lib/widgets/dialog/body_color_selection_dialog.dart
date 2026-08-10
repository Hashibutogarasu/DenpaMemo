import 'package:flutter/material.dart';

import '../../i18n/gen/strings.g.dart';
import '../color/body_color_palette.dart';
import 'bottom_slide_dialog.dart';

/// Result of [showBodyColorSelectionDialog]: the chosen body color ids and
/// whether they should be treated as an SP color (only ever valid for a
/// single selected color, see `createDenpaMen`'s validation).
typedef BodyColorSelectionResult = ({List<String> bodyColors, bool isSpColor});

/// Shows [BottomSlideDialog] letting the user pick up to two body color ids
/// from a grid of round swatches, plus an SP color switch enabled only
/// while a single color is selected. At least one color must remain
/// selected to confirm.
Future<BodyColorSelectionResult?> showBodyColorSelectionDialog(
  BuildContext context, {
  required List<String> selected,
  required bool isSpColor,
}) {
  return showBottomSlideDialog<BodyColorSelectionResult>(
    context: context,
    builder: (context) => _BodyColorSelectionDialog(
      initial: selected,
      initialIsSpColor: isSpColor,
    ),
  );
}

class _BodyColorSelectionDialog extends StatefulWidget {
  const _BodyColorSelectionDialog({
    required this.initial,
    required this.initialIsSpColor,
  });

  final List<String> initial;
  final bool initialIsSpColor;

  @override
  State<_BodyColorSelectionDialog> createState() =>
      _BodyColorSelectionDialogState();
}

class _BodyColorSelectionDialogState
    extends State<_BodyColorSelectionDialog> {
  late final List<String> _selected = List.of(widget.initial);
  late bool _isSpColor = widget.initialIsSpColor;

  bool get _canBeSpColor => _selected.length == 1;

  void _toggle(String colorId) {
    setState(() {
      if (_selected.contains(colorId)) {
        _selected.remove(colorId);
      } else if (_selected.length < 2) {
        _selected.add(colorId);
      }
      if (!_canBeSpColor) {
        _isSpColor = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;

    return BottomSlideDialog(
      title: t.editableStatus.bodyColor,
      confirmEnabled: _selected.isNotEmpty,
      onConfirm: () => Navigator.of(
        context,
      ).pop((bodyColors: _selected, isSpColor: _isSpColor)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Wrap(
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
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(t.editableStatus.spColor),
              value: _isSpColor,
              onChanged: _canBeSpColor
                  ? (value) => setState(() => _isSpColor = value)
                  : null,
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
              width: 32,
              height: 32,
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
