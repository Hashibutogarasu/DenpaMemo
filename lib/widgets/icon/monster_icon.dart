import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/monster_providers.dart';
import 'entity_icon.dart';

/// Shows the icon image registered for the `Monster` with [monsterId], or
/// a placeholder box if none exists.
class MonsterIcon extends ConsumerWidget {
  const MonsterIcon({super.key, required this.monsterId, required this.size});

  final String monsterId;
  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final iconAsync = ref.watch(monsterIconProvider(monsterId));
    return ResolvedEntityIcon(file: iconAsync.value, size: size);
  }
}
