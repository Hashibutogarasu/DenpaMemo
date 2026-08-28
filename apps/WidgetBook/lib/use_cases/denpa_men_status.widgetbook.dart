import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:denpamemo_widgets/testing.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: DenpaMenStatus, path: 'denpa_men')
Widget denpaMenStatusUseCase(BuildContext context) {
  final denpaMen = context.knobs.object.dropdown<DenpaMen>(
    label: '個体',
    options: RouteDenpaMenData.all,
    labelBuilder: (denpaMen) => denpaMen.name,
  );
  final showIcon = context.knobs.boolean(label: 'アイコンを表示', initialValue: true);
  final showContainer = context.knobs.boolean(
    label: 'コンテナで囲む',
    initialValue: true,
  );

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: DenpaMenStatus.fromDenpaMen(
      denpaMen,
      totalAttributeCount: RouteDenpaMenData.masterData.attributes.length,
      showIcon: showIcon,
      showContainer: showContainer,
    ),
  );
}
