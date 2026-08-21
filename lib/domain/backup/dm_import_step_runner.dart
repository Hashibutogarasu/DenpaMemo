import 'dm_import_context.dart';
import 'dm_import_step.dart';

/// Runs a list of [DmImportStep]s in order against [context], forwarding
/// each step's progress (including its within-step, entry-by-entry
/// updates) to [DmImportContext.onProgress] as it happens. Calls
/// [DmImportStep.cleanup] on every step that ran, whether the run
/// succeeded or a step threw. Callers are responsible for clearing their
/// own progress display once this returns (or throws).
extension DmImportStepBatch on List<DmImportStep> {
  Future<void> runAll(DmImportContext context) async {
    final ranSteps = <DmImportStep>[];
    try {
      for (var i = 0; i < length; i++) {
        final step = this[i];
        step
          ..stepIndex = i
          ..totalSteps = length;
        ranSteps.add(step);
        void listener() => context.onProgress(step.progress);
        step.addListener(listener);
        try {
          await step.run(context);
        } finally {
          step.removeListener(listener);
        }
      }
    } finally {
      for (final step in ranSteps.reversed) {
        await step.cleanup(context);
        step.dispose();
      }
    }
  }
}
