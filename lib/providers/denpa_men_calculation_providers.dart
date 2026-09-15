import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/denpa_men_rust_calculator.dart';

/// Provides the native calculation engine used by the running application.
final denpaMenCalculationEngineProvider = Provider<DenpaMenCalculationEngine>(
  (ref) => const DenpaMenRustCalculator(),
);
