import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../domain/denpa_men/denpa_men.dart';
import '../domain/denpa_men/denpa_men_correction_calculator.dart';
import '../domain/denpa_men/denpa_men_factory.dart';
import '../domain/master_data/master_data.dart';
import '../i18n/gen/strings.g.dart';
import '../providers/master_data_providers.dart';
import '../theme/app_colors.dart';
import '../widgets/denpa_men_status.dart';
import '../widgets/editable_denpa_men_status.dart';
import '../widgets/header/slanted_app_bar.dart';
import '../widgets/label/gauge_value.dart';
import '../widgets/label/outlined_title.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final masterDataAsync = ref.watch(masterDataProvider);

    return Scaffold(
      appBar: SlantedAppBar(
        title: OutlinedTitleText(text: context.t.page.home),
      ),
      body: masterDataAsync.when(
        data: (masterData) => _HomeBody(masterData: masterData),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('$error')),
      ),
    );
  }
}

class _HomeBody extends StatefulWidget {
  const _HomeBody({required this.masterData});

  final MasterData masterData;

  @override
  State<_HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<_HomeBody> {
  late DenpaMen _denpaMen = createDenpaMen(
    name: 'こうた',
    bodyColors: const ['black'],
    isSpColor: true,
    headShape: widget.masterData.headShapes.firstWhere((h) => h.id == 'circle'),
    physique: widget.masterData.physiques.first,
    personality: widget.masterData.personalities.first,
    pattern: widget.masterData.patterns.first,
    anntena: widget.masterData.anntenas.first,
    masterData: widget.masterData,
    happiness: 320,
    maxHappiness: 320,
    level: 180,
    maxLevel: 180,
    hp: 9309,
    ap: 7,
    attack: 5969,
    defense: 5436,
    speed: 5583,
    evasionRate: 7,
    corrections: [
      widget.masterData.corrections.firstWhere((c) => c.id == 'protagonist'),
    ],
    memo: null,
  );

  void _applyEdit(DenpaMen draft) {
    setState(() {
      _denpaMen = createDenpaMen(
        name: draft.name,
        bodyColors: draft.bodyColors,
        isSpColor: draft.isSpColor,
        headShape: draft.headShape,
        physique: draft.physique,
        personality: draft.personality,
        pattern: draft.pattern,
        anntena: draft.anntena,
        masterData: widget.masterData,
        happiness: draft.happiness,
        maxHappiness: draft.maxHappiness,
        level: draft.level,
        maxLevel: draft.maxLevel,
        currentExp: draft.currentExp,
        maxExp: draft.maxExp,
        hp: draft.hp,
        ap: draft.ap,
        attack: draft.attack,
        defense: draft.defense,
        speed: draft.speed,
        evasionRate: draft.evasionRate,
        corrections: draft.corrections,
        memo: draft.memo,
      );
    });
  }

  static const double _minPaneWidth = 360;
  static const double _paneGap = 16;
  static const double _wheelPageChangeThreshold = 20;

  final PageController _pageController = PageController();
  bool _isChangingPage = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handlePointerSignal(PointerSignalEvent event) {
    if (event is! PointerScrollEvent || _isChangingPage) {
      return;
    }
    final delta = event.scrollDelta.dx.abs() > event.scrollDelta.dy.abs()
        ? event.scrollDelta.dx
        : event.scrollDelta.dy;
    if (delta.abs() < _wheelPageChangeThreshold) {
      return;
    }

    final currentPage = _pageController.page?.round() ?? 0;
    final targetPage = (currentPage + (delta > 0 ? 1 : -1)).clamp(0, 1);
    if (targetPage == currentPage) {
      return;
    }

    _isChangingPage = true;
    _pageController
        .animateToPage(
          targetPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        )
        .whenComplete(() => _isChangingPage = false);
  }

  @override
  Widget build(BuildContext context) {
    final corrected = _denpaMen.applyCorrections();

    final preview = DenpaMenStatus(
      name: corrected.name,
      level: GaugeValue(current: corrected.level, max: corrected.maxLevel),
      happiness: GaugeValue(
        current: corrected.happiness,
        max: corrected.maxHappiness,
      ),
      expProgress:
          corrected.currentExp != null &&
              corrected.maxExp != null &&
              corrected.maxExp! > 0
          ? corrected.currentExp! / corrected.maxExp!
          : null,
      attributeResistances: corrected.attributeResistance,
      abnormalityResistances: corrected.abnormalityResistances,
      hp: corrected.hp,
      ap: corrected.ap,
      attack: corrected.attack,
      defense: corrected.defense,
      speed: corrected.speed,
      evasionRate: corrected.evasionRate,
      totalAttributeCount: widget.masterData.attributes.length,
      memo: corrected.memo,
    );
    final editable = EditableDenpaMenStatus(
      denpaMen: _denpaMen,
      headShapes: widget.masterData.headShapes,
      corrections: widget.masterData.corrections,
      onChanged: _applyEdit,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= _minPaneWidth * 2 + _paneGap) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: preview),
                const SizedBox(width: _paneGap),
                Expanded(child: editable),
              ],
            ),
          );
        }

        return Column(
          children: [
            Expanded(
              child: Listener(
                onPointerSignal: _handlePointerSignal,
                child: PageView(
                  controller: _pageController,
                  children: [
                    _HomeBodyPane(minWidth: _minPaneWidth, child: preview),
                    _HomeBodyPane(minWidth: _minPaneWidth, child: editable),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: SmoothPageIndicator(
                controller: _pageController,
                count: 2,
                effect: WormEffect(
                  dotColor: AppColors.nestedBorder,
                  activeDotColor: AppColors.accent,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Wraps a pane at a fixed [minWidth] so it never shrinks below its default
/// size; if the viewport is narrower still, the pane scrolls horizontally
/// instead of compressing its contents.
class _HomeBodyPane extends StatelessWidget {
  const _HomeBodyPane({required this.minWidth, required this.child});

  final double minWidth;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: minWidth,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: child,
        ),
      ),
    );
  }
}
