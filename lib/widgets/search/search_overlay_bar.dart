import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../i18n/gen/strings.g.dart';
import '../../providers/denpa_men_providers.dart';
import '../../providers/search_providers.dart';
import '../../theme/app_colors.dart';

/// Overlay search bar that slides down from the top of the screen when
/// Ctrl+F is pressed, and back up when dismissed. Binds its input directly
/// to [searchQueryProvider]'s name field, so typing here filters the home
/// screen through the same search pipeline used by the dedicated search
/// page.
///
/// Always mounted (visibility is animated via [searchOverlayOpenProvider])
/// rather than conditionally inserted into the tree, so the slide-out plays
/// instead of the bar disappearing instantly.
class SearchOverlayBar extends ConsumerStatefulWidget {
  const SearchOverlayBar({
    super.key,
    this.duration = const Duration(milliseconds: 200),
    this.margin = const EdgeInsets.all(16),
  });

  final Duration duration;
  final EdgeInsetsGeometry margin;

  @override
  ConsumerState<SearchOverlayBar> createState() => _SearchOverlayBarState();
}

class _SearchOverlayBarState extends ConsumerState<SearchOverlayBar> {
  final _focusNode = FocusNode();
  late final _controller = TextEditingController(
    text: ref.read(searchQueryProvider).name,
  );

  void _updateName(String value) {
    ref.read(searchQueryProvider.notifier).update((q) => q.copyWith(name: value));
  }

  void _clear() {
    _controller.clear();
    _updateName('');
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final open = ref.watch(searchOverlayOpenProvider);

    ref.listen(searchOverlayOpenProvider, (previous, next) {
      if (next) {
        _focusNode.requestFocus();
      } else {
        _focusNode.unfocus();
        _clear();
      }
    });

    return IgnorePointer(
      ignoring: !open,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: widget.margin,
          child: AnimatedSlide(
            duration: widget.duration,
            curve: Curves.easeOutCubic,
            offset: open ? Offset.zero : const Offset(0, -1.5),
            child: AnimatedOpacity(
              duration: widget.duration,
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
                          controller: _controller,
                          focusNode: _focusNode,
                          decoration: InputDecoration(
                            hintText: t.home.searchHint,
                            border: InputBorder.none,
                          ),
                          onChanged: _updateName,
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
