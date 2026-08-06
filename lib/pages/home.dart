import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/denpa_men/denpa_men.dart';
import '../domain/denpa_men/denpa_men_factory.dart';
import '../domain/master_data/master_data.dart';
import '../providers/master_data_providers.dart';
import '../widgets/denpa_men_status.dart';
import '../widgets/editable_denpa_men_status.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final masterDataAsync = ref.watch(masterDataProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: masterDataAsync.when(
        data: (masterData) => _HomeBody(masterData: masterData),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('$error')),
      ),
    );
  }
}

class _HomeBody extends StatefulWidget {
  const _HomeBody({required this.masterData});

  final MasterData masterData;

  @override
  State<_HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<_HomeBody> {
  late DenpaMen _denpaMen = createDenpaMen(
    name: 'サンプル',
    bodyColors: const ['red', 'blue'],
    isSpColor: false,
    headShape: widget.masterData.headShapes.firstWhere((h) => h.id == 'sun'),
    physique: widget.masterData.physiques.first,
    personality: widget.masterData.personalities.first,
    pattern: widget.masterData.patterns.first,
    anntena: widget.masterData.anntenas.first,
    masterData: widget.masterData,
    happiness: 80,
    level: 5,
    currentExp: 120,
    maxExp: 300,
    hp: 100,
    ap: 50,
    attack: 30,
    defense: 20,
    speed: 15,
    evasionRate: 5,
  );

  void _applyEdit(DenpaMen draft) {
    setState(() {
      _denpaMen = createDenpaMen(
        name: draft.name,
        bodyColors: draft.bodyColors,
        isSpColor: draft.isSpColor,
        headShape: draft.headShape,
        physique: draft.physique,
        personality: draft.personality,
        pattern: draft.pattern,
        anntena: draft.anntena,
        masterData: widget.masterData,
        happiness: draft.happiness,
        level: draft.level,
        currentExp: draft.currentExp,
        maxExp: draft.maxExp,
        hp: draft.hp,
        ap: draft.ap,
        attack: draft.attack,
        defense: draft.defense,
        speed: draft.speed,
        evasionRate: draft.evasionRate,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: DenpaMenStatus(
              name: _denpaMen.name,
              level: _denpaMen.level,
              happiness: _denpaMen.happiness,
              expProgress: _denpaMen.maxExp > 0
                  ? _denpaMen.currentExp / _denpaMen.maxExp
                  : 0,
              expLabel: '${_denpaMen.currentExp}/${_denpaMen.maxExp}',
              attributeResistances: _denpaMen.attributeResistance,
              abnormalityResistances: _denpaMen.abnormalityResistances,
              hp: _denpaMen.hp,
              ap: _denpaMen.ap,
              attack: _denpaMen.attack,
              defense: _denpaMen.defense,
              speed: _denpaMen.speed,
              evasionRate: _denpaMen.evasionRate,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: EditableDenpaMenStatus(
              denpaMen: _denpaMen,
              headShapes: widget.masterData.headShapes,
              onChanged: _applyEdit,
            ),
          ),
        ],
      ),
    );
  }
}
