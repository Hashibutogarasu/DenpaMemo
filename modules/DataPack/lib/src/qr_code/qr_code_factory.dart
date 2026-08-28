import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:cuid2/cuid2.dart';

import 'qr_code.dart';

/// Builds a [QrCode], deriving [QrCode.hash] from [rawValue] via sha256.
QrCode createQrCode(
  String rawValue, {
  String? id,
  String? name,
  DateTime? createdAt,
}) {
  return QrCode(
    id: id == null || id.isEmpty ? cuid() : id,
    rawValue: rawValue,
    hash: sha256.convert(utf8.encode(rawValue)).toString(),
    createdAt: createdAt ?? DateTime.now(),
    name: name,
  );
}
