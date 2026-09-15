import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:data_pack/data_pack.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'denpa_men_status.dart';
import 'editable_denpa_men_status.dart';
import 'icon/denpa_men_icon_builder.dart';
import 'theme/denpa_men_container_theme.dart';

/// Data required to render and edit one DenpaMen.
class DenpaMenEditorData {
  const DenpaMenEditorData({
    required this.denpaMen,
    required this.masterData,
    required this.qrCodeCandidates,
    required this.icon,
    required this.parentCandidates,
    this.iconFile,
    this.qrCodeEditable = true,
  });

  final DenpaMen denpaMen;
  final MasterData masterData;
  final List<QrCodeRecord> qrCodeCandidates;
  final Widget icon;
  final File? iconFile;
  final List<DenpaMenRecord> parentCandidates;
  final bool qrCodeEditable;
}

/// Actions invoked by the DenpaMen editor.
class DenpaMenEditorActions {
  const DenpaMenEditorActions({
    required this.onChanged,
    required this.onPickParents,
    required this.onPickMonsterExp,
    required this.onIdentifyPhysique,
  });

  final ValueChanged<DenpaMen> onChanged;
  final Future<List<DenpaMenRecord>?> Function(BuildContext) onPickParents;
  final Future<MonsterExp?> Function(BuildContext) onPickMonsterExp;
  final Future<PhysiqueIdentification?> Function(BuildContext)
  onIdentifyPhysique;
}

/// Bundles the read-only preview ([DenpaMenStatus]) and the editable pane
/// ([EditableDenpaMenStatus]) used to add or edit a [DenpaMen]. On a wide
/// viewport the two panes sit side by side; on a narrow one they become
/// swipeable pages. [data] is controlled by the caller and [actions] reports
/// each edit as a new draft to re-derive and feed back in.
class AddDenpaMen extends StatefulWidget {
  const AddDenpaMen({
    super.key,
    required this.data,
    required this.actions,
    this.minPaneWidth = 360,
    this.paneGap = 16,
    this.wheelPageChangeThreshold = 20,
  });

  final DenpaMenEditorData data;
  final DenpaMenEditorActions actions;
  final double minPaneWidth;
  final double paneGap;
  final double wheelPageChangeThreshold;

  @override
  State<AddDenpaMen> createState() => _AddDenpaMenState();
}

class _AddDenpaMenState extends State<AddDenpaMen> {
  final PageController _pageController = PageController();
  bool _isChangingPage = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handlePointerSignal(PointerSignalEvent event) {
    if (event is! PointerScrollEvent ||
        _isChangingPage ||
        !_pageController.hasClients) {
      return;
    }
    final delta = event.scrollDelta.dx.abs() > event.scrollDelta.dy.abs()
        ? event.scrollDelta.dx
        : event.scrollDelta.dy;
    if (delta.abs() < widget.wheelPageChangeThreshold) {
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
    final containerTheme = Theme.of(
      context,
    ).extension<DenpaMenContainerThemeData>()!;
    final data = widget.data;
    final actions = widget.actions;
    final preview = DenpaMenStatus.fromDenpaMen(
      data.denpaMen,
      totalAttributeCount: data.masterData.attributes.length,
      includeStatBonus: data.denpaMen.considerCorrections,
      showIcon: true,
      iconBuilder: staticDenpaMenIconBuilder(data.iconFile),
    );
    final editable = EditableDenpaMenStatus(
      denpaMen: data.denpaMen,
      headShapes: data.masterData.headShapes,
      anntenas: data.masterData.anntenas,
      corrections: data.masterData.corrections,
      attributes: data.masterData.attributes,
      abnormalityTypes: data.masterData.abnormalityTypes,
      qrCodeCandidates: data.qrCodeCandidates,
      onChanged: actions.onChanged,
      qrCodeEditable: data.qrCodeEditable,
      considerCorrections: data.denpaMen.considerCorrections,
      onConsiderCorrectionsChanged: (value) =>
          actions.onChanged(data.denpaMen.copyWith(considerCorrections: value)),
      icon: data.icon,
      parentCandidates: data.parentCandidates,
      onPickParents: actions.onPickParents,
      onPickMonsterExp: actions.onPickMonsterExp,
      onIdentifyPhysique: actions.onIdentifyPhysique,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= widget.minPaneWidth * 2 + widget.paneGap) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: preview),
                SizedBox(width: widget.paneGap),
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
                    _AddDenpaMenPane(
                      minWidth: widget.minPaneWidth,
                      child: editable,
                    ),
                    _AddDenpaMenPane(
                      minWidth: widget.minPaneWidth,
                      child: preview,
                    ),
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
                  dotColor: containerTheme.nestedBorderColor,
                  activeDotColor: containerTheme.accentColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Fills the page's viewport width, but never shrinks below [minWidth]; if
/// the viewport is narrower still, the pane scrolls horizontally instead of
/// compressing its contents.
class _AddDenpaMenPane extends StatelessWidget {
  const _AddDenpaMenPane({required this.minWidth, required this.child});

  final double minWidth;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: math.max(minWidth, constraints.maxWidth),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: child,
            ),
          ),
        );
      },
    );
  }
}
