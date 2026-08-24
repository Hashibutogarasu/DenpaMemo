import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../domain/denpa_men/denpa_men.dart';
import 'lineage_graph_highlight.dart';

/// Paints the hover-highlight border and catch-order badge directly onto
/// a lineage tree node, driven by [hoveredBredId] via [Listenable.repaint]
/// — never through a widget rebuild. GraphView only ever calls its node
/// builder once per node (see `buildLineageGraphData` and
/// `LineageGraph._buildGraphView`), so any hover-driven widget rebuild
/// forces the graphview package to force-rebuild the whole tree instead;
/// painting is the only update path that doesn't.
class LineageNodeHighlightPainter extends CustomPainter {
  LineageNodeHighlightPainter({
    required this.denpaMenId,
    required this.denpaMenById,
    required this.hoveredBredId,
    this.showBadge = true,
  }) : super(repaint: hoveredBredId);

  final String denpaMenId;
  final Map<String, DenpaMen> denpaMenById;
  final ValueListenable<String?> hoveredBredId;
  final bool showBadge;

  @override
  void paint(Canvas canvas, Size size) {
    if (!isLineageNodeHighlighted(
      denpaMenId,
      hoveredBredId.value,
      denpaMenById,
    )) {
      return;
    }
    final denpaMen = denpaMenById[denpaMenId];
    if (denpaMen == null) {
      return;
    }

    final highlightColor = lineageNodeHighlightColor(denpaMen);
    if (highlightColor != null) {
      final borderPaint = Paint()
        ..color = highlightColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3;
      final rrect = RRect.fromRectAndRadius(
        Offset.zero & size,
        const Radius.circular(8),
      );
      canvas.drawRRect(rrect, borderPaint);
    }

    if (!showBadge) {
      return;
    }
    final badgeValue = lineageNodeBadgeValue(denpaMen, denpaMenById);
    if (badgeValue != null) {
      _paintBadge(canvas, size, badgeValue);
    }
  }

  void _paintBadge(Canvas canvas, Size size, int value) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: '$value',
        style: const TextStyle(fontSize: 11, color: Colors.black87),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    const horizontalPadding = 3.0;
    const verticalPadding = 1.0;
    final badgeSize = Size(
      textPainter.width + horizontalPadding * 2,
      textPainter.height + verticalPadding * 2,
    );
    final badgeCenter = Offset(
      size.width - 4 - badgeSize.width / 2,
      size.height - 4 - badgeSize.height / 2,
    );

    canvas.drawOval(
      Rect.fromCenter(
        center: badgeCenter,
        width: badgeSize.width,
        height: badgeSize.height,
      ),
      Paint()..color = Colors.white,
    );
    textPainter.paint(
      canvas,
      badgeCenter - Offset(textPainter.width / 2, textPainter.height / 2),
    );
  }

  @override
  bool shouldRepaint(covariant LineageNodeHighlightPainter oldDelegate) {
    return denpaMenId != oldDelegate.denpaMenId ||
        showBadge != oldDelegate.showBadge ||
        !identical(denpaMenById, oldDelegate.denpaMenById);
  }
}
