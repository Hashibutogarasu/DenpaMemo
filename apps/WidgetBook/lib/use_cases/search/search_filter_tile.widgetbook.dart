import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:denpamemo_widgets/denpamemo_widgets.dart';

const _headShapeId = 'circle';

@widgetbook.UseCase(name: 'Unset', type: SearchFilterTile, path: 'search')
Widget searchFilterTileUnsetUseCase(BuildContext context) {
  return SearchFilterTile<String>(
    label: context.t.editableStatus.headShape,
    isSet: false,
    subtitle: Text(context.t.common.unset),
    openDialog: (context) async => null,
    onApply: (result) {},
    onClear: () {},
  );
}

@widgetbook.UseCase(name: 'Set', type: SearchFilterTile, path: 'search')
Widget searchFilterTileSetUseCase(BuildContext context) {
  return SearchFilterTile<String>(
    label: context.t.editableStatus.headShape,
    isSet: true,
    subtitle: Text(context.t.headShape[_headShapeId] ?? _headShapeId),
    openDialog: (context) async => null,
    onApply: (result) {},
    onClear: () {},
  );
}
