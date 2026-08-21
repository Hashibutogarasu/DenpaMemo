import 'package:denpa_memo/domain/backup/dm_import_error.dart';
import 'package:denpa_memo/i18n/gen/strings.g.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final t = Translations();

  test('DenpaMenEntryParseError.description uses the name when present', () {
    final error = DenpaMenEntryParseError(
      index: 0,
      rawEntry: {
        'denpaMen': {'name': 'Named Individual'},
      },
    );

    expect(error.description(t), contains('Named Individual'));
  });

  test(
    'DenpaMenEntryParseError.description falls back to the index when there is no name',
    () {
      expect(
        DenpaMenEntryParseError(index: 4, rawEntry: 'not a map').description(t),
        t.backup.importEntryParseErrorDescriptionIndexed(index: 5),
      );
      expect(
        DenpaMenEntryParseError(index: 4, rawEntry: {'foo': 'bar'}).description(t),
        t.backup.importEntryParseErrorDescriptionIndexed(index: 5),
      );
      expect(
        DenpaMenEntryParseError(
          index: 4,
          rawEntry: {
            'denpaMen': {'name': 42},
          },
        ).description(t),
        t.backup.importEntryParseErrorDescriptionIndexed(index: 5),
      );
    },
  );

  test('DmHeaderReadError has fixed title/description', () {
    const error = DmHeaderReadError();

    expect(error.title(t), t.backup.importHeaderErrorTitle);
    expect(error.description(t), t.backup.importHeaderErrorDescription);
  });
}
