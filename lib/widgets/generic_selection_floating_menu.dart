import 'package:flutter/material.dart';

import 'package:denpa_memo/widgets.dart';

/// Rounded floating action bar shown above a list while it is in
/// multi-select mode: a select-all/deselect-all toggle, an arbitrary set
/// of caller-supplied [actions], and a cancel button. Carries no
/// selection state or i18n of its own — callers own both, which is what
/// lets this same shell back both the home page's DenpaMen-specific
/// [actions] and simpler selection menus elsewhere.
class GenericSelectionFloatingMenu extends StatelessWidget {
  const GenericSelectionFloatingMenu({
    super.key,
    required this.visible,
    required this.allSelected,
    required this.onToggleSelectAll,
    required this.selectAllTooltip,
    required this.deselectAllTooltip,
    required this.onCancel,
    required this.cancelTooltip,
    this.actions = const [],
    this.duration = const Duration(milliseconds: 200),
  });

  final bool visible;
  final bool allSelected;
  final VoidCallback onToggleSelectAll;
  final String selectAllTooltip;
  final String deselectAllTooltip;
  final VoidCallback onCancel;
  final String cancelTooltip;
  final List<Widget> actions;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<DenpaMenContainerThemeData>()!;
    return IgnorePointer(
      ignoring: !visible,
      child: AnimatedSlide(
        duration: duration,
        curve: Curves.easeOutCubic,
        offset: visible ? Offset.zero : const Offset(0, 1.5),
        child: AnimatedOpacity(
          duration: duration,
          curve: Curves.easeOutCubic,
          opacity: visible ? 1 : 0,
          child: Material(
            color: Theme.of(context).scaffoldBackgroundColor,
            elevation: 8,
            borderRadius: BorderRadius.circular(32),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      allSelected ? Icons.deselect : Icons.select_all,
                      color: theme.accentColor,
                    ),
                    tooltip: allSelected
                        ? deselectAllTooltip
                        : selectAllTooltip,
                    onPressed: onToggleSelectAll,
                  ),
                  ...actions,
                  IconButton(
                    icon: Icon(Icons.close, color: theme.accentColor),
                    tooltip: cancelTooltip,
                    onPressed: onCancel,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
