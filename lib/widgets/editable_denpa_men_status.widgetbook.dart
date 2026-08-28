import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../domain/denpa_men/denpa_men.dart';
import '../providers/master_data_providers.dart';
import '../widgetbook/denpa_men/route_denpa_men_providers.dart';
import 'editable_denpa_men_status.dart';

@widgetbook.UseCase(
  name: 'Default',
  type: EditableDenpaMenStatus,
  path: 'denpa_men',
)
Widget editableDenpaMenStatusUseCase(BuildContext context) {
  return Consumer(
    builder: (context, ref, child) {
      final routeDenpaMen = ref.watch(routeDenpaMenListProvider);
      final masterData = ref.watch(masterDataProvider).value!;
      final denpaMen = context.knobs.object.dropdown<DenpaMen>(
        label: '個体',
        options: routeDenpaMen,
        labelBuilder: (denpaMen) => denpaMen.name,
      );

      return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: EditableDenpaMenStatus(
          denpaMen: denpaMen,
          headShapes: masterData.headShapes,
          anntenas: masterData.anntenas,
          corrections: masterData.corrections,
          masterData: masterData,
          qrCodeCandidates: const [],
          onChanged: (_) {},
          considerCorrections: denpaMen.considerCorrections,
          onConsiderCorrectionsChanged: (_) {},
        ),
      );
    },
  );
}
