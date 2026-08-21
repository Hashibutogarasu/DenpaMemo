import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/denpa_men_providers.dart';
import '../../providers/responsive_providers.dart';
import '../../utils/responsive.dart';
import '../header/slanted_app_bar.dart';
import '../import_export_progress_bar.dart';
import '../navigation/app_back_button.dart';
import '../search/search_overlay_bar.dart';

/// Standard page shell: a [SlantedAppBar] header, plus [body] with the
/// stack-aware [AppBackButton] (bottom-left, shown only when
/// `context.canPop()`) and [floatingActionButton] (bottom-right) laid out
/// as siblings in one [Stack]. Keeping both buttons in the same Stack —
/// rather than routing one of them through [Scaffold.floatingActionButton]
/// — is what keeps their height and bottom offset pixel-identical.
///
/// Also binds Escape to the same pop, so keyboard users get the same
/// stack-aware back behavior as the on-screen button, and Ctrl+F to toggle
/// a [SearchOverlayBar] that slides down from the top. While the overlay is
/// open, Escape closes it instead of popping the route.
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

  /// Extra key bindings layered on top of the built-in Ctrl+F/Escape ones,
  /// for pages that need page-specific shortcuts (e.g. Ctrl+A/Escape for
  /// the home screen's selection mode). Entries here take precedence over
  /// the built-in Escape binding when both target the same key.
  final Map<ShortcutActivator, VoidCallback> additionalShortcuts;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canPop = context.canPop();
    final searchOverlayOpen = ref.watch(searchOverlayOpenProvider);

    final isMobile = isMobileWidth(context);
    if (ref.read(isMobileLayoutProvider) != isMobile) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => ref.read(isMobileLayoutProvider.notifier).state = isMobile,
      );
    }

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.keyF, control: true): () =>
            ref.read(searchOverlayOpenProvider.notifier).state =
                !ref.read(searchOverlayOpenProvider),
        if (searchOverlayOpen)
          const SingleActivator(LogicalKeyboardKey.escape): () =>
              ref.read(searchOverlayOpenProvider.notifier).state = false
        else if (canPop)
          const SingleActivator(LogicalKeyboardKey.escape): () =>
              (onBackPressed ?? () => context.pop())(),
        ...additionalShortcuts,
      },
      child: Focus(
        autofocus: true,
        child: Scaffold(
          appBar: SlantedAppBar(title: title, actions: actions),
          bottomNavigationBar: const ImportExportProgressBar(),
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
              const Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SearchOverlayBar(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
