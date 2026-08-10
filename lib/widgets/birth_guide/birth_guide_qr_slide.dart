import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class BirthGuideQrSlide extends StatelessWidget {
  const BirthGuideQrSlide({
    super.key,
    required this.rawValue,
    required this.instruction,
    this.qrSize = 240,
  });

  final String rawValue;
  final String instruction;
  final double qrSize;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(instruction, textAlign: TextAlign.center),
          const SizedBox(height: 16),
          QrImageView(data: rawValue, size: qrSize),
        ],
      ),
    );
  }
}
