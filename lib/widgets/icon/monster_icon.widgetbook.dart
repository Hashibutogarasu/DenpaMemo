import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'monster_icon.dart';

@widgetbook.UseCase(name: 'Default', type: MonsterIcon, path: 'icon')
Widget monsterIconUseCase(BuildContext context) {
  return const MonsterIcon(monsterId: 'sample-monster-id', size: 80);
}
