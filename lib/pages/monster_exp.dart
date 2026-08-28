import 'package:data_pack/data_pack.dart';
import 'package:flutter/material.dart';

import '../i18n/gen/strings.g.dart';
import '../routing/app_router.dart';
import '../widgets/field/inline_number_field.dart';
import '../widgets/icon/monster_icon.dart';
import '../widgets/label/outlined_title.dart';
import '../widgets/scaffold/app_scaffold.dart';

/// Records the outcome of defeating a monster: which one, how many, and
/// the individual's resulting exp/level plus how many teammates were
/// involved. Pushed from the edit panel's "record monster exp" tile,
/// reached via [MonsterExpRoute]; pops with the finished [MonsterExp] once
/// saved, or nothing if the user backs out.
class MonsterExpPage extends StatefulWidget {
  const MonsterExpPage({super.key, this.initial});

  final MonsterExp? initial;

  @override
  State<MonsterExpPage> createState() => _MonsterExpPageState();
}

class _MonsterExpPageState extends State<MonsterExpPage> {
  Monster? _monster;
  int _count = 0;
  int _exp = 0;
  int _level = 0;
  int _maxLevelTeammateCount = 0;
  int _expRecipientCount = 0;

  @override
  void initState() {
    super.initState();
    final initial = widget.initial;
    if (initial != null) {
      _monster = Monster(id: initial.monsterId);
      _count = initial.count;
      _exp = initial.exp;
      _level = initial.level;
      _maxLevelTeammateCount = initial.maxLevelTeammateCount;
      _expRecipientCount = initial.expRecipientCount;
    }
  }

  Future<void> _pickMonster() async {
    final result = await MonsterSelectionRoute().push<Monster>(context);
    if (result != null) {
      setState(() => _monster = result);
    }
  }

  void _save() {
    final monster = _monster;
    if (monster == null) {
      return;
    }
    Navigator.of(context).pop(
      MonsterExp(
        monsterId: monster.id,
        count: _count,
        exp: _exp,
        level: _level,
        maxLevelTeammateCount: _maxLevelTeammateCount,
        expRecipientCount: _expRecipientCount,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final monster = _monster;

    return AppScaffold(
      title: OutlinedTitleText(text: t.editableStatus.monsterExp),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: monster == null ? null : _save,
        label: Text(t.common.save),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 16,
          children: [
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    leading: monster == null
                        ? const Icon(Icons.image_outlined)
                        : MonsterIcon(monsterId: monster.id, size: 40),
                    title: Text(
                      monster == null
                          ? t.common.unset
                          : t.monster[monster.id] ?? monster.id,
                    ),
                    onTap: _pickMonster,
                  ),
                ),
                const Icon(Icons.close),
                SizedBox(
                  width: 60,
                  child: InlineNumberField(
                    value: _count,
                    textAlign: TextAlign.end,
                    onChanged: (value) => setState(() => _count = value),
                  ),
                ),
              ],
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.all(8),
                child: const Icon(Icons.arrow_downward),
              ),
            ),
            Row(
              children: [
                Text(t.editableStatus.monsterExpExp),
                const Spacer(),
                SizedBox(
                  width: 60,
                  child: InlineNumberField(
                    value: _exp,
                    textAlign: TextAlign.end,
                    onChanged: (value) => setState(() => _exp = value),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(t.editableStatus.monsterExpLevel),
                const Spacer(),
                SizedBox(
                  width: 60,
                  child: InlineNumberField(
                    value: _level,
                    textAlign: TextAlign.end,
                    onChanged: (value) => setState(() => _level = value),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(t.editableStatus.monsterExpMaxLevelTeammateCount),
                const Spacer(),
                SizedBox(
                  width: 60,
                  child: InlineNumberField(
                    value: _maxLevelTeammateCount,
                    textAlign: TextAlign.end,
                    onChanged: (value) =>
                        setState(() => _maxLevelTeammateCount = value),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(t.editableStatus.monsterExpRecipientCount),
                const Spacer(),
                SizedBox(
                  width: 60,
                  child: InlineNumberField(
                    value: _expRecipientCount,
                    textAlign: TextAlign.end,
                    onChanged: (value) =>
                        setState(() => _expRecipientCount = value),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
