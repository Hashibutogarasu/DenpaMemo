import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../i18n/gen/strings.g.dart';

/// Pops the current route. A standard [ElevatedButton], styled entirely by
/// the ambient [ElevatedButtonThemeData] — this widget only decides which
/// button to use and what it does, not its color or shape.
class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  /// This button's rendered height under the app's [ElevatedButtonThemeData]
  /// (its `style.minimumSize`). Exposed so callers that position another
  /// widget relative to this button (e.g. `birth_guide.dart` stacking a
  /// second button above it) don't have to duplicate that value.
  static const double height = 40;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed ?? () => context.pop(),
      icon: const Icon(Icons.arrow_back),
      label: Text(context.t.common.back),
    );
  }
}
