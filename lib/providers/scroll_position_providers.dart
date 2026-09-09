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

final homeScrollOffsetProvider = NotifierProvider<ScrollOffsetNotifier, double>(
  ScrollOffsetNotifier.new,
);

final settingsScrollOffsetProvider =
    NotifierProvider<ScrollOffsetNotifier, double>(ScrollOffsetNotifier.new);
