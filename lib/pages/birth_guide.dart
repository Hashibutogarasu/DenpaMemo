import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/denpa_men/birth_guide.dart';
import '../domain/denpa_men/denpa_men_record.dart';
import '../domain/master_data/master_data.dart';
import '../i18n/gen/strings.g.dart';
import '../providers/denpa_men_providers.dart';
import '../providers/qr_code_providers.dart';
import '../routing/app_router.dart';
import '../widgets/birth_guide/birth_guide_confirm_slide.dart';
import '../widgets/birth_guide/birth_guide_individual_slide.dart';
import '../widgets/birth_guide/birth_guide_progress_bar.dart';
import '../widgets/birth_guide/birth_guide_qr_slide.dart';
import '../widgets/dialog/birth_guide_error_dialog.dart';
import '../widgets/label/outlined_title.dart';
import '../widgets/scaffold/app_scaffold.dart';

class BirthGuideArgs {
  const BirthGuideArgs({required this.masterData, required this.target});

  final MasterData masterData;
  final DenpaMenRecord target;
}

class BirthGuidePage extends ConsumerStatefulWidget {
  const BirthGuidePage({
    super.key,
    required this.masterData,
    required this.target,
  });

  final MasterData masterData;
  final DenpaMenRecord target;

  @override
  ConsumerState<BirthGuidePage> createState() => _BirthGuidePageState();
}

class _BirthGuidePageState extends ConsumerState<BirthGuidePage> {
  final _pageController = PageController();
  int _currentIndex = 0;
  bool _errorShown = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _showError() {
    if (_errorShown) {
      return;
    }
    _errorShown = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      showBirthGuideErrorDialog(
        context,
        onDismissed: () => const HomeRoute().go(context),
      );
    });
  }

  void _finish() {
    const HomeRoute().go(context);
  }

  void _advance(int slideCount) {
    if (_currentIndex >= slideCount - 1) {
      _finish();
      return;
    }
    _pageController.nextPage(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  (List<Widget>, List<bool>) _buildSlides(
    List<BirthGuideStep> steps,
    Translations t,
  ) {
    final slides = <Widget>[];
    final isConfirmSlide = <bool>[];
    final totalAttributeCount = widget.masterData.attributes.length;

    for (final step in steps) {
      switch (step) {
        case BirthGuideCatchStep():
          slides.add(
            BirthGuideQrSlide(
              rawValue: step.qrCode.qrCode.rawValue,
              instruction: t.birthGuide.catchQrInstruction,
            ),
          );
          isConfirmSlide.add(false);
          for (final individual in step.individuals) {
            slides.add(
              BirthGuideIndividualSlide(
                denpaMen: individual.denpaMen,
                totalAttributeCount: totalAttributeCount,
                instruction: t.birthGuide.catchIndividualInstruction,
              ),
            );
            isConfirmSlide.add(false);
          }
        case BirthGuideBreedStep():
          slides.add(
            BirthGuideIndividualSlide(
              denpaMen: step.parentA.denpaMen,
              totalAttributeCount: totalAttributeCount,
              instruction: t.birthGuide.breedParentInstruction,
            ),
          );
          isConfirmSlide.add(false);
          slides.add(
            BirthGuideIndividualSlide(
              denpaMen: step.parentB.denpaMen,
              totalAttributeCount: totalAttributeCount,
              instruction: t.birthGuide.breedParentInstruction,
            ),
          );
          isConfirmSlide.add(false);
          slides.add(
            BirthGuideConfirmSlide(
              denpaMen: step.individual.denpaMen,
              totalAttributeCount: totalAttributeCount,
              instruction: t.birthGuide.confirmInstruction,
            ),
          );
          isConfirmSlide.add(true);
      }
    }

    return (slides, isConfirmSlide);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final denpaMenAsync = ref.watch(denpaMenListProvider(widget.masterData));
    final qrCodesAsync = ref.watch(qrCodeListProvider);

    if (denpaMenAsync.hasError || qrCodesAsync.hasError) {
      _showError();
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final denpaMenRecords = denpaMenAsync.value;
    final qrCodes = qrCodesAsync.value;
    if (denpaMenRecords == null || qrCodes == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final List<BirthGuideStep> steps;
    try {
      steps = buildBirthGuideSteps(
        target: widget.target,
        allDenpaMen: denpaMenRecords,
        allQrCodes: qrCodes,
      );
    } on BirthGuideResolutionException {
      _showError();
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final (slides, isConfirmSlide) = _buildSlides(steps, t);
    final isLastSlide = _currentIndex >= slides.length - 1;
    final buttonLabel = isLastSlide
        ? t.birthGuide.finish
        : isConfirmSlide[_currentIndex]
        ? t.common.confirm
        : t.common.next;

    return AppScaffold(
      title: OutlinedTitleText(text: t.page.birthGuide),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _advance(slides.length),
        label: Text(buttonLabel),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: BirthGuideProgressBar(
              current: _currentIndex + 1,
              total: slides.length,
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) =>
                  setState(() => _currentIndex = index),
              children: slides,
            ),
          ),
        ],
      ),
    );
  }
}
