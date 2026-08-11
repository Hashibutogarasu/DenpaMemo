import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../domain/master_data/anntena.dart';
import '../../i18n/gen/strings.g.dart';
import 'bottom_slide_dialog.dart';

Future<Anntena?> showAntennaSelectionDialog(
  BuildContext context, {
  required List<Anntena> anntenas,
  required Anntena selected,
  required int level,
  int maxSelectableLevel = 9,
}) {
  return showBottomSlideDialog<Anntena>(
    context: context,
    builder: (context) => _AntennaSelectionDialog(
      anntenas: anntenas,
      initial: selected,
      level: level,
      maxSelectableLevel: maxSelectableLevel,
    ),
  );
}

String _familyIdOf(Anntena a) => a.variantGroupId ?? a.id;

List<Anntena> _rootsOf(List<Anntena> anntenas) {
  final evolvedIds = anntenas
      .map((a) => a.evolvesToId)
      .whereType<String>()
      .toSet();
  return anntenas.where((a) => !evolvedIds.contains(a.id)).toList();
}

List<Anntena> _patternRootsOf(List<Anntena> anntenas, String familyId) {
  final members = anntenas
      .where((a) => _familyIdOf(a) == familyId)
      .toList();
  final roots = _rootsOf(members)
    ..sort((a, b) => (a.targetCount ?? 0).compareTo(b.targetCount ?? 0));
  return roots;
}

Anntena _resolveAtLevel(Anntena root, int level, Map<String, Anntena> byId) {
  var current = root;
  while (current.maxLevel != null &&
      level > current.maxLevel! &&
      current.evolvesToId != null) {
    current = byId[current.evolvesToId]!;
  }
  return current;
}

int _patternIndexContaining(
  String leafId,
  List<Anntena> patternRoots,
  Map<String, Anntena> byId,
) {
  for (var i = 0; i < patternRoots.length; i++) {
    var current = patternRoots[i];
    while (true) {
      if (current.id == leafId) {
        return i;
      }
      final nextId = current.evolvesToId;
      if (nextId == null) {
        break;
      }
      current = byId[nextId]!;
    }
  }
  return 0;
}

class _AntennaSelectionDialog extends StatefulWidget {
  const _AntennaSelectionDialog({
    required this.anntenas,
    required this.initial,
    required this.level,
    required this.maxSelectableLevel,
  });

  final List<Anntena> anntenas;
  final Anntena initial;
  final int level;
  final int maxSelectableLevel;

  @override
  State<_AntennaSelectionDialog> createState() =>
      _AntennaSelectionDialogState();
}

class _AntennaSelectionDialogState extends State<_AntennaSelectionDialog>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(
    length: AnntenaCategory.values.length,
    vsync: this,
  );
  late final Map<String, Anntena> _byId = {
    for (final a in widget.anntenas) a.id: a,
  };
  late final List<String> _familyIds = {
    for (final a in widget.anntenas) _familyIdOf(a),
  }.toList();
  late final int _maxLevel = math.max(widget.maxSelectableLevel, widget.level);
  late int _level = widget.level;
  late String _selectedFamilyId = _familyIdOf(widget.initial);
  late int _patternIndex = _patternIndexContaining(
    widget.initial.id,
    _patternRootsOf(widget.anntenas, _selectedFamilyId),
    _byId,
  );
  int _plusLevel = 0;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _categoryLabel(Translations t, AnntenaCategory category) =>
      switch (category) {
        AnntenaCategory.attack => t.editableStatus.antennaCategoryAttack,
        AnntenaCategory.support => t.editableStatus.antennaCategorySupport,
        AnntenaCategory.other => t.editableStatus.antennaCategoryOther,
      };

  void _selectFamily(String familyId) {
    setState(() {
      _selectedFamilyId = familyId;
      _patternIndex = 0;
      _plusLevel = 0;
    });
  }

  String _displayName(Translations t, Anntena leaf) {
    final translated = t.antenna[leaf.id];
    if (translated == null) {
      return leaf.id;
    }
    if (leaf.maxLevel != null && _plusLevel > 0) {
      return t.editableStatus.antennaNameWithPlusLevel(
        name: translated,
        plusLevel: _plusLevel,
      );
    }
    return translated;
  }

  Widget _buildTile(Translations t, String familyId) {
    final patternRoots = _patternRootsOf(widget.anntenas, familyId);
    final patternIndex = _patternIndex.clamp(0, patternRoots.length - 1);
    final patternRoot = patternRoots[patternIndex];
    final resolved = _resolveAtLevel(patternRoot, _level, _byId);
    final isSelected = familyId == _selectedFamilyId;

    return ListTile(
      title: Text(_displayName(t, resolved)),
      selected: isSelected,
      trailing: isSelected ? const Icon(Icons.check) : null,
      onTap: () => _selectFamily(familyId),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final selectedPatternRoots = _patternRootsOf(
      widget.anntenas,
      _selectedFamilyId,
    );
    final selectedPatternRoot = selectedPatternRoots[_patternIndex];
    final resolvedSelected = _resolveAtLevel(
      selectedPatternRoot,
      _level,
      _byId,
    );

    return BottomSlideDialog(
      title: t.editableStatus.antenna,
      onConfirm: () => Navigator.of(context).pop(resolvedSelected),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TabBar(
            controller: _tabController,
            tabs: [
              for (final category in AnntenaCategory.values)
                Tab(text: _categoryLabel(t, category)),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                for (final category in AnntenaCategory.values)
                  ListView(
                    shrinkWrap: true,
                    children: [
                      for (final familyId in _familyIds.where(
                        (familyId) =>
                            _patternRootsOf(widget.anntenas, familyId)
                                .first
                                .category ==
                            category,
                      ))
                        _buildTile(t, familyId),
                    ],
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: Text(t.editableStatus.antennaLevel)),
              Expanded(
                flex: 3,
                child: Slider(
                  value: _level.toDouble().clamp(1, _maxLevel.toDouble()),
                  min: 1,
                  max: _maxLevel.toDouble(),
                  divisions: _maxLevel - 1,
                  label: '$_level',
                  onChanged: (value) =>
                      setState(() => _level = value.round()),
                ),
              ),
            ],
          ),
          if (selectedPatternRoots.length > 1)
            Row(
              children: [
                Expanded(child: Text(t.editableStatus.antennaPattern)),
                Expanded(
                  flex: 3,
                  child: Slider(
                    value: _patternIndex.toDouble(),
                    min: 0,
                    max: (selectedPatternRoots.length - 1).toDouble(),
                    divisions: selectedPatternRoots.length - 1,
                    label: _displayName(
                      t,
                      _resolveAtLevel(
                        selectedPatternRoots[_patternIndex],
                        _level,
                        _byId,
                      ),
                    ),
                    onChanged: (value) =>
                        setState(() => _patternIndex = value.round()),
                  ),
                ),
              ],
            ),
          if (resolvedSelected.maxLevel != null)
            Row(
              children: [
                Expanded(child: Text(t.editableStatus.antennaPlusLevel)),
                Expanded(
                  flex: 3,
                  child: Slider(
                    value: _plusLevel.toDouble(),
                    min: 0,
                    max: resolvedSelected.maxLevel!.toDouble(),
                    divisions: resolvedSelected.maxLevel,
                    label: '+$_plusLevel',
                    onChanged: (value) =>
                        setState(() => _plusLevel = value.round()),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
