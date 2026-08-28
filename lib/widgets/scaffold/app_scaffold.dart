import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/responsive_providers.dart';
import '../../utils/responsive.dart';

/// Standard page shell: a [SlantedAppBar] header, plus [body] with the
/// stack-aware [AppBackButton] (bottom-left, shown only when
/// `Navigator.canPop(context)`) and [floatingActionButton] (bottom-right) laid out
/// as siblings in one [Stack]. Keeping both buttons in the same Stack —
/// rather than routing one of them through [Scaffold.floatingActionButton]
/// — is what keeps their height and bottom offset pixel-identical.
///
/// Also binds Escape to the same pop, so keyboard users get the same
/// stack-aware back behavior as the on-screen button.
class AppScaffold extends ConsumerWidget {
  const AppScaffold({
    super.key,
    required this.title,
    required this.body,
    this.floatingActionButton,
    this.actions,
    this.buttonInset = 16,
    this.onBackPressed,
    this.additionalShortcuts = const {},
  });

  final Widget title;
  final Widget body;
  final Widget? floatingActionButton;
  final List<Widget>? actions;
  final double buttonInset;
  final VoidCallback? onBackPressed;

  final Map<ShortcutActivator, VoidCallback> additionalShortcuts;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canPop = Navigator.canPop(context);

    final isMobile = isMobileWidth(context);
    if (ref.read(isMobileLayoutProvider) != isMobile) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!context.mounted) return;
        ref.read(isMobileLayoutProvider.notifier).state = isMobile;
      });
    }

    return CallbackShortcuts(
      bindings: {
        if (canPop)
          const SingleActivator(LogicalKeyboardKey.escape): () =>
              (onBackPressed ?? () => context.pop())(),
        ...additionalShortcuts,
      },
      child: Focus(
        autofocus: true,
        child: Scaffold(
          appBar: SlantedAppBar(
            title: title,
            actions: actions,
            topSafeAreaInset: MediaQuery.paddingOf(context).top,
          ),
          body: Stack(
            children: [
              Positioned.fill(child: body),
              if (canPop)
                Positioned(
                  left: buttonInset,
                  bottom: buttonInset,
                  child: AppBackButton(onPressed: onBackPressed),
                ),
              if (floatingActionButton != null)
                Positioned(
                  right: buttonInset,
                  bottom: buttonInset,
                  child: floatingActionButton!,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
