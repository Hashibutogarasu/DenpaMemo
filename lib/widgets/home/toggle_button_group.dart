import 'package:flutter/material.dart';

/// Rounded, elevated group of icon toggle buttons backing a value of type
/// [T] (e.g. a view-mode enum). Layout-agnostic — the caller positions it
/// (typically via [Positioned]) and supplies one labeled icon per [values]
/// entry via [children].
class ToggleButtonGroup<T> extends StatelessWidget {
  const ToggleButtonGroup({
    super.key,
    required this.values,
    required this.selected,
    required this.onChanged,
    required this.children,
  });

  final List<T> values;
  final T selected;
  final ValueChanged<T> onChanged;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      elevation: 4,
      borderRadius: BorderRadius.circular(4),
      child: ToggleButtons(
        isSelected: [for (final value in values) value == selected],
        onPressed: (index) => onChanged(values[index]),
        borderRadius: BorderRadius.circular(4),
        constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        children: children,
      ),
    );
  }
}
