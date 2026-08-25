import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../domain/master_data/anntena.dart';
import '../../i18n/gen/strings.g.dart';
import 'bottom_slide_dialog.dart';

typedef AntennaSelectionResult = ({Anntena anntena, int level});

Future<AntennaSelectionResult?> showAntennaSelectionDialog(
  BuildContext context, {
  required List<Anntena> anntenas,
  required Anntena selected,
  required int level,
  int maxSelectableLevel = 9,
}) {
  return showBottomSlideDialog<AntennaSelectionResult>(
    context: context,
    builder: (context) => AntennaSelectionDialog(
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

int _targetScopeSortKey(Anntena a) =>
    a.targetsAll ? 1 << 30 : (a.targetCount ?? 0);

List<Anntena> _patternRootsOf(List<Anntena> anntenas, String familyId) {
  final members = anntenas.where((a) => _familyIdOf(a) == familyId).toList();
  final roots = _rootsOf(members)
    ..sort((a, b) => _targetScopeSortKey(a).compareTo(_targetScopeSortKey(b)));
  return roots;
}

class _LevelResolution {
  const _LevelResolution({required this.leaf, required this.inTierLevel});

  final Anntena leaf;
  final int inTierLevel;
}

_LevelResolution _resolveAtLevel(
  Anntena root,
  int level,
  Map<String, Anntena> byId,
) {
  var current = root;
  var previousCap = 0;
  while (current.maxLevel != null &&
      level > current.maxLevel! &&
      current.evolvesToId != null) {
    previousCap = current.maxLevel!;
    current = byId[current.evolvesToId]!;
  }
  final inTierLevel = current.maxLevel == null
      ? math.max(0, level - previousCap)
      : (level - previousCap).clamp(0, current.maxLevel!);
  return _LevelResolution(leaf: current, inTierLevel: inTierLevel);
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

bool _isDurationBased(Anntena root) =>
    root.maxLevel == null && root.evolvesToId != null;

bool _hasNoLevel(Anntena root) => !root.hasLevel;

Anntena _resolveAtDuration(
  Anntena root,
  int durationIndex,
  Map<String, Anntena> byId,
) {
  var current = root;
  for (var i = 0; i < durationIndex; i++) {
    final nextId = current.evolvesToId;
    if (nextId == null) {
      break;
    }
    current = byId[nextId]!;
  }
  return current;
}

int _durationChainLength(Anntena root, Map<String, Anntena> byId) {
  var current = root;
  var length = 1;
  while (current.evolvesToId != null) {
    current = byId[current.evolvesToId]!;
    length++;
  }
  return length;
}

int _durationIndexContaining(
  String leafId,
  Anntena root,
  Map<String, Anntena> byId,
) {
  var current = root;
  var index = 0;
  while (true) {
    if (current.id == leafId) {
      return index;
    }
    final nextId = current.evolvesToId;
    if (nextId == null) {
      return 0;
    }
    current = byId[nextId]!;
    index++;
  }
}

_LevelResolution _resolveTile(
  Anntena root,
  int level,
  int durationIndex,
  Map<String, Anntena> byId,
) {
  if (_isDurationBased(root)) {
    return _LevelResolution(
      leaf: _resolveAtDuration(root, durationIndex, byId),
      inTierLevel: 0,
    );
  }
  if (_hasNoLevel(root)) {
    return _LevelResolution(leaf: root, inTierLevel: 0);
  }
  return _resolveAtLevel(root, level, byId);
}

class AntennaSelectionDialog extends StatefulWidget {
  const AntennaSelectionDialog({
    super.key,
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
  State<AntennaSelectionDialog> createState() =>
      _AntennaSelectionDialogState();
}

class _AntennaSelectionDialogState extends State<AntennaSelectionDialog>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(
    length: AnntenaCategory.values.length,
    vsync: this,
    initialIndex: AnntenaCategory.values.indexOf(widget.initial.category),
  );
  late final Map<String, Anntena> _byId = {
    for (final a in widget.anntenas) a.id: a,
  };
  late final List<String> _familyIds = {
    for (final a in widget.anntenas) _familyIdOf(a),
  }.toList();
  late int _level = widget.level;
  late String _selectedFamilyId = _familyIdOf(widget.initial);
  late int _patternIndex = _patternIndexContaining(
    widget.initial.id,
    _patternRootsOf(widget.anntenas, _selectedFamilyId),
    _byId,
  );
  late int _durationIndex = _initialDurationIndex();

  int _initialDurationIndex() {
    final patternRoots = _patternRootsOf(widget.anntenas, _selectedFamilyId);
    final root = patternRoots[_patternIndex.clamp(0, patternRoots.length - 1)];
    if (!_isDurationBased(root)) {
      return 0;
    }
    return _durationIndexContaining(widget.initial.id, root, _byId);
  }

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

  void _selectFamily(String familyId, int patternIndex) {
    setState(() {
      _selectedFamilyId = familyId;
      _patternIndex = patternIndex;
      _durationIndex = 0;
    });
  }

  int _maxLevelFor(Anntena root) {
    var current = root;
    var total = 0;
    while (current.maxLevel != null && current.evolvesToId != null) {
      total += current.maxLevel!;
      current = _byId[current.evolvesToId]!;
    }
    return total + widget.maxSelectableLevel;
  }

  String _displayName(Translations t, _LevelResolution resolution) {
    final translated = t.antenna[resolution.leaf.id];
    if (translated == null) {
      return resolution.leaf.id;
    }
    if (resolution.inTierLevel > 0) {
      return t.editableStatus.antennaNameWithPlusLevel(
        name: translated,
        plusLevel: resolution.inTierLevel,
      );
    }
    return translated;
  }

  Widget _buildTile(Translations t, String familyId) {
    final patternRoots = _patternRootsOf(widget.anntenas, familyId);
    final isSelected = familyId == _selectedFamilyId;
    final patternIndex = isSelected
        ? _patternIndex.clamp(0, patternRoots.length - 1)
        : 0;
    final patternRoot = patternRoots[patternIndex];
    final resolution = _resolveTile(
      patternRoot,
      _level,
      isSelected ? _durationIndex : 0,
      _byId,
    );

    return Material(
      type: MaterialType.transparency,
      child: ListTile(
        key: ValueKey(familyId),
        title: Text(_displayName(t, resolution)),
        selected: isSelected,
        trailing: isSelected ? const Icon(Icons.check) : null,
        onTap: () => _selectFamily(familyId, patternIndex),
      ),
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
    final isDurationBased = _isDurationBased(selectedPatternRoot);
    final hasNoLevel = _hasNoLevel(selectedPatternRoot);
    final resolvedSelected = _resolveTile(
      selectedPatternRoot,
      _level,
      _durationIndex,
      _byId,
    );
    final maxLevel = math.max(_maxLevelFor(selectedPatternRoot), widget.level);
    final durationChainLength = isDurationBased
        ? _durationChainLength(selectedPatternRoot, _byId)
        : 1;
    final resolvedLevel = (isDurationBased || hasNoLevel) ? 0 : _level;

    return BottomSlideDialog(
      title: t.editableStatus.antenna,
      onConfirm: () => Navigator.of(
        context,
      ).pop((anntena: resolvedSelected.leaf, level: resolvedLevel)),
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
                            _patternRootsOf(
                              widget.anntenas,
                              familyId,
                            ).first.category ==
                            category,
                      ))
                        _buildTile(t, familyId),
                    ],
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          if (isDurationBased)
            if (durationChainLength > 1)
              Row(
                children: [
                  Expanded(child: Text(t.editableStatus.antennaEffectDuration)),
                  Expanded(
                    flex: 3,
                    child: Slider(
                      value: _durationIndex.toDouble(),
                      min: 0,
                      max: (durationChainLength - 1).toDouble(),
                      divisions: durationChainLength - 1,
                      label: _displayName(t, resolvedSelected),
                      onChanged: (value) =>
                          setState(() => _durationIndex = value.round()),
                    ),
                  ),
                ],
              )
            else
              const SizedBox.shrink()
          else if (hasNoLevel)
            const SizedBox.shrink()
          else
            Row(
              children: [
                Expanded(child: Text(t.editableStatus.antennaLevel)),
                Expanded(
                  flex: 3,
                  child: Slider(
                    value: _level.toDouble(),
                    min: 0,
                    max: maxLevel.toDouble(),
                    divisions: maxLevel,
                    label: t.editableStatus.antennaPlusLevelValue(
                      plusLevel: _level,
                    ),
                    onChanged: (value) =>
                        setState(() => _level = value.round()),
                  ),
                ),
              ],
            ),
          if (selectedPatternRoots.length > 1)
            Row(
              children: [
                Expanded(child: Text(t.editableStatus.antennaTargetScope)),
                Expanded(
                  flex: 3,
                  child: Slider(
                    value: _patternIndex.toDouble(),
                    min: 0,
                    max: (selectedPatternRoots.length - 1).toDouble(),
                    divisions: selectedPatternRoots.length - 1,
                    label: _displayName(t, resolvedSelected),
                    onChanged: (value) =>
                        setState(() => _patternIndex = value.round()),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
