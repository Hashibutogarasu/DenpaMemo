import '../step.dart';
import 'dm_export_context.dart';

/// A `.dm` export's step (see `DmExportContext`), run in sequence by the
/// batch runner in `dm_export_step_runner.dart`.
abstract class DmExportStep extends Step<DmExportContext> {}
