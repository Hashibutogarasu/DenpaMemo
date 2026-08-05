import 'package:denpa_memo/data/master_data/json_master_data_repository.dart';
import 'package:denpa_memo/domain/master_data/anntena.dart';
import 'package:denpa_memo/domain/master_data/head_shape.dart';
import 'package:denpa_memo/domain/master_data/master_data.dart';
import 'package:denpa_memo/domain/qr_code/attribute_resistance_reverse_calculator.dart';
import 'package:denpa_memo/domain/qr_code/denpa_men.dart';
import 'package:denpa_memo/domain/qr_code/denpa_men_factory.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MasterData masterData;

  setUpAll(() async {
    masterData = await JsonMasterDataRepository().load();
  });

  DenpaMen build(List<String> bodyColors, {bool isSpColor = false}) {
    return createDenpaMen(
      bodyColors: bodyColors,
      isSpColor: isSpColor,
      headShape: const HeadShape(id: 'head-a', displayName: 'head-a'),
      physique: masterData.physiques.first,
      personality: masterData.personalities.first,
      pattern: masterData.patterns.first,
      anntena: const Anntena(id: 'anntena-a', displayName: 'anntena-a'),
      masterData: masterData,
    );
  }

  void expectRoundTrip(List<String> bodyColors, {bool isSpColor = false}) {
    final target = build(bodyColors, isSpColor: isSpColor).attributeResistance;

    final found = findBodyColorCombinationForAttributeResistance(
      targetAttributeResistance: target,
      masterData: masterData,
    );

    expect(found, isNotNull);
    final reconstructed = build(
      found!.bodyColors,
      isSpColor: found.isSpColor,
    ).attributeResistance;

    final targetByAttribute = {
      for (final r in target) r.attributeId: r.value,
    };
    final reconstructedByAttribute = {
      for (final r in reconstructed) r.attributeId: r.value,
    };
    expect(reconstructedByAttribute, targetByAttribute);
  }

  test('reverses blue as an SP color', () {
    expectRoundTrip(const ['blue'], isSpColor: true);
  });

  test('reverses gold as an SP color', () {
    expectRoundTrip(const ['gold'], isSpColor: true);
  });

  test('reverses silver as an SP color', () {
    expectRoundTrip(const ['silver'], isSpColor: true);
  });

  test('reverses pink as an SP color', () {
    expectRoundTrip(const ['pink'], isSpColor: true);
  });

  test('reverses gold + silver', () {
    expectRoundTrip(const ['gold', 'silver']);
  });

  test('reverses pink + pink', () {
    expectRoundTrip(const ['pink', 'pink']);
  });

  test('reverses pink + red', () {
    expectRoundTrip(const ['pink', 'red']);
  });

  test('reverses white + white', () {
    expectRoundTrip(const ['white', 'white']);
  });

  test('reverses yellow + black', () {
    expectRoundTrip(const ['yellow', 'black']);
  });
}
