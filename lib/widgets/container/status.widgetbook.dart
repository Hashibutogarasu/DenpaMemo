import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_client/graphql_client.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook/denpa_men/route_denpa_men_providers.dart';
import '../editable_denpa_men_status.dart';

@widgetbook.UseCase(name: 'Default', type: StatusContainer, path: 'container')
Widget statusContainerUseCase(BuildContext context) {
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
