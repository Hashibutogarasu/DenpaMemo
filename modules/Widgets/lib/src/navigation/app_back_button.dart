import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../i18n/gen/strings.g.dart';

/// Pops the current route. A standard, text-only [ElevatedButton], styled
/// entirely by the ambient [ElevatedButtonThemeData] — this widget only
/// decides which button to use and what it does, not its color or shape.
class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  static const double height = 40;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed ?? () => context.pop(),
      child: Text(context.t.common.back),
    );
  }
}
