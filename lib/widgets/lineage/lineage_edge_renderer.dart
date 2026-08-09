import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

/// Fixes a bug in `graphview`'s [TreeEdgeRenderer] where, for
/// [BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM], the parent/child
/// anchor points are computed as `position + size * 0.5` (i.e. each node's
/// center) instead of its bottom/top edge, making every edge line run
/// straight through both connected nodes instead of stopping at their
/// borders.
class LineageEdgeRenderer extends TreeEdgeRenderer {
  LineageEdgeRenderer(super.configuration);

  @override
  void buildTopBottomPath(
    Node node,
    Node child,
    Offset parentPos,
    Offset childPos,
    double parentCenterX,
    double parentCenterY,
    double childCenterX,
    double childCenterY,
  ) {
    final parentBottomY = parentPos.dy + node.height;
    final childTopY = childPos.dy;
    final midY = (parentBottomY + childTopY) * 0.5;

    if (configuration.useCurvedConnections) {
      linePath
        ..moveTo(childCenterX, childTopY)
        ..cubicTo(
          childCenterX,
          midY,
          parentCenterX,
          midY,
          parentCenterX,
          parentBottomY,
        );
    } else {
      linePath
        ..moveTo(parentCenterX, parentBottomY)
        ..lineTo(parentCenterX, midY)
        ..lineTo(childCenterX, midY)
        ..lineTo(childCenterX, childTopY);
    }
  }
}
