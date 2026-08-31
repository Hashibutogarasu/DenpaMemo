import 'package:flutter/material.dart';

/// Opens [builder]'s dialog on its own nested [Navigator] (a blank base
/// page, then the dialog pushed on top), self-contained so its own
/// `Navigator.pop()` works and replacing this widget tears the dialog
/// down with it instead of orphaning it.
class DialogPreview extends StatelessWidget {
  const DialogPreview({super.key, required this.builder});

  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateInitialRoutes: (navigator, initialRoute) => [
        MaterialPageRoute<void>(builder: (context) => const SizedBox.expand()),
        DialogRoute<void>(context: navigator.context, builder: builder),
      ],
    );
  }
}
