// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:denpa_memo/widgets/container/status.widgetbook.dart'
    as _denpa_memo_widgets_container_status_widgetbook;
import 'package:denpa_memo/widgets/dialog/error_dialog.widgetbook.dart'
    as _denpa_memo_widgets_dialog_error_dialog_widgetbook;
import 'package:denpa_memo/widgets/fab/mini_fab_option.widgetbook.dart'
    as _denpa_memo_widgets_fab_mini_fab_option_widgetbook;
import 'package:denpa_memo/widgets/icon/attribute.widgetbook.dart'
    as _denpa_memo_widgets_icon_attribute_widgetbook;
import 'package:denpa_memo/widgets/icon/denpa_men_icon.widgetbook.dart'
    as _denpa_memo_widgets_icon_denpa_men_icon_widgetbook;
import 'package:denpa_memo/widgets/label/signed_number.widgetbook.dart'
    as _denpa_memo_widgets_label_signed_number_widgetbook;
import 'package:denpa_memo/widgets/lineage/denpa_men_node.widgetbook.dart'
    as _denpa_memo_widgets_lineage_denpa_men_node_widgetbook;
import 'package:widgetbook/widgetbook.dart' as _widgetbook;

final directories = <_widgetbook.WidgetbookNode>[
  _widgetbook.WidgetbookFolder(
    name: 'container',
    children: [
      _widgetbook.WidgetbookComponent(
        name: 'StatusContainer',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Default',
            builder: _denpa_memo_widgets_container_status_widgetbook
                .statusContainerUseCase,
          ),
        ],
      ),
    ],
  ),
  _widgetbook.WidgetbookFolder(
    name: 'dialog',
    children: [
      _widgetbook.WidgetbookComponent(
        name: 'ErrorDialog',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'NonRetriable',
            builder: _denpa_memo_widgets_dialog_error_dialog_widgetbook
                .errorDialogNonRetriableUseCase,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Retriable',
            builder: _denpa_memo_widgets_dialog_error_dialog_widgetbook
                .errorDialogRetriableUseCase,
          ),
        ],
      ),
    ],
  ),
  _widgetbook.WidgetbookFolder(
    name: 'fab',
    children: [
      _widgetbook.WidgetbookComponent(
        name: 'MiniFabOption',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Closed',
            builder: _denpa_memo_widgets_fab_mini_fab_option_widgetbook
                .miniFabOptionClosedUseCase,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Open',
            builder: _denpa_memo_widgets_fab_mini_fab_option_widgetbook
                .miniFabOptionOpenUseCase,
          ),
        ],
      ),
    ],
  ),
  _widgetbook.WidgetbookFolder(
    name: 'icon',
    children: [
      _widgetbook.WidgetbookComponent(
        name: 'AttributeIcon',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Default',
            builder: _denpa_memo_widgets_icon_attribute_widgetbook
                .attributeIconUseCase,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'DenpaMenIcon',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Default',
            builder: _denpa_memo_widgets_icon_denpa_men_icon_widgetbook
                .denpaMenIconUseCase,
          ),
        ],
      ),
    ],
  ),
  _widgetbook.WidgetbookFolder(
    name: 'label',
    children: [
      _widgetbook.WidgetbookComponent(
        name: 'SignedNumberText',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Negative',
            builder: _denpa_memo_widgets_label_signed_number_widgetbook
                .signedNumberTextNegativeUseCase,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Positive',
            builder: _denpa_memo_widgets_label_signed_number_widgetbook
                .signedNumberTextPositiveUseCase,
          ),
        ],
      ),
    ],
  ),
  _widgetbook.WidgetbookFolder(
    name: 'lineage',
    children: [
      _widgetbook.WidgetbookComponent(
        name: 'DenpaMenNode',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Default',
            builder: _denpa_memo_widgets_lineage_denpa_men_node_widgetbook
                .denpaMenNodeUseCase,
          ),
        ],
      ),
    ],
  ),
];
