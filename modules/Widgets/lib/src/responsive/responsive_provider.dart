import 'package:flutter_riverpod/legacy.dart';

/// Whether the app is currently narrower than `kMobileBreakpoint`
/// (see `responsive.dart`).
///
/// Synced from [isMobileWidth] in `AppScaffold` (the common wrapper used by
/// every page), so that any descendant widget can read the current layout
/// mode via `ref.watch` without needing a `BuildContext` of its own or
/// having the value threaded down as a constructor parameter.
final isMobileLayoutProvider = StateProvider<bool>((ref) => false);
