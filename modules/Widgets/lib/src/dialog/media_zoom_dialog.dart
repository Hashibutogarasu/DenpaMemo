import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/// Generic multi-page zoomable dialog: doesn't know or care whether its
/// pages are `File` images, QR codes, or anything else — [itemBuilder]
/// returns whatever widget each page shows. This lets the same widget
/// back both [QrCodeImageDialog](qr_code_image_dialog.dart)'s single QR
/// code display and callers that need to swipe between several images
/// (e.g. `DenpaMenContainer`'s face/whole-body/icon zoom), and lets
/// widget tests exercise multi-page swiping with plain placeholder
/// widgets instead of real image bytes.
///
/// This imposes no padding or fixed sizing of its own — those are QR's
/// own concern (see [QrCodeImageDialog]'s `itemBuilder`), not something
/// every kind of zoomed content (e.g. a full-resolution photo) should be
/// squeezed into. Each page is left to size itself within the [Dialog]'s
/// own constraints.
class MediaZoomDialog extends StatefulWidget {
  const MediaZoomDialog({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.initialIndex = 0,
  }) : assert(itemCount > 0, 'itemCount must be at least 1');

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final int initialIndex;

  /// Opens a [MediaZoomDialog] showing [images] (each rendered via
  /// `Image.file`), or does nothing if [images] is empty.
  static Future<void> show(
    BuildContext context, {
    required List<File> images,
    int initialIndex = 0,
  }) {
    if (images.isEmpty) {
      return Future<void>.value();
    }
    return showDialog<void>(
      context: context,
      builder: (context) => MediaZoomDialog(
        itemCount: images.length,
        itemBuilder: (context, index) =>
            Image.file(images[index], fit: BoxFit.contain),
        initialIndex: initialIndex,
      ),
    );
  }

  @override
  State<MediaZoomDialog> createState() => _MediaZoomDialogState();
}

class _MediaZoomDialogState extends State<MediaZoomDialog> {
  late final PageController _controller = PageController(
    initialPage: widget.initialIndex,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.itemCount == 1) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: widget.itemBuilder(context, 0),
      );
    }

    final screenSize = MediaQuery.sizeOf(context);
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: screenSize.width * 0.8,
            height: screenSize.height * 0.6,
            child: PageView.builder(
              controller: _controller,
              itemCount: widget.itemCount,
              itemBuilder: (context, index) => InteractiveViewer(
                child: widget.itemBuilder(context, index),
              ),
            ),
          ),
          const SizedBox(height: 8),
          SmoothPageIndicator(controller: _controller, count: widget.itemCount),
        ],
      ),
    );
  }
}
