import 'package:data_pack/data_pack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'route_denpa_men_data.dart';

/// Serves [RouteDenpaMenData.all] through a [Provider].
final routeDenpaMenListProvider = Provider<List<DenpaMen>>((ref) {
  return RouteDenpaMenData.all;
});
