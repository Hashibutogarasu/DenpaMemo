import 'package:flutter/material.dart' hide Step;
import 'package:flutter_test/flutter_test.dart';

import 'package:step_dialog/step_dialog.dart';

class _BatchContext {
  _BatchContext(this.label);

  final String label;
}

class _CountingStep extends Step<_BatchContext> {
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
        } on StepRunFailure<_BatchContext> catch (failure) {
          await ErrorDialog.show(
            appContext,
            title: 'Step failed',
            description: '${failure.error}',
            retriable: failure.retriable,
            onRetry: failure.retry,
          );
        }
      }

      final batchA = runBatch(stepA, _BatchContext('A'));
      final batchB = runBatch(stepB, _BatchContext('B'));

      await tester.pump();
      await tester.pump();

      final t = Translations();
      expect(find.text('Exception: boom in A'), findsOneWidget);
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
