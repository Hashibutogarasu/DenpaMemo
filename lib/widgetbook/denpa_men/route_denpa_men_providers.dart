import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/denpa_men/denpa_men.dart';
import 'route_denpa_men_data.dart';

/// Serves [RouteDenpaMenData.all] through a [Provider].
final routeDenpaMenListProvider = Provider<List<DenpaMen>>((ref) {
  return RouteDenpaMenData.all;
});
