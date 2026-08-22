import 'step.dart';
import 'step_failure.dart';

/// Runs a list of [Step]s in order against [context], forwarding each
/// step's progress (including its within-step, entry-by-entry updates)
/// to [onProgress] as it happens, and calling [Step.cleanup] on every
/// step that ran (in reverse), whether the run succeeded or a step
/// threw. Generic counterpart of `DmExportStepBatch`/`DmImportStepBatch`
/// (`domain/backup/`), for any feature that wants this same
/// step/batch-runner shape without a dedicated context/step hierarchy.
///
/// A step that throws is wrapped in [StepFailure] (carrying that exact
/// step and [context]) before rethrowing, so a caller catching it can
/// show the failure via `ErrorDialog` with a working retry button, with
/// zero shared state against any other batch running concurrently.
extension StepBatch<C> on List<Step<C>> {
  Future<void> runAll(C context, {void Function(double? progress)? onProgress}) async {
    final ranSteps = <Step<C>>[];
    try {
      for (var i = 0; i < length; i++) {
        final step = this[i];
        step
          ..stepIndex = i
          ..totalSteps = length;
        ranSteps.add(step);
        void listener() => onProgress?.call(step.progress);
        step.addListener(listener);
        try {
          await step.run(context);
        } catch (error) {
          throw StepFailure<C>(step: step, context: context, error: error);
        } finally {
          step.removeListener(listener);
        }
      }
    } finally {
      for (final step in ranSteps.reversed) {
        await step.cleanup(context);
        step.dispose();
      }
      onProgress?.call(null);
    }
  }
}
