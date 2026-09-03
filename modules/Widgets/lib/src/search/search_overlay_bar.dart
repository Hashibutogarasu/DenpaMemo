import 'package:flutter/material.dart';

import '../../i18n/gen/strings.g.dart';
import '../theme/denpa_men_container_theme.dart';

/// Overlay search bar that slides down from the top of the screen when
/// [open] is true, and back up when it isn't. [queryName] mirrors the
/// current search name filter; typing here calls [onQueryNameChanged].
///
/// Always mounted (visibility is animated via [open]) rather than
/// conditionally inserted into the tree, so the slide-out plays instead of
/// the bar disappearing instantly.
class SearchOverlayBar extends StatefulWidget {
  const SearchOverlayBar({
    super.key,
    required this.open,
    required this.queryName,
    required this.onQueryNameChanged,
    required this.onClose,
    this.duration = const Duration(milliseconds: 200),
    this.margin = const EdgeInsets.all(16),
  });

  final bool open;
  final String queryName;
  final ValueChanged<String> onQueryNameChanged;
  final VoidCallback onClose;
  final Duration duration;
  final EdgeInsetsGeometry margin;

  @override
  State<SearchOverlayBar> createState() => _SearchOverlayBarState();
}

class _SearchOverlayBarState extends State<SearchOverlayBar> {
  final _focusNode = FocusNode();
  late final _controller = TextEditingController(text: widget.queryName);

  void _clear() {
    _controller.clear();
    widget.onQueryNameChanged('');
  }

  @override
  void didUpdateWidget(covariant SearchOverlayBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.open != oldWidget.open) {
      if (widget.open) {
        _focusNode.requestFocus();
      } else {
        _focusNode.unfocus();
        _clear();
      }
    }
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
    final open = widget.open;
    final theme = Theme.of(context).extension<DenpaMenContainerThemeData>()!;

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
                      Icon(Icons.search, color: theme.accentColor),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          focusNode: _focusNode,
                          decoration: InputDecoration(
                            hintText: t.home.searchHint,
                            border: InputBorder.none,
                          ),
                          onChanged: widget.onQueryNameChanged,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: theme.accentColor),
                        onPressed: widget.onClose,
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
