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
/// With a single item, this renders identically to the pre-multi-page
/// `QrCodeImageDialog` (a bare [Dialog] with 24px padding around the
/// item) so existing single-QR callers see no visual change.
class MediaZoomDialog extends StatefulWidget {
  const MediaZoomDialog({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.initialIndex = 0,
    this.labels,
  }) : assert(itemCount > 0, 'itemCount must be at least 1');

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final int initialIndex;
  final List<String>? labels;

  /// Opens a [MediaZoomDialog] showing [images] (each rendered via
  /// `Image.file`), or does nothing if [images] is empty.
  static Future<void> showImages(
    BuildContext context, {
    required List<File> images,
    int initialIndex = 0,
    List<String>? labels,
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
        labels: labels,
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
  late int _currentIndex = widget.initialIndex;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String? get _currentLabel {
    final labels = widget.labels;
    if (labels == null || labels.length != widget.itemCount) {
      return null;
    }
    return labels[_currentIndex];
  }

  @override
  Widget build(BuildContext context) {
    if (widget.itemCount == 1) {
      return Dialog(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: widget.itemBuilder(context, 0),
        ),
      );
    }

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 280,
              height: 280,
              child: PageView.builder(
                controller: _controller,
                itemCount: widget.itemCount,
                onPageChanged: (index) => setState(() => _currentIndex = index),
                itemBuilder: (context, index) => InteractiveViewer(
                  child: widget.itemBuilder(context, index),
                ),
              ),
            ),
            const SizedBox(height: 12),
            if (_currentLabel case final label?) Text(label),
            const SizedBox(height: 8),
            SmoothPageIndicator(
              controller: _controller,
              count: widget.itemCount,
            ),
          ],
        ),
      ),
    );
  }
}
