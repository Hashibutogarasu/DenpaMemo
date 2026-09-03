import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../header/slanted_app_bar.dart';
import '../navigation/app_back_button.dart';
import '../responsive/responsive.dart';
import '../responsive/responsive_provider.dart';
import '../theme/fab_button_theme.dart';
import '../theme/slanted_header_theme.dart';

/// Marks a `ShellRoute` branch as reachable only by push, so its first
/// page shows a back button despite its own nested [Navigator] having
/// nothing to pop yet. Unlike a global router-wide `canPop`, this is a
/// static per-subtree flag, so it can't flicker onto an unrelated page.
class AlwaysPoppableShellScope extends InheritedWidget {
  const AlwaysPoppableShellScope({super.key, required super.child});

  static bool of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AlwaysPoppableShellScope>() !=
      null;

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
/// — so their bottom offset (both inset by [buttonInset] from the bottom
/// edge) stays identical, even though the two buttons aren't the same
/// widget and can differ in height.
///
/// Also binds Escape to the same pop, so keyboard users get the same
/// stack-aware back behavior as the on-screen button.
class AppScaffold extends ConsumerWidget {
  const AppScaffold({
    super.key,
    required this.title,
    required this.body,
    this.floatingActionButton,
    this.floatingActionButtonExpansion,
    this.actions,
    this.buttonInset = 16,
    this.onBackPressed,
    this.additionalShortcuts = const {},
    this.belowHeader,
  });

  final Widget title;
  final Widget body;
  final Widget? floatingActionButton;

  /// When [floatingActionButton] is an expandable FAB (e.g.
  /// `AddDenpaMenFab`) that exposes its own open/closed state through a
  /// [ValueNotifier], pass it here to show a dimmed, tap-to-dismiss backdrop
  /// over [body] while it's open — styled by [FabButtonThemeData]. Left
  /// null for a plain, non-expanding [floatingActionButton].
  final ValueNotifier<bool>? floatingActionButtonExpansion;
  final List<Widget>? actions;
  final double buttonInset;
  final VoidCallback? onBackPressed;
  final Widget? belowHeader;

  final Map<ShortcutActivator, VoidCallback> additionalShortcuts;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canPop =
        Navigator.canPop(context) || AlwaysPoppableShellScope.of(context);

    final shellState = ref.watch(appShellStateProvider);
    final isMobile = isMobileWidth(context);
    if (shellState.isMobile != isMobile) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!context.mounted) return;
        ref
            .read(appShellStateProvider.notifier)
            .update(
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
            angleDegrees: Theme.of(
              context,
            ).extension<SlantedHeaderThemeData>()!.angleDegrees,
            topSafeAreaInset: MediaQuery.paddingOf(context).top,
          ),
          body: Column(
            children: [
              ?belowHeader,
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(child: body),
                    if (floatingActionButtonExpansion != null)
                      Positioned.fill(
                        child: _FabScrim(
                          expansion: floatingActionButtonExpansion!,
                        ),
                      ),
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

/// Dims [body] while [expansion] is `true`, and tapping anywhere on the dim
/// sets it back to `false` — the backdrop [AppScaffold] shows behind an
/// expandable FAB. Sits between [body] and the FAB/back-button [Positioned]
/// entries in the same [Stack], so it never covers them.
class _FabScrim extends StatelessWidget {
  const _FabScrim({required this.expansion});

  final ValueNotifier<bool> expansion;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<FabButtonThemeData>()!;
    return ValueListenableBuilder<bool>(
      valueListenable: expansion,
      builder: (context, open, child) {
        return IgnorePointer(
          ignoring: !open,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => expansion.value = false,
            child: AnimatedOpacity(
              duration: theme.scrimAnimationDuration,
              curve: theme.scrimAnimationCurve,
              opacity: open ? 1 : 0,
              child: ColoredBox(color: theme.barrierColor),
            ),
          ),
        );
      },
    );
  }
}
