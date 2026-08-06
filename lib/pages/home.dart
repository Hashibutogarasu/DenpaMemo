import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/denpa_men/denpa_men.dart';
import '../domain/denpa_men/denpa_men_factory.dart';
import '../domain/master_data/master_data.dart';
import '../i18n/gen/strings.g.dart';
import '../providers/master_data_providers.dart';
import '../widgets/denpa_men_status.dart';
import '../widgets/editable_denpa_men_status.dart';
import '../widgets/header/slanted_app_bar.dart';
import '../widgets/label/gauge_value.dart';
import '../widgets/label/outlined_title.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final masterDataAsync = ref.watch(masterDataProvider);

    return Scaffold(
      appBar: SlantedAppBar(
        title: OutlinedTitleText(text: context.t.page.home),
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
    name: 'こうた',
    bodyColors: const ['black'],
    isSpColor: true,
    headShape: widget.masterData.headShapes.firstWhere((h) => h.id == 'circle'),
    physique: widget.masterData.physiques.first,
    personality: widget.masterData.personalities.first,
    pattern: widget.masterData.patterns.first,
    anntena: widget.masterData.anntenas.first,
    masterData: widget.masterData,
    happiness: 320,
    maxHappiness: 320,
    level: 180,
    maxLevel: 180,
    hp: 9309,
    ap: 7,
    attack: 5969,
    defense: 5436,
    speed: 5583,
    evasionRate: 7,
    corrections: [
      widget.masterData.corrections.firstWhere((c) => c.id == 'protagonist'),
    ],
    memo: null,
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
        maxHappiness: draft.maxHappiness,
        level: draft.level,
        maxLevel: draft.maxLevel,
        currentExp: draft.currentExp,
        maxExp: draft.maxExp,
        hp: draft.hp,
        ap: draft.ap,
        attack: draft.attack,
        defense: draft.defense,
        speed: draft.speed,
        evasionRate: draft.evasionRate,
        corrections: draft.corrections,
        memo: draft.memo,
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
              level: GaugeValue(
                current: _denpaMen.level,
                max: _denpaMen.maxLevel,
              ),
              happiness: GaugeValue(
                current: _denpaMen.happiness,
                max: _denpaMen.maxHappiness,
              ),
              expProgress:
                  _denpaMen.currentExp != null &&
                      _denpaMen.maxExp != null &&
                      _denpaMen.maxExp! > 0
                  ? _denpaMen.currentExp! / _denpaMen.maxExp!
                  : null,
              attributeResistances: _denpaMen.attributeResistance,
              abnormalityResistances: _denpaMen.abnormalityResistances,
              hp: _denpaMen.hp,
              ap: _denpaMen.ap,
              attack: _denpaMen.attack,
              defense: _denpaMen.defense,
              speed: _denpaMen.speed,
              evasionRate: _denpaMen.evasionRate,
              memo: _denpaMen.memo,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: EditableDenpaMenStatus(
              denpaMen: _denpaMen,
              headShapes: widget.masterData.headShapes,
              corrections: widget.masterData.corrections,
              onChanged: _applyEdit,
            ),
          ),
        ],
      ),
    );
  }
}
