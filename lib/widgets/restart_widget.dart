import 'package:flutter/widgets.dart';

/// Wraps [child] behind a [Key] that [restartApp] can swap out, forcing
/// every widget below this point (all pages, the router's navigation
/// stack, and any local widget state) to be torn down and rebuilt from
/// scratch. Anything above this widget (in particular the `ProviderScope`
/// in `main.dart`) stays mounted, so Riverpod's own provider state is
/// unaffected — callers that also need providers to reflect fresh data
/// should invalidate them before calling [restartApp].
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
