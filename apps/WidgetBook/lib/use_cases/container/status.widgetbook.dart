import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:denpamemo_widgets/testing.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: EditableDenpaMenStatus, path: 'container')
Widget statusContainerUseCase(BuildContext context) {
  final denpaMen = context.knobs.object.dropdown<DenpaMen>(
    label: '個体',
    options: RouteDenpaMenData.all,
    labelBuilder: (denpaMen) => denpaMen.name,
  );
  final masterData = RouteDenpaMenData.masterData;

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: EditableDenpaMenStatus(
      denpaMen: denpaMen,
      headShapes: masterData.headShapes,
      anntenas: masterData.anntenas,
      corrections: masterData.corrections,
      qrCodeCandidates: const [],
      onChanged: (_) {},
      considerCorrections: denpaMen.considerCorrections,
      onConsiderCorrectionsChanged: (_) {},
      icon: const ResolvedEntityIcon(file: null, size: 56),
      parentCandidates: const [],
      onPickParents: (_) async => null,
      onPickMonsterExp: (_) async => null,
    ),
  );
}
