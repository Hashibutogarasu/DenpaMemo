import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/denpa_men/denpa_men_factory.dart';
import '../providers/master_data_providers.dart';
import '../widgets/denpa_men_status.dart';

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
        data: (masterData) {
          final denpaMen = createDenpaMen(
            name: 'サンプル',
            bodyColors: const ['red', 'blue'],
            isSpColor: false,
            headShape: masterData.headShapes.firstWhere(
              (h) => h.id == 'sun',
            ),
            physique: masterData.physiques.first,
            personality: masterData.personalities.first,
            pattern: masterData.patterns.first,
            anntena: masterData.anntenas.first,
            masterData: masterData,
            happiness: 80,
            level: 5,
            currentExp: 120,
            maxExp: 300,
          );

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: DenpaMenStatus(
              name: denpaMen.name,
              level: denpaMen.level,
              happiness: denpaMen.happiness,
              expProgress: denpaMen.currentExp / denpaMen.maxExp,
              expLabel: '${denpaMen.currentExp}/${denpaMen.maxExp}',
              attributeResistances: denpaMen.attributeResistance,
              abnormalityResistances: denpaMen.abnormalityResistances,
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('$error')),
      ),
    );
  }
}
