import 'package:dm_file/dm_file.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('DenpaMenEntryParseError.entryName reads a string denpaMen.name', () {
    final error = DenpaMenEntryParseError(
      index: 0,
      rawEntry: {
        'denpaMen': {'name': 'Named Individual'},
      },
    );

    expect(error.entryName, 'Named Individual');
  });

  test('DenpaMenEntryParseError.entryName is null when there is no name', () {
    expect(DenpaMenEntryParseError(index: 4, rawEntry: 'not a map').entryName, isNull);
    expect(DenpaMenEntryParseError(index: 4, rawEntry: {'foo': 'bar'}).entryName, isNull);
    expect(
      DenpaMenEntryParseError(
        index: 4,
        rawEntry: {
          'denpaMen': {'name': 42},
        },
      ).entryName,
      isNull,
    );
  });

  test('DenpaMenEntryParseError exposes index and rawEntry', () {
    final error = DenpaMenEntryParseError(index: 2, rawEntry: 'broken');

    expect(error.index, 2);
    expect(error.rawEntry, 'broken');
  });

  test('DmHeaderReadError constructs', () {
    expect(const DmHeaderReadError(), isA<FormatException>());
  });
}
