import 'package:dm_file/dm_file.dart';

import '../../i18n/gen/strings.g.dart';

String describeDenpaMenEntryParseError(Translations t, DenpaMenEntryParseError error) {
  final name = error.entryName;
  return name != null
      ? t.backup.importEntryParseErrorDescriptionNamed(name: name)
      : t.backup.importEntryParseErrorDescriptionIndexed(index: error.index + 1);
}
