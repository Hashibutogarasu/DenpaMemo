import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'media_zoom_dialog.dart';

/// Shows [rawValue] as a large [QrImageView] in a dialog, used when
/// tapping a QR code node in `DenpaMenLineageGraph`. A thin single-page
/// wrapper around [MediaZoomDialog], which renders identically to this
/// widget's pre-multi-page layout when given a single item.
class QrCodeImageDialog extends StatelessWidget {
  const QrCodeImageDialog({super.key, required this.rawValue});

  final String rawValue;

  @override
  Widget build(BuildContext context) {
    return MediaZoomDialog(
      itemCount: 1,
      itemBuilder: (context, _) => QrImageView(data: rawValue, size: 280),
    );
  }
}
