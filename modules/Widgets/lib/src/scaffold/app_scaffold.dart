import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../header/slanted_app_bar.dart';
import '../navigation/app_back_button.dart';
import '../state/header_content_link.dart';
import '../theme/back_button_theme.dart';
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

/// Standard page shell: a single [Stack] with the scrollable [body] at the
/// bottom and [SlantedAppBar] overlaid above it, so [body] shows through
/// the header's transparent slanted corner. Header and body share scroll
/// offset/size via [headerContentLinkProvider]. Also binds Escape to pop.
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.title,
    required this.body,
    this.floatingActionButton,
    this.floatingActionButtonExpansion,
    this.actions,
    this.buttonInset = 16,
    this.onBackPressed,
    this.backButtonExtras = const [],
    this.additionalShortcuts = const {},
    this.belowHeader,
  });

  final Widget title;
  final Widget body;
  final Widget? floatingActionButton;

  final ValueNotifier<bool>? floatingActionButtonExpansion;
  final List<Widget>? actions;
  final double buttonInset;
  final VoidCallback? onBackPressed;
  final List<Widget> backButtonExtras;
  final Widget? belowHeader;

  final Map<ShortcutActivator, VoidCallback> additionalShortcuts;

  static const double _headerHeight = 56;

  @override
  Widget build(BuildContext context) {
    final canPop =
        Navigator.canPop(context) || AlwaysPoppableShellScope.of(context);
    final contentHeight = SlantedAppBar.contentHeightFor(
      height: _headerHeight,
      topSafeAreaInset: MediaQuery.paddingOf(context).top,
    );

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
          body: ProviderScope(
            overrides: [
              headerContentLinkProvider.overrideWith(
                (ref) => HeaderContentLink(),
              ),
            ],
            child: Consumer(
              builder: (context, ref, child) {
                return Stack(
                  children: [
                    Positioned.fill(
                      child: NotificationListener<ScrollMetricsNotification>(
                        onNotification: (notification) {
                          ref
                              .read(headerContentLinkProvider)
                              .setScrollOffset(notification.metrics.pixels);
                          return false;
                        },
                        child: NotificationListener<ScrollNotification>(
                          onNotification: (notification) {
                            ref
                                .read(headerContentLinkProvider)
                                .setScrollOffset(notification.metrics.pixels);
                            return false;
                          },
                          child: Padding(
                            key: ref.read(headerContentLinkProvider).bodyKey,
                            padding: EdgeInsets.only(top: contentHeight),
                            child: body,
                          ),
                        ),
                      ),
                    ),
                    if (belowHeader != null)
                      Positioned(
                        top: contentHeight,
                        left: 0,
                        right: 0,
                        child: belowHeader!,
                      ),
                    if (floatingActionButtonExpansion != null)
                      Positioned.fill(
                        child: _FabScrim(
                          expansion: floatingActionButtonExpansion!,
                        ),
                      ),
                    if (canPop) _buildBackButtonCluster(context),
                    if (floatingActionButton != null)
                      Positioned(
                        right: buttonInset,
                        bottom: buttonInset,
                        child: floatingActionButton!,
                      ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: SlantedAppBar(
                        title: title,
                        actions: actions,
                        angleDegrees: Theme.of(
                          context,
                        ).extension<SlantedHeaderThemeData>()!.angleDegrees,
                        height: _headerHeight,
                        topSafeAreaInset: MediaQuery.paddingOf(context).top,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackButtonCluster(BuildContext context) {
    final anchor = Theme.of(context).extension<BackButtonThemeData>()!.anchor;
    final isTop = anchor.isTop;
    final isLeft = anchor.isLeft;
    final gap = SizedBox(
      height: Theme.of(
        context,
      ).extension<FabButtonThemeData>()!.miniOptionRowBottomPadding,
    );
    final backButton = AppBackButton(onPressed: onBackPressed);

    return Positioned(
      left: isLeft ? buttonInset : null,
      right: isLeft ? null : buttonInset,
      top: isTop ? buttonInset : null,
      bottom: isTop ? null : buttonInset,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: isLeft
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        children: isTop
            ? [
                backButton,
                for (final extra in backButtonExtras) ...[gap, extra],
              ]
            : [
                for (final extra in backButtonExtras) ...[extra, gap],
                backButton,
              ],
      ),
    );
  }
}

/// Dims [body] while [expansion] is `true`; tapping it sets it back to
/// `false`. Sits between [body] and the FAB/back-button [Positioned]
/// entries in the same [Stack].
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
