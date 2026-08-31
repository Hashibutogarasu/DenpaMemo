import 'dart:typed_data';

import 'package:data_pack/data_pack.dart';
import 'package:test/test.dart';
import 'package:image/image.dart' as img;

import '../support/qr_image_test_utils.dart';

void main() {
  test('decodes the raw value encoded in a rendered QR code image', () {
    final bytes = renderQrPng('denpa-memo-test-value');

    expect(decodeQrCodeImage(bytes), 'denpa-memo-test-value');
  });

  test('returns null for a valid image with no QR code in it', () {
    final image = img.Image(width: 32, height: 32);
    img.fill(image, color: img.ColorRgb8(255, 255, 255));
    final bytes = Uint8List.fromList(img.encodePng(image));

    expect(decodeQrCodeImage(bytes), isNull);
  });

  test('returns null for bytes that are not a decodable image', () {
    expect(decodeQrCodeImage(Uint8List.fromList([1, 2, 3])), isNull);
  });
}
