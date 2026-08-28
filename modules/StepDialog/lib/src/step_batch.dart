import 'step.dart';
import 'step_run_failure.dart';

/// Runs [Step]s in order against [context], forwarding progress to
/// [onProgress] and calling [Step.cleanup] on every step that ran (in
/// reverse), whether the run succeeded or a step threw. A step that throws
/// is wrapped in [StepRunFailure] before rethrowing.
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
          throw StepRunFailure<C>(step: step, context: context, error: error);
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
