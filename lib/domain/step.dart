import 'package:flutter/foundation.dart';

import 'step_progress.dart';

/// One step of a multi-step, progress-reporting batch operation against a
/// [C] working context, run in sequence by a batch runner. Extends
/// [ChangeNotifier] so the runner can observe [progress] as it changes
/// (including within-step, entry-by-entry updates) without each step
/// needing to know its own position among the others — [stepIndex] and
/// [totalSteps] are assigned by the runner right before [run] is called.
///
/// Not scoped to any one feature (e.g. `.dm` export/import) — subclass per
/// feature (see `DmExportStep` in `backup/dm_export_step.dart`) so this
/// same step/batch-runner shape can back other progress-reporting flows.
abstract class Step<C> extends ChangeNotifier {
  int stepIndex = 0;
  int totalSteps = 1;

  double? _progress;

  double? get progress => _progress;

  /// Reports that this step has completed [entryIndex] out of [entryCount]
  /// of its own work, updating [progress] and calling [notifyListeners].
  /// Steps with no natural sub-entries (or that only report completion)
  /// call this with the defaults.
  @protected
  void reportProgress({int entryIndex = 0, int entryCount = 1}) {
    _progress = stepProgressWithinEntries(
      stepIndex + 1,
      totalSteps,
      entryIndex,
      entryCount,
    );
    notifyListeners();
  }

  /// Performs this step's actual work against [context].
  Future<void> run(C context);

  /// Cleans up any resources this step created in [run], regardless of
  /// whether the batch as a whole succeeded. No-op by default; steps that
  /// create temporary resources (e.g. a work directory) override this.
  Future<void> cleanup(C context) async {}

  /// Whether [retry] has a real implementation for this step. `false` by
  /// default, meaning [retry] behaves exactly like calling [run] again —
  /// steps whose failures need different recovery logic (or that can't
  /// safely be re-attempted at all) should override both this and
  /// [retry].
  bool get retriable => false;

  /// Re-attempts this step's work after [run] failed. Defaults to calling
  /// [run] again.
  Future<void> retry(C context) => run(context);
}
