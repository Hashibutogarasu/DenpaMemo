import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_client/graphql_client.dart';

import '../i18n/gen/strings.g.dart';
import '../widgets/dialog/master_data_error_listener.dart';
import '../widgets/icon/monster_icon.dart';

/// Single-select list of every [Monster], reached from
/// [MonsterExpPage](monster_exp.dart)'s "defeated monster" field. Tapping
/// an entry immediately pops this page with that [Monster]; there is no
/// separate confirm step since only one can be chosen.
class MonsterSelectionPage extends ConsumerWidget {
  const MonsterSelectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final monstersAsync = ref.watch(monsterListProvider);

    listenForMonsterListErrors(ref, context);

    return AppScaffold(
      title: OutlinedTitleText(text: t.editableStatus.monsterExpSelectMonster),
      body: monstersAsync.when(
        data: (monsters) => ListView.builder(
          itemCount: monsters.length,
          itemBuilder: (context, index) {
            final monster = monsters[index];
            return ListTile(
              leading: MonsterIcon(monsterId: monster.id, size: 40),
              title: Text(t.monster[monster.id] ?? monster.id),
              onTap: () => Navigator.of(context).pop(monster),
            );
          },
        ),
        loading: () => const ProgressBar(),
        error: (error, stackTrace) => const SizedBox.shrink(),
      ),
    );
  }
}
