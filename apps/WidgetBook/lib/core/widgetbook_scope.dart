import 'package:denpamemo_widgets/denpamemo_widgets.dart' as denpamemo_widgets;
import 'package:denpamemo_widgets/testing.dart' as denpamemo_widgets_testing;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:step_dialog/step_dialog.dart' as step_dialog;

/// The currently displayed use case's widget. [widgetbookScope] is a plain
/// function, called fresh every time its caller (part of Widgetbook's own
/// widget tree) rebuilds — so the actual content must flow through this
/// mutable holder rather than being returned as a brand new widget tree
/// each call: a fresh [TranslationProvider]/[MaterialApp] on every call
/// would tear down and reconstruct them each time, which can orphan
/// anything hosted in a separate part of the tree (e.g. an open dialog's
/// route) — losing its [TranslationProvider] ancestor, or never closing at
/// all.
final ValueNotifier<Widget> _widgetbookContent = ValueNotifier(
  const SizedBox.shrink(),
);

class _WidgetbookApp extends StatelessWidget {
  const _WidgetbookApp();

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: denpamemo_widgets.TranslationProvider(
        child: step_dialog.TranslationProvider(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: denpamemo_widgets_testing.testAppTheme,
            home: Material(
              child: ValueListenableBuilder<Widget>(
                valueListenable: _widgetbookContent,
                builder: (context, content, _) => content,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

const Widget _widgetbookApp = _WidgetbookApp();

/// [Widgetbook.appBuilder] wrapping every use case like `MyApp` does.
Widget widgetbookScope(BuildContext context, Widget child) {
  _widgetbookContent.value = child;
  return _widgetbookApp;
}
