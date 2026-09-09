import 'package:flutter_riverpod/legacy.dart';

import 'cancellation.dart';

/// The [Cancellation] for whichever cloud backup upload/restore is
/// currently running, or null if neither is. Since
/// `cloudBackupBusyProvider` (lib/widgets/scaffold/cloud_backup_shell.dart)
/// already ensures at most one of the two can run at a time, a single
/// shared slot is sufficient. Lets a UI button request cancellation
/// directly, instead of routing through a dismissible snackbar.
final activeCancellationProvider = StateProvider<Cancellation?>((ref) => null);
