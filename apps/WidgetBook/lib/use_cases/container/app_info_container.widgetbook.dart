import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../app_metadata.dart';

@widgetbook.UseCase(name: 'Default', type: AppInfoContainer, path: 'container')
Widget appInfoContainerUseCase(BuildContext context) {
  return AppInfoContainer(
    icon: const Icon(Icons.apps, size: 64),
    appName: 'App Name',
    license: appMetadataConfig.license,
    packageId: 'com.example.app',
    author: appMetadataConfig.author,
  );
}
