import 'package:flutter_test/flutter_test.dart';

import 'package:denpa_memo/widgetbook/denpa_men/route_denpa_men_data.dart';
import 'package:denpa_memo/widgetbook/denpa_men/route_denpa_men_seed.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('seeding assets/routes/ individuals does not throw', () async {
    await RouteDenpaMenData.initialize();

    expect(seedRouteDenpaMenIntoObjectBox, returnsNormally);
  });

  test('seeding twice does not throw', () async {
    seedRouteDenpaMenIntoObjectBox();

    expect(seedRouteDenpaMenIntoObjectBox, returnsNormally);
  });
}
