import 'dm_export_step.dart';
import 'package:data_pack/data_pack.dart';

/// Runs a list of [DmExportStep]s in order against [context], forwarding
/// each step's progress (including its within-step, entry-by-entry
/// updates) to [DmExportContext.onProgress] as it happens. Calls
/// [DmExportStep.cleanup] on every step that ran and clears the reported
/// progress once done, whether the run succeeded or a step threw.
extension DmExportStepBatch on List<DmExportStep> {
  Future<void> runAll(DmExportContext context) async {
    final ranSteps = <DmExportStep>[];
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
      context.onProgress(null);
    }
  }
}
