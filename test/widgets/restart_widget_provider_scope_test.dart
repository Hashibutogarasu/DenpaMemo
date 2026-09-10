import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:denpa_memo/widgets/restart_widget.dart';

/// Mirrors the bug: `routing/app_router.dart` used to expose a top-level
/// `rootNavigatorKey`, a [GlobalKey] created once at load time,
/// independent of anything [RestartWidget] tears down.
final _staleNavigatorKey = GlobalKey<NavigatorState>();

Widget _buggyApp() {
  return RestartWidget(
    child: ProviderScope(
      child: MaterialApp(
        navigatorKey: _staleNavigatorKey,
        home: Scaffold(
          body: ProviderScope(
            child: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => RestartWidget.restartApp(context),
                child: const Text('restart'),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

/// Mirrors the fix: a [StatefulWidget] whose `initState` creates its own
/// [GlobalKey] (like `_ThemedMaterialAppState._router` in `main.dart`
/// creating a fresh [GoRouter] via `createAppRouter()`), so restarting
/// mounts a brand new State — and therefore a brand new key — instead of
/// reusing one that outlives the restarted subtree.
class _FixedApp extends StatefulWidget {
  const _FixedApp();

  @override
  State<_FixedApp> createState() => _FixedAppState();
}

class _FixedAppState extends State<_FixedApp> {
  late final GlobalKey<NavigatorState> _navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      home: Scaffold(
        body: ProviderScope(
          child: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => RestartWidget.restartApp(context),
              child: const Text('restart'),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _fixedApp() {
  return const RestartWidget(child: ProviderScope(child: _FixedApp()));
}

void main() {
  testWidgets('restarting while a page holds a GlobalKey-identified Navigator '
      'reparents its inner ProviderScope instead of rebuilding it', (
    tester,
  ) async {
    await tester.pumpWidget(_buggyApp());

    await tester.tap(find.text('restart'));
    await tester.pumpAndSettle();

    expect(
      tester.takeException(),
      isA<UnsupportedError>().having(
        (e) => e.message,
        'message',
        contains('ProviderScope was rebuilt with a different'),
      ),
    );
  });

  testWidgets(
    'restarting behind a router rebuilt fresh on every mount does not '
    'reparent its inner ProviderScope',
    (tester) async {
      await tester.pumpWidget(_fixedApp());

      await tester.tap(find.text('restart'));
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    },
  );
}
