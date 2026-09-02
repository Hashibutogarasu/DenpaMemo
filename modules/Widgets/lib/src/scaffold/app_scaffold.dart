import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../header/slanted_app_bar.dart';
import '../navigation/app_back_button.dart';
import '../responsive/responsive.dart';
import '../responsive/responsive_provider.dart';

/// Marks a `ShellRoute` branch as reachable only by push, so its first
/// page shows a back button despite its own nested [Navigator] having
/// nothing to pop yet. Unlike a global router-wide `canPop`, this is a
/// static per-subtree flag, so it can't flicker onto an unrelated page.
class AlwaysPoppableShellScope extends InheritedWidget {
  const AlwaysPoppableShellScope({super.key, required super.child});

  static bool of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AlwaysPoppableShellScope>() != null;

  @override
  bool updateShouldNotify(AlwaysPoppableShellScope oldWidget) => false;
}

/// Standard page shell: a [SlantedAppBar] header, then [belowHeader] (if
/// given) and [body] stacked vertically in a [Column], so [belowHeader]
/// takes its own row of space below the header instead of overlaying
/// either. [body] itself holds the stack-aware [AppBackButton]
/// (bottom-left, shown per [Navigator.canPop] or [AlwaysPoppableShellScope])
/// and [floatingActionButton] (bottom-right) as siblings in one [Stack] —
/// rather than routing one of them through [Scaffold.floatingActionButton]
/// — so their height and bottom offset stay pixel-identical.
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
    this.belowHeader,
  });

  final Widget title;
  final Widget body;
  final Widget? floatingActionButton;
  final List<Widget>? actions;
  final double buttonInset;
  final VoidCallback? onBackPressed;
  final Widget? belowHeader;

  final Map<ShortcutActivator, VoidCallback> additionalShortcuts;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canPop = Navigator.canPop(context) || AlwaysPoppableShellScope.of(context);

    final shellState = ref.watch(appShellStateProvider);
    final isMobile = isMobileWidth(context);
    if (shellState.isMobile != isMobile) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!context.mounted) return;
        ref.read(appShellStateProvider.notifier).update(
          (state) => (isMobile: isMobile, isLoading: state.isLoading),
        );
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
          body: Column(
            children: [
              ?belowHeader,
              Expanded(
                child: Stack(
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
            ],
          ),
        ),
      ),
    );
  }
}
