import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Holds a single scrollable's offset, surviving its owning widget tree
/// being discarded and rebuilt on tab switches.
class ScrollOffsetNotifier extends Notifier<double> {
  @override
  double build() => 0.0;

  void set(double offset) {
    if (offset == state) return;
    state = offset;
  }
}

/// A [ScrollController] that mirrors its offset into a [ScrollOffsetNotifier]
/// as it scrolls, and seeds its initial offset from that notifier's current
/// state. Guards every read of [offset] behind [hasClients] itself, so
/// callers don't each need to remember that a controller can go temporarily
/// unattached (e.g. its scrollable is swapped out for an empty-state widget,
/// or briefly detaches mid-transition between two scrollables) and crash
/// reading [offset] while detached.
class PersistedScrollController extends ScrollController {
  PersistedScrollController({
    required this.notifier,
    required double initialOffset,
  }) : super(initialScrollOffset: initialOffset) {
    addListener(_onScroll);
  }

  final ScrollOffsetNotifier notifier;

  void _onScroll() {
    if (!hasClients) return;
    notifier.set(offset);
  }

  @override
  void dispose() {
    removeListener(_onScroll);
    super.dispose();
  }
}

final homeScrollOffsetProvider = NotifierProvider<ScrollOffsetNotifier, double>(
  ScrollOffsetNotifier.new,
);

final settingsScrollOffsetProvider =
    NotifierProvider<ScrollOffsetNotifier, double>(ScrollOffsetNotifier.new);
