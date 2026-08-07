import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/objectbox/objectbox.dart';

/// Overridden with the [ObjectBox] instance created in `main` before
/// [runApp], so every provider that depends on it can assume it is ready.
final objectBoxProvider = Provider<ObjectBox>((ref) {
  throw UnimplementedError('objectBoxProvider must be overridden in main()');
});
