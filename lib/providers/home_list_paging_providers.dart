import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/home/denpa_men_home_screen.dart';

/// Holds how many records the home list currently reveals, surviving the
/// home tab's widget tree being discarded and rebuilt on tab switches.
class HomeListVisibleCountNotifier extends Notifier<int> {
  @override
  int build() => homeListDefaultPageSize;

  void loadMore(int totalCount) {
    final next = state + homeListDefaultPageSize;
    state = next > totalCount ? totalCount : next;
  }

  void reset() {
    state = homeListDefaultPageSize;
  }
}

final homeListVisibleCountProvider =
    NotifierProvider<HomeListVisibleCountNotifier, int>(
      HomeListVisibleCountNotifier.new,
    );
