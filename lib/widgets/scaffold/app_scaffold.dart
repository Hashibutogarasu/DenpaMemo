import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../header/slanted_app_bar.dart';
import '../navigation/app_back_button.dart';

/// Standard page shell: a [SlantedAppBar] header, plus [body] with the
/// stack-aware [AppBackButton] (bottom-left, shown only when
/// `context.canPop()`) and [floatingActionButton] (bottom-right) laid out
/// as siblings in one [Stack]. Keeping both buttons in the same Stack —
/// rather than routing one of them through [Scaffold.floatingActionButton]
/// — is what keeps their height and bottom offset pixel-identical.
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.title,
    required this.body,
    this.floatingActionButton,
  });

  final Widget title;
  final Widget body;
  final Widget? floatingActionButton;

  static const double _buttonInset = 16;

  @override
  Widget build(BuildContext context) {
    final canPop = context.canPop();

    return Scaffold(
      appBar: SlantedAppBar(title: title),
      body: Stack(
        children: [
          Positioned.fill(child: body),
          if (canPop)
            const Positioned(
              left: _buttonInset,
              bottom: _buttonInset,
              child: AppBackButton(),
            ),
          if (floatingActionButton != null)
            Positioned(
              right: _buttonInset,
              bottom: _buttonInset,
              child: floatingActionButton!,
            ),
        ],
      ),
    );
  }
}
