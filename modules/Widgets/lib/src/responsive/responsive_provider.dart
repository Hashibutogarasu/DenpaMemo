import 'package:flutter_riverpod/legacy.dart';

/// Cross-cutting UI state shared via `ref` instead of a `BuildContext` or
/// constructor parameters: [isMobile] (synced from `AppScaffold`, the
/// common page wrapper) and [isLoading] (set by a page to have
/// `AppScaffold` render its `ProgressBar`, instead of the page rendering
/// its own loading indicator).
typedef AppShellState = ({bool isMobile, bool isLoading});

final appShellStateProvider = StateProvider<AppShellState>(
  (ref) => const (isMobile: false, isLoading: false),
);
