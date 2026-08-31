import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;


const _headShapeId = 'circle';

@widgetbook.UseCase(name: 'Default', type: SelectionTile, path: 'container')
Widget selectionTileUseCase(BuildContext context) {
  return SelectionTile(
    label: context.t.editableStatus.headShape,
    onTap: () {},
    child: Text(context.t.headShape[_headShapeId] ?? _headShapeId),
  );
}

@widgetbook.UseCase(name: 'Disabled', type: SelectionTile, path: 'container')
Widget selectionTileDisabledUseCase(BuildContext context) {
  return SelectionTile(
    label: context.t.editableStatus.headShape,
    enabled: false,
    onTap: () {},
    child: Text(context.t.headShape[_headShapeId] ?? _headShapeId),
  );
}
