import 'package:flutter/material.dart';

import 'package:denpa_memo/widgets.dart';
import '../i18n/gen/strings.g.dart';

class Analysis extends StatelessWidget {
  const Analysis({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: OutlinedTitleText(text: context.t.page.analysis),
      body: SmoothScrollContainer(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: AnalysisMenu(
            items: [
              AnalysisMenuItem(
                id: 'aiAnalysis',
                label: context.t.analysis.aiAnalysis,
              ),
              AnalysisMenuItem(
                id: 'communityAnalysis',
                label: context.t.analysis.communityAnalysis,
              ),
              AnalysisMenuItem(
                id: 'physiqueTableAutoFill',
                label: context.t.analysis.physiqueTableAutoFill,
              ),
              AnalysisMenuItem(
                id: 'growthCurveIdentification',
                label: context.t.analysis.growthCurveIdentification,
              ),
              AnalysisMenuItem(
                id: 'unknownCorrectionAnalysis',
                label: context.t.analysis.unknownCorrectionAnalysis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
