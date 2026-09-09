import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/background_service.dart';
import '../services/foreground_service.dart';

final backgroundServiceProvider = Provider<BackgroundService>(
  (ref) => BackgroundService(),
);

final foregroundServiceProvider = Provider<ForegroundService>(
  (ref) => ForegroundService(),
);
