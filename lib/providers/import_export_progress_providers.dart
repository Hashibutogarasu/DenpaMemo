import 'package:flutter_riverpod/legacy.dart';

/// Progress of the currently running `.dm` export/import operation, as a
/// 0.0-1.0 fraction. Null when no export/import is in progress; this is
/// also what the progress bar widget uses to hide itself.
final importExportProgressProvider = StateProvider<double?>((ref) => null);
