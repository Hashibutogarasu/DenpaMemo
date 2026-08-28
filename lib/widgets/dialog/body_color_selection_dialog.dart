import 'package:flutter/material.dart';

import '../../i18n/gen/strings.g.dart';
import '../color/body_color_palette.dart';
import '../color/color_dot.dart';
import 'bottom_slide_dialog.dart';

/// Result of [showBodyColorSelectionDialog]: the chosen body color ids (with
/// duplicates allowed at different shades), their per-entry shade levels
/// (-1 thin, 0 normal, 1 dark), and whether they should be treated as an SP
/// color (only ever valid for a single selected entry, see
/// `createDenpaMen`'s validation).
typedef BodyColorSelectionResult = ({
  List<String> bodyColors,
  List<int> bodyColorShades,
  bool isSpColor,
});

class _BodyColorEntry {
  _BodyColorEntry({required this.colorId, required this.shade});

  final String colorId;
  int shade;
}

/// Shows [BottomSlideDialog] letting the user pick up to two body color
/// entries from a grid of round swatches. Each selected entry gets a list
/// tile below the SP color switch with a shade slider (-1 thin, 0 normal, 1
/// dark), so the same color id may be picked twice at different shades. An
/// SP color switch is enabled only while a single entry is selected. At
/// least one entry must remain selected to confirm.
Future<BodyColorSelectionResult?> showBodyColorSelectionDialog(
  BuildContext context, {
  required List<String> selected,
  List<int> shades = const [],
  required bool isSpColor,
}) {
  return showBottomSlideDialog<BodyColorSelectionResult>(
    context: context,
    builder: (context) => BodyColorSelectionDialog(
      initial: selected,
      initialShades: shades,
      initialIsSpColor: isSpColor,
    ),
  );
}

class BodyColorSelectionDialog extends StatefulWidget {
  const BodyColorSelectionDialog({
    super.key,
    required this.initial,
    required this.initialShades,
    required this.initialIsSpColor,
  });

  final List<String> initial;
  final List<int> initialShades;
  final bool initialIsSpColor;

  @override
  State<BodyColorSelectionDialog> createState() =>
      _BodyColorSelectionDialogState();
}

class _BodyColorSelectionDialogState
    extends State<BodyColorSelectionDialog> {
  late final List<_BodyColorEntry> _entries = [
    for (var i = 0; i < widget.initial.length; i++)
      _BodyColorEntry(
        colorId: widget.initial[i],
        shade: i < widget.initialShades.length ? widget.initialShades[i] : 0,
      ),
  ];
  late int? _focusedIndex = _entries.isEmpty ? null : _entries.length - 1;
  late bool _isSpColor = widget.initialIsSpColor;

  bool get _canBeSpColor => _entries.length == 1;

  bool _isChecked(String colorId) {
    final focusedIndex = _focusedIndex;
    if (focusedIndex == null) {
      return false;
    }
    final focused = _entries[focusedIndex];
    return focused.colorId == colorId && focused.shade == 0;
  }

  void _onSwatchTap(String colorId) {
    if (_isChecked(colorId)) {
      _removeEntry(_focusedIndex!);
      return;
    }
    if (_entries.length >= 2) {
      return;
    }
    setState(() {
      _entries.add(_BodyColorEntry(colorId: colorId, shade: 0));
      _focusedIndex = _entries.length - 1;
      if (!_canBeSpColor) {
        _isSpColor = false;
      }
    });
  }

  void _removeEntry(int index) {
    setState(() {
      _entries.removeAt(index);
      _focusedIndex = _entries.isEmpty ? null : 0;
      if (!_canBeSpColor) {
        _isSpColor = false;
      }
    });
  }

  void _focusEntry(int index) {
    setState(() => _focusedIndex = index);
  }

  void _setShade(int index, int shade) {
    setState(() => _entries[index].shade = shade);
  }

  String _shadeLabel(Translations t, int shade) => switch (shade) {
    < 0 => t.editableStatus.bodyColorShadeThin,
    > 0 => t.editableStatus.bodyColorShadeDark,
    _ => t.editableStatus.bodyColorShadeNormal,
  };

  @override
  Widget build(BuildContext context) {
    final t = context.t;

    return BottomSlideDialog(
      title: t.editableStatus.bodyColor,
      confirmEnabled: _entries.isNotEmpty,
      onConfirm: () => Navigator.of(context).pop((
        bodyColors: [for (final entry in _entries) entry.colorId],
        bodyColorShades: [for (final entry in _entries) entry.shade],
        isSpColor: _isSpColor,
      )),
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
                    key: ValueKey(colorId),
                    colorId: colorId,
                    label: t.bodyColor[colorId] ?? colorId,
                    checked: _isChecked(colorId),
                    onTap: () => _onSwatchTap(colorId),
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
            for (var i = 0; i < _entries.length; i++)
              ListTile(
                key: ValueKey(i),
                contentPadding: const EdgeInsets.only(left: 8),
                onTap: () => _focusEntry(i),
                leading: ColorDot(
                  colorId: _entries[i].colorId,
                  shadeLevel: _entries[i].shade,
                ),
                title: Slider(
                  value: _entries[i].shade.toDouble(),
                  min: -1,
                  max: 1,
                  divisions: 2,
                  label: _shadeLabel(t, _entries[i].shade),
                  onChanged: (value) => _setShade(i, value.round()),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => _removeEntry(i),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ColorSwatch extends StatelessWidget {
  const _ColorSwatch({
    super.key,
    required this.colorId,
    required this.label,
    required this.checked,
    required this.onTap,
  });

  final String colorId;
  final String label;
  final bool checked;
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
                  color: checked
                      ? Theme.of(context).colorScheme.primary
                      : Colors.black26,
                  width: checked ? 3 : 1,
                ),
              ),
              alignment: Alignment.center,
              child: checked
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
