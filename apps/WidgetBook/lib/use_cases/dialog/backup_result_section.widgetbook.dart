import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:denpamemo_widgets/testing.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart';


@widgetbook.UseCase(name: 'WithEntries', type: BackupResultSection, path: 'dialog')
Widget backupResultSectionWithEntriesUseCase(BuildContext context) {
  return BackupResultSection(
    title: '取り込み済み',
    denpaMens: [DenpaMenData.denpaMen, DenpaMenData.build('みらい')],
  );
}

@widgetbook.UseCase(name: 'Empty', type: BackupResultSection, path: 'dialog')
Widget backupResultSectionEmptyUseCase(BuildContext context) {
  return const BackupResultSection(title: '取り込み済み', denpaMens: []);
}
