import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'catch_order_badge.dart';

@widgetbook.UseCase(name: 'Default', type: CatchOrderBadge, path: 'lineage')
Widget catchOrderBadgeUseCase(BuildContext context) {
  final text = context.knobs.string(label: 'バッジ', initialValue: '3');

  return CatchOrderBadge(value: int.tryParse(text) ?? 0);
}
