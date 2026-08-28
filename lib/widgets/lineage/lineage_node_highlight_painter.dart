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
    required this.nodeKey,
    required this.denpaMenId,
    required this.denpaMenById,
    required this.incomingSourceKeysById,
    required this.hoveredBredId,
    this.highlightColorOverride,
    this.badgeTextOverride,
  }) : super(repaint: hoveredBredId);

  final Object nodeKey;
  final String denpaMenId;
  final Map<String, DenpaMen> denpaMenById;
  final Map<String, List<Object>> incomingSourceKeysById;
  final ValueListenable<String?> hoveredBredId;

  final Color? highlightColorOverride;
  final String? badgeTextOverride;

  @override
  void paint(Canvas canvas, Size size) {
    final denpaMen = denpaMenById[denpaMenId];
    if (denpaMen == null) {
      return;
    }

    final highlighted = isLineageNodeHighlighted(
      nodeKey,
      hoveredBredId.value,
      incomingSourceKeysById,
    );
    if (!highlighted) {
      return;
    }

    final highlightColor = highlightColorOverride ?? lineageNodeHighlightColor(denpaMen);
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

    final badgeText =
        badgeTextOverride ??
        lineageNodeParentBadgeValue(
          denpaMenId,
          hoveredBredId.value!,
          denpaMenById,
        )?.toString();
    if (badgeText != null) {
      _paintBadge(canvas, size, badgeText);
    }
  }

  void _paintBadge(Canvas canvas, Size size, String text) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(fontSize: 11, color: Colors.black87),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    const padding = 3.0;
    final longestSide = textPainter.width > textPainter.height
        ? textPainter.width
        : textPainter.height;
    final diameter = longestSide + padding * 2;
    final badgeCenter = Offset(
      size.width - 4 - diameter / 2,
      size.height - 4 - diameter / 2,
    );

    canvas.drawCircle(badgeCenter, diameter / 2, Paint()..color = Colors.white);
    textPainter.paint(
      canvas,
      badgeCenter - Offset(textPainter.width / 2, textPainter.height / 2),
    );
  }

  @override
  bool shouldRepaint(covariant LineageNodeHighlightPainter oldDelegate) {
    return nodeKey != oldDelegate.nodeKey ||
        denpaMenId != oldDelegate.denpaMenId ||
        !identical(denpaMenById, oldDelegate.denpaMenById) ||
        !identical(incomingSourceKeysById, oldDelegate.incomingSourceKeysById);
  }
}
