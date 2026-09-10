import 'package:flutter/material.dart';

import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: AnalysisMenu, path: 'menu')
Widget analysisMenuUseCase(BuildContext context) {
  return const AnalysisMenu(
    items: [
      AnalysisMenuItem(id: 'aiAnalysis', label: 'AI分析'),
      AnalysisMenuItem(id: 'communityAnalysis', label: 'コミュニティ分析'),
      AnalysisMenuItem(id: 'physiqueTableAutoFill', label: '体格表自動埋め'),
      AnalysisMenuItem(id: 'growthCurveIdentification', label: '成長曲線特定'),
      AnalysisMenuItem(id: 'unknownCorrectionAnalysis', label: '未知の補正データ分析'),
    ],
  );
}
