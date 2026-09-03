import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../i18n/gen/strings.g.dart';

/// Text-only, non-mini [FloatingActionButton.extended] that pops the
/// current route. Deliberately the same FAB variant as other extended FABs
/// (e.g. the save button on `DenpaMenEditor`) so it lines up with them when
/// placed in the same [Stack] — see `AppScaffold`. Styled entirely by the
/// ambient [ThemeData]'s implicit [FloatingActionButtonThemeData] — this
/// widget only decides which button to use and what it does, not its color
/// or shape.
class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  static const double height = 56;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: 'appBackButton',
      onPressed: onPressed ?? () => context.pop(),
      label: Text(context.t.common.back),
    );
  }
}
