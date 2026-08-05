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
          );

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: DenpaMenStatus(
              name: denpaMen.name,
              level: 5,
              happiness: 80,
              expProgress: 0.4,
              expLabel: '120/300',
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
