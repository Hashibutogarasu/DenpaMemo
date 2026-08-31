import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Whether [nodeKey] feeds into whichever entity [hoveredKey] names, per
/// [incomingSourceKeysByKey]. Matching by graph node key (not spec key)
/// means a parent duplicated across children (`duplicateKeyFor`) only
/// highlights the hovered child's own copy.
bool isTreeNodeHighlighted(
  Object nodeKey,
  Object? hoveredKey,
  Map<Object, List<Object>> incomingSourceKeysByKey,
) {
  if (hoveredKey == null) {
    return false;
  }
  return incomingSourceKeysByKey[hoveredKey]?.contains(nodeKey) ?? false;
}

/// Highlight color and badge text for [T], supplied by the caller since
/// [TreeNodeHighlightPainter] doesn't know [T]'s shape.
abstract class TreeNodeHighlightStrategy<T> {
  const TreeNodeHighlightStrategy();

  Color? highlightColor(T data);

  String? badgeText(T data, T hoveredData);
}

/// Paints the hover-highlight border and badge onto a tree node, driven
/// by [hoveredKey] via [Listenable.repaint] rather than a widget rebuild
/// — GraphView calls its node builder once per node, so a rebuild here
/// would force-rebuild the whole tree instead.
class TreeNodeHighlightPainter<T> extends CustomPainter {
  TreeNodeHighlightPainter({
    required this.nodeKey,
    required this.specKey,
    required this.dataByKey,
    required this.incomingSourceKeysByKey,
    required this.hoveredKey,
    required this.strategy,
  }) : super(repaint: hoveredKey);

  final Object nodeKey;
  final Object specKey;
  final Map<Object, T> dataByKey;
  final Map<Object, List<Object>> incomingSourceKeysByKey;
  final ValueListenable<Object?> hoveredKey;
  final TreeNodeHighlightStrategy<T> strategy;

  @override
  void paint(Canvas canvas, Size size) {
    final data = dataByKey[specKey];
    if (data == null) {
      return;
    }

    final highlighted = isTreeNodeHighlighted(
      nodeKey,
      hoveredKey.value,
      incomingSourceKeysByKey,
    );
    if (!highlighted) {
      return;
    }

    final highlightColor = strategy.highlightColor(data);
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

    final hoveredData = dataByKey[hoveredKey.value];
    final badgeText = hoveredData != null
        ? strategy.badgeText(data, hoveredData)
        : null;
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
  bool shouldRepaint(covariant TreeNodeHighlightPainter<T> oldDelegate) {
    return nodeKey != oldDelegate.nodeKey ||
        specKey != oldDelegate.specKey ||
        !identical(dataByKey, oldDelegate.dataByKey) ||
        !identical(incomingSourceKeysByKey, oldDelegate.incomingSourceKeysByKey);
  }
}
