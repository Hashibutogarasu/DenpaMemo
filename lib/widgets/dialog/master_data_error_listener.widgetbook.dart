import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook/dialog/master_data_error_listener_demo.dart';

@widgetbook.UseCase(
  name: 'Default',
  type: MasterDataErrorListenerDemo,
  path: 'dialog',
)
Widget masterDataErrorListenerUseCase(BuildContext context) {
  return ProviderScope(
    overrides: [demoMasterDataProviderOverride],
    child: const MasterDataErrorListenerDemo(),
  );
}
