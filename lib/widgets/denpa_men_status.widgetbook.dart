import 'package:data_pack/data_pack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../providers/master_data_providers.dart';
import '../widgetbook/denpa_men/route_denpa_men_providers.dart';
import 'denpa_men_status.dart';

@widgetbook.UseCase(name: 'Default', type: DenpaMenStatus, path: 'denpa_men')
Widget denpaMenStatusUseCase(BuildContext context) {
  return Consumer(
    builder: (context, ref, child) {
      final routeDenpaMen = ref.watch(routeDenpaMenListProvider);
      final masterData = ref.watch(masterDataProvider).value!;
      final denpaMen = context.knobs.object.dropdown<DenpaMen>(
        label: '個体',
        options: routeDenpaMen,
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
          totalAttributeCount: masterData.attributes.length,
          showIcon: showIcon,
          showContainer: showContainer,
        ),
      );
    },
  );
}
