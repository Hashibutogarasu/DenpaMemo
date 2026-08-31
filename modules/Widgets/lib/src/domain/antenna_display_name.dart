import 'package:data_pack/data_pack.dart';

import '../../i18n/gen/strings.g.dart';

String antennaDisplayName(Translations t, Anntena anntena, int antennaLevel) {
  final translated = t.antenna[anntena.id];
  if (translated == null) {
    return anntena.id;
  }
  if (antennaLevel > 0) {
    return t.editableStatus.antennaNameWithPlusLevel(
      name: translated,
      plusLevel: antennaLevel,
    );
  }
  return translated;
}
