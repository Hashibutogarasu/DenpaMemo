import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_test/flutter_test.dart';

/// Minimal [ScrollContext] good enough to construct a real, standalone
/// [ScrollPositionWithSingleContext] in a test without a live [Scrollable].
class _FakeScrollContext implements ScrollContext {
  @override
  AxisDirection get axisDirection => AxisDirection.down;

  @override
  double get devicePixelRatio => 1.0;

  @override
  BuildContext? get notificationContext => null;

  @override
  BuildContext get storageContext =>
      throw UnsupportedError('storageContext is not used in this test');

  @override
  TickerProvider get vsync =>
      throw UnsupportedError('vsync is not used in this test');

  @override
  void saveOffset(double offset) {}

  @override
  void setCanDrag(bool value) {}

  @override
  void setIgnorePointer(bool value) {}

  @override
  void setSemanticsActions(Set<SemanticsAction> actions) {}
}

void main() {
  test('offset stays readable without ever attaching or a fallback', () {
    final controller = SafeScrollController();
    addTearDown(controller.dispose);

    expect(controller.offset, 0.0);
  });

  test(
    'animateTo and jumpTo no-op instead of throwing while unattached',
    () async {
      final controller = SafeScrollController();
      addTearDown(controller.dispose);

      await controller.animateTo(
        100,
        duration: const Duration(milliseconds: 1),
        curve: Curves.linear,
      );
      controller.jumpTo(100);
    },
  );

  test('falls back to the wired controller once one is attached', () {
    final controller = SafeScrollController();
    final fallback = ScrollController();
    addTearDown(controller.dispose);
    addTearDown(fallback.dispose);
    controller.fallback = fallback;

    final position = ScrollPositionWithSingleContext(
      physics: const ScrollPhysics(),
      context: _FakeScrollContext(),
      initialPixels: 42,
      keepScrollOffset: false,
    );
    addTearDown(position.dispose);
    fallback.attach(position);

    expect(controller.offset, 42.0);
    expect(controller.position.pixels, 42.0);
  });

  Future<void> pumpContainer(WidgetTester tester, Widget child) {
    return tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            height: 400,
            child: SmoothScrollContainer(child: child),
          ),
        ),
      ),
    );
  }

  Future<void> mouseScroll(WidgetTester tester, Finder over) async {
    final pointer = TestPointer(1, PointerDeviceKind.mouse);
    await tester.sendEventToBinding(
      pointer.addPointer(location: tester.getCenter(over)),
    );
    await tester.sendEventToBinding(pointer.scroll(const Offset(0, 300)));
  }

  testWidgets(
    'mouse-wheel scrolling over a non-scrollable child does not crash the '
    'shared controller',
    (tester) async {
      await pumpContainer(
        tester,
        const ColoredBox(
          color: Colors.transparent,
          child: Center(child: Text('empty')),
        ),
      );
      await tester.pump(const Duration(milliseconds: 1));

      await mouseScroll(tester, find.byType(SmoothScrollContainer));
      await tester.pump();

      expect(tester.takeException(), isNull);

      await tester.pump(const Duration(seconds: 3));
    },
  );

  testWidgets('ScrollableFiller keeps the shared controller attached during a '
      'mouse-wheel scroll', (tester) async {
    await pumpContainer(
      tester,
      const ScrollableFiller(child: Center(child: Text('empty'))),
    );
    await tester.pump(const Duration(milliseconds: 1));

    await mouseScroll(tester, find.byType(SmoothScrollContainer));
    await tester.pump();

    expect(tester.takeException(), isNull);

    await tester.pump(const Duration(seconds: 3));
  });
}
