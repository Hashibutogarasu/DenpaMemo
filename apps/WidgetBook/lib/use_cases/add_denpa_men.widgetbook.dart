import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:denpamemo_widgets/testing.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart';


@widgetbook.UseCase(name: 'Default', type: AddDenpaMen, path: 'denpa_men')
Widget addDenpaMenUseCase(BuildContext context) {
  return AddDenpaMen(
    denpaMen: DenpaMenData.denpaMen,
    masterData: DenpaMenData.masterData,
    qrCodeCandidates: [QrCodeData.qrCodeRecord],
    onChanged: (_) {},
    icon: const ResolvedEntityIcon(file: null, size: 56),
    parentCandidates: const [],
    onPickParents: (_) async => null,
    onPickMonsterExp: (_) async => null,
  );
}
