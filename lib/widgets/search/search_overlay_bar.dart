import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../i18n/gen/strings.g.dart';
import '../../providers/denpa_men_providers.dart';
import '../../theme/app_colors.dart';

/// Overlay search bar that slides down from the top of the screen when
/// Ctrl+F is pressed, and back up when dismissed. This is only the input
/// surface and dismiss affordance — search itself is not implemented yet.
///
/// Always mounted (visibility is animated via [searchOverlayOpenProvider])
/// rather than conditionally inserted into the tree, so the slide-out plays
/// instead of the bar disappearing instantly.
class SearchOverlayBar extends ConsumerWidget {
  const SearchOverlayBar({
    super.key,
    this.duration = const Duration(milliseconds: 200),
    this.margin = const EdgeInsets.all(16),
  });

  final Duration duration;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final open = ref.watch(searchOverlayOpenProvider);

    return IgnorePointer(
      ignoring: !open,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: margin,
          child: AnimatedSlide(
            duration: duration,
            curve: Curves.easeOutCubic,
            offset: open ? Offset.zero : const Offset(0, -1.5),
            child: AnimatedOpacity(
              duration: duration,
              curve: Curves.easeOutCubic,
              opacity: open ? 1 : 0,
              child: Material(
                color: Theme.of(context).scaffoldBackgroundColor,
                elevation: 8,
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: AppColors.accent),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          autofocus: true,
                          decoration: InputDecoration(
                            hintText: t.home.searchHint,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: AppColors.accent),
                        onPressed: () =>
                            ref.read(searchOverlayOpenProvider.notifier)
                                .state = false,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
