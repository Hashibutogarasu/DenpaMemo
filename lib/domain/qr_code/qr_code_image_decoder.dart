import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:zxing2/qrcode.dart';

/// Decodes the QR code payload embedded in an encoded image file (e.g.
/// PNG/JPEG) given as [bytes], returning its raw text or null if [bytes]
/// isn't a decodable image or contains no valid QR code.
String? decodeQrCodeImage(Uint8List bytes) {
  img.Image? image;
  try {
    image = img.decodeImage(bytes);
  } on Object {
    return null;
  }
  if (image == null) {
    return null;
  }

  final pixels = Int32List(image.width * image.height);
  var index = 0;
  for (final pixel in image) {
    pixels[index++] =
        0xFF000000 |
        (pixel.r.toInt() << 16) |
        (pixel.g.toInt() << 8) |
        pixel.b.toInt();
  }

  final bitmap = BinaryBitmap(
    HybridBinarizer(RGBLuminanceSource(image.width, image.height, pixels)),
  );
  try {
    return QRCodeReader().decode(bitmap).text;
  } on ReaderException {
    return null;
  }
}
