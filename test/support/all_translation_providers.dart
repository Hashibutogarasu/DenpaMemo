import 'package:denpamemo_widgets/denpamemo_widgets.dart' as denpamemo_widgets;
import 'package:flutter/widgets.dart';
import 'package:step_dialog/step_dialog.dart' as step_dialog;

import 'package:denpa_memo/i18n/gen/strings.g.dart';

/// Wraps [child] with every package's own `TranslationProvider` (root,
/// denpamemo_widgets, step_dialog), so widget tests that render components
/// from any of those packages resolve `context.t` correctly.
class AllTranslationProviders extends StatelessWidget {
  const AllTranslationProviders({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return denpamemo_widgets.TranslationProvider(
      child: step_dialog.TranslationProvider(
        child: TranslationProvider(child: child),
      ),
    );
  }
}
