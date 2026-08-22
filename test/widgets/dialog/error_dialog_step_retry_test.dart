import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:denpa_memo/domain/step.dart' as domain_step;
import 'package:denpa_memo/domain/step_batch.dart';
import 'package:denpa_memo/domain/step_failure.dart';
import 'package:denpa_memo/i18n/gen/strings.g.dart';
import 'package:denpa_memo/widgets/dialog/error_dialog.dart';

class _BatchContext {
  _BatchContext(this.label);

  final String label;
}

class _CountingStep extends domain_step.Step<_BatchContext> {
  _CountingStep({this.failOnFirstRun = false});

  final bool failOnFirstRun;
  int runCount = 0;
  int retryCount = 0;
  bool _hasFailedOnce = false;

  @override
  bool get retriable => true;

  @override
  Future<void> run(_BatchContext context) async {
    runCount++;
    if (failOnFirstRun && !_hasFailedOnce) {
      _hasFailedOnce = true;
      throw Exception('boom in ${context.label}');
    }
  }

  @override
  Future<void> retry(_BatchContext context) async {
    retryCount++;
    await run(context);
  }
}

void main() {
  testWidgets(
    'a step failure in one of two concurrent batches shows its own dialog, '
    'and retrying it retries only that batch\'s step, leaving the other '
    'batch untouched',
    (tester) async {
      late BuildContext appContext;
      await tester.pumpWidget(
        TranslationProvider(
          child: MaterialApp(
            home: Builder(
              builder: (context) {
                appContext = context;
                return const SizedBox();
              },
            ),
          ),
        ),
      );

      final stepA = _CountingStep(failOnFirstRun: true);
      final stepB = _CountingStep();

      Future<void> runBatch(_CountingStep step, _BatchContext context) async {
        try {
          await [step].runAll(context);
        } on StepFailure<_BatchContext> catch (failure) {
          await ErrorDialog.show(appContext, error: failure);
        }
      }

      final batchA = runBatch(stepA, _BatchContext('A'));
      final batchB = runBatch(stepB, _BatchContext('B'));

      await tester.pump();
      await tester.pump();

      final t = Translations();
      expect(find.text(t.step.failureDescription(error: 'Exception: boom in A')), findsOneWidget);
      expect(find.textContaining('boom in B'), findsNothing);

      expect(stepB.runCount, 1);
      expect(stepB.retryCount, 0);

      await tester.tap(find.text(t.common.retry));
      await tester.pump();

      await batchA;
      await batchB;
      await tester.pump();
      await tester.pump();

      expect(find.byType(ErrorDialog), findsNothing);
      expect(stepA.retryCount, 1);
      expect(stepA.runCount, 2);
      expect(stepB.retryCount, 0);
      expect(stepB.runCount, 1);
    },
  );
}
