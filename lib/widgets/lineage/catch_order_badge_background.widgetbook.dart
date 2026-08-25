import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'catch_order_badge_background.dart';

@widgetbook.UseCase(
  name: 'Default',
  type: CatchOrderBadgeBackground,
  path: 'lineage',
)
Widget catchOrderBadgeBackgroundUseCase(BuildContext context) {
  return const CatchOrderBadgeBackground(child: Icon(Icons.star, size: 12));
}
