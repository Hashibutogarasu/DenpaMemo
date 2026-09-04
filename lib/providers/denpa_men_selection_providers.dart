import 'package:data_pack/data_pack.dart';
import 'package:flutter_riverpod/legacy.dart';

/// The individuals picked so far by [DenpaMenSelectionPage]'s list tab and
/// its search-results sub-page. Reset by [DenpaMenSelectionPage.dispose]
/// once the flow ends, since it is a single shared flow-scoped selection.
final denpaMenSelectionProvider = StateProvider<List<DenpaMenRecord>>(
  (ref) => [],
);
