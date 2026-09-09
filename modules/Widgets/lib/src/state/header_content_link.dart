import 'package:flutter/widgets.dart';

import 'package:flutter_riverpod/legacy.dart';

/// Bridges [AppScaffold]'s body to the overlaid [SlantedAppBar], so the
/// header can react to scroll position and body size without either being
/// threaded through constructor parameters. [AppScaffold] scopes one
/// instance per subtree via a `ProviderScope` override of [headerContentLinkProvider].
class HeaderContentLink extends ChangeNotifier {
  double _scrollOffset = 0;

  double get scrollOffset => _scrollOffset;

  final GlobalKey bodyKey = GlobalKey();

  void setScrollOffset(double offset) {
    if (offset == _scrollOffset) return;
    _scrollOffset = offset;
    notifyListeners();
  }
}

/// Default, unscoped [HeaderContentLink]. [AppScaffold] overrides this per
/// instance so each page gets its own scroll offset and body key instead of
/// sharing app-wide state.
final headerContentLinkProvider = ChangeNotifierProvider<HeaderContentLink>((
  ref,
) {
  return HeaderContentLink();
});
