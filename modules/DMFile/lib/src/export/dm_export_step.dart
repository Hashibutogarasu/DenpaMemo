import 'package:data_pack/data_pack.dart';
import 'package:step_dialog/step_dialog.dart' hide Translations;

/// A `.dm` export's step (see `DmExportContext`), run in sequence by the
/// batch runner in `dm_export_step_runner.dart`.
abstract class DmExportStep extends Step<DmExportContext> {}
