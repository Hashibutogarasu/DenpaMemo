import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'media_zoom_dialog.dart';

/// Shows [rawValue] as a large [QrImageView] in a dialog, used when
/// tapping a QR code node in `DenpaMenLineageGraph`. A thin single-page
/// wrapper around [MediaZoomDialog]. The 280px sizing and 24px padding
/// here are specific to how a QR code should be framed — [MediaZoomDialog]
/// itself imposes no such sizing on other kinds of zoomed content (e.g.
/// a full-resolution photo), which should fill the available space
/// instead.
class QrCodeImageDialog extends StatelessWidget {
  const QrCodeImageDialog({super.key, required this.rawValue});

  final String rawValue;

  @override
  Widget build(BuildContext context) {
    return MediaZoomDialog(
      itemCount: 1,
      itemBuilder: (context, _) => Padding(
        padding: const EdgeInsets.all(24),
        child: QrImageView(data: rawValue, size: 280),
      ),
    );
  }
}
