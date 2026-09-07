import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../i18n/gen/strings.g.dart';
import '../theme/fab_label_theme.dart';

/// [FloatingActionButton] that pops the current route. Styled entirely by
/// the ambient [ThemeData]'s implicit [FloatingActionButtonThemeData] —
/// this widget only decides which button to use and what it does, not its
/// color or shape. Whether the label and/or a tooltip are shown is decided
/// by [FabLabelThemeData].
class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final labelTheme = Theme.of(context).extension<FabLabelThemeData>()!;
    final label = context.t.common.back;
    final onPressedCallback = onPressed ?? () => context.pop();
    final tooltip = labelTheme.showTooltip ? label : null;

    if (labelTheme.showLabel) {
      return FloatingActionButton.extended(
        heroTag: 'appBackButton',
        onPressed: onPressedCallback,
        tooltip: tooltip,
        icon: const Icon(Icons.arrow_back),
        label: Text(label),
      );
    }

    return FloatingActionButton(
      heroTag: 'appBackButton',
      onPressed: onPressedCallback,
      tooltip: tooltip,
      child: const Icon(Icons.arrow_back),
    );
  }
}
