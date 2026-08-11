import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:qr/qr.dart';

/// Rasterizes [data] as a QR code PNG, for feeding into
/// `decodeQrCodeImage` in tests without depending on Flutter's rendering
/// pipeline (unlike `QrImageView`, which paints via a `CustomPainter`).
Uint8List renderQrPng(String data, {int moduleSize = 8, int quietZone = 4}) {
  final qrCode = QrCode.fromData(
    data: data,
    errorCorrectLevel: QrErrorCorrectLevel.L,
  );
  final qrImage = QrImage(qrCode);
  final moduleCount = qrImage.moduleCount;
  final size = (moduleCount + quietZone * 2) * moduleSize;

  final image = img.Image(width: size, height: size);
  img.fill(image, color: img.ColorRgb8(255, 255, 255));

  for (var row = 0; row < moduleCount; row++) {
    for (var col = 0; col < moduleCount; col++) {
      if (!qrImage.isDark(row, col)) {
        continue;
      }
      final left = (col + quietZone) * moduleSize;
      final top = (row + quietZone) * moduleSize;
      img.fillRect(
        image,
        x1: left,
        y1: top,
        x2: left + moduleSize - 1,
        y2: top + moduleSize - 1,
        color: img.ColorRgb8(0, 0, 0),
      );
    }
  }

  return Uint8List.fromList(img.encodePng(image));
}
