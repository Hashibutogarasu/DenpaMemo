import 'dart:convert';

import 'package:dm_file/dm_file.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('encodeHeader/decodeHeader round-trips dataVersion', () {
    const file = DMFile(dataVersion: '1.2.3');

    final decoded = DMFile.decodeHeader(file.encodeHeader());

    expect(decoded.dataVersion, '1.2.3');
  });

  test('decodeHeader throws DmHeaderReadError for a broken comment', () {
    expect(
      () => DMFile.decodeHeader('not json'),
      throwsA(isA<DmHeaderReadError>()),
    );
  });

  test('decodeHeader throws DmHeaderReadError when dataVersion is missing', () {
    expect(
      () => DMFile.decodeHeader(jsonEncode({'foo': 'bar'})),
      throwsA(isA<DmHeaderReadError>()),
    );
  });

  test('decodeHeader throws DmHeaderReadError when dataVersion is not a string', () {
    expect(
      () => DMFile.decodeHeader(jsonEncode({'dataVersion': 1})),
      throwsA(isA<DmHeaderReadError>()),
    );
  });

  test('decodeHeader throws DmHeaderReadError for null/empty comments', () {
    expect(() => DMFile.decodeHeader(null), throwsA(isA<DmHeaderReadError>()));
    expect(() => DMFile.decodeHeader(''), throwsA(isA<DmHeaderReadError>()));
  });
}
