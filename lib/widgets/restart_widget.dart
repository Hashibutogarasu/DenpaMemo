import 'package:flutter/widgets.dart';

/// Wraps [child] behind a [Key] that [restartApp] can swap out, forcing
/// everything below this point to be torn down and rebuilt from scratch:
/// all pages, the router's navigation stack, any local widget state, and —
/// when [child] is (or contains) a `ProviderScope`, as in `main.dart` —
/// every Riverpod provider's cached state too, since the old
/// `ProviderContainer` is disposed along with the old `ProviderScope`
/// element and a fresh one takes its place. Override values passed into
/// that `ProviderScope` (e.g. an already-open database connection) are
/// themselves untouched, since they live in the caller, not the container.
class RestartWidget extends StatefulWidget {
  const RestartWidget({super.key, required this.child});

  final Widget child;

  /// Forces a full rebuild of the [RestartWidget] ancestor's subtree.
  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()?.restartApp();
  }

  @override
  State<RestartWidget> createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key _key = UniqueKey();

  void restartApp() {
    setState(() {
      _key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(key: _key, child: widget.child);
  }
}
