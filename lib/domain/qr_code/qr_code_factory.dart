import 'dart:convert';

import 'package:crypto/crypto.dart';

import 'qr_code.dart';

/// Builds a [QrCode], deriving [QrCode.hash] from [rawValue] via sha256.
QrCode createQrCode(String rawValue, {DateTime? createdAt}) {
  return QrCode(
    rawValue: rawValue,
    hash: sha256.convert(utf8.encode(rawValue)).toString(),
    createdAt: createdAt ?? DateTime.now(),
  );
}
