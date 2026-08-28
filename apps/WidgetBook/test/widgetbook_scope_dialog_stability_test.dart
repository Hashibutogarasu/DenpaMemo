import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:denpamemo_widgets/testing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:widgetbook_app/core/dialog_preview.dart';
import 'package:widgetbook_app/core/widgetbook_scope.dart';

/// A dialog widget that reads `context.t`, matching how the real dialog
/// use cases (e.g. `HeadShapeSelectionDialog`) depend on
/// [TranslationProvider] being an ancestor of the dialog route itself.
class _TranslatedDialog extends StatelessWidget {
  const _TranslatedDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(title: Text(context.t.common.confirm));
  }
}

void main() {
  testWidgets(
    'a dialog opened through widgetbookScope keeps its TranslationProvider '
    'ancestor across a rebuild with a different knob-driven child',
    (tester) async {
      await tester.runAsync(RouteDenpaMenData.initialize);

      Widget build(BuildContext context, int generation) => widgetbookScope(
        context,
        DialogPreview(
          key: ValueKey(generation),
          builder: (context) => const _TranslatedDialog(),
        ),
      );

      await tester.pumpWidget(
        Builder(builder: (context) => build(context, 0)),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.byType(_TranslatedDialog), findsOneWidget);

      // Simulate a knob change: Widgetbook re-invokes the use case
      // function, producing a brand new [DialogPreview] instance.
      await tester.pumpWidget(
        Builder(builder: (context) => build(context, 1)),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.byType(_TranslatedDialog), findsOneWidget);
    },
  );
}
