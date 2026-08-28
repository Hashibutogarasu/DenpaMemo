import 'dart:convert';

import 'package:crypto/crypto.dart';

import 'denpa_men.dart';

/// Derives a sha256 hash over [denpaMen]'s core game-data fields, excluding
/// its cuid and the mutable/environment-dependent fields
/// ([DenpaMen.qrCodeId], [DenpaMen.catchOrder], [DenpaMen.memo],
/// [DenpaMen.moveInDate]) and the [DenpaMen.hash] field itself.
String computeDenpaMenHash(DenpaMen denpaMen) {
  final json = denpaMen.toJson()
    ..remove('id')
    ..remove('qrCodeId')
    ..remove('catchOrder')
    ..remove('memo')
    ..remove('moveInDate')
    ..remove('hash');
  return sha256.convert(utf8.encode(jsonEncode(json))).toString();
}
