import '../step.dart';
import 'dm_import_context.dart';

/// A `.dm` import's step (see `DmImportContext`), run in sequence by the
/// batch runner in `dm_import_step_runner.dart`.
abstract class DmImportStep extends Step<DmImportContext> {}
