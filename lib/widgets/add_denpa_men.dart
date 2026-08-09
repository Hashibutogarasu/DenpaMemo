import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../domain/denpa_men/denpa_men.dart';
import '../domain/denpa_men/denpa_men_record.dart';
import '../domain/master_data/master_data.dart';
import '../domain/qr_code/qr_code_record.dart';
import '../theme/app_colors.dart';
import 'denpa_men_status.dart';
import 'editable_denpa_men_status.dart';

/// Bundles the read-only preview ([DenpaMenStatus]) and the editable pane
/// ([EditableDenpaMenStatus]) used to add or edit a [DenpaMen].
///
/// On a wide viewport the two panes sit side by side; on a narrow one they
/// become swipeable pages with a dot indicator, also reachable by mouse
/// wheel. [denpaMen] is fully controlled by the caller: every edit is
/// reported through [onChanged] with a new draft, which the caller should
/// re-derive (e.g. via `createDenpaMen`) and feed back in.
class AddDenpaMen extends StatefulWidget {
  const AddDenpaMen({
    super.key,
    required this.denpaMen,
    required this.masterData,
    required this.parentCandidates,
    required this.qrCodeCandidates,
    required this.onChanged,
    this.minPaneWidth = 360,
    this.paneGap = 16,
    this.wheelPageChangeThreshold = 20,
  });

  final DenpaMen denpaMen;
  final MasterData masterData;
  final List<DenpaMenRecord> parentCandidates;
  final List<QrCodeRecord> qrCodeCandidates;
  final ValueChanged<DenpaMen> onChanged;
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
    if (event is! PointerScrollEvent || _isChangingPage) {
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
    final preview = DenpaMenStatus.fromDenpaMen(
      widget.denpaMen,
      totalAttributeCount: widget.masterData.attributes.length,
      includeStatBonus: widget.denpaMen.considerCorrections,
      showIcon: true,
    );
    final editable = EditableDenpaMenStatus(
      denpaMen: widget.denpaMen,
      headShapes: widget.masterData.headShapes,
      anntenas: widget.masterData.anntenas,
      corrections: widget.masterData.corrections,
      parentCandidates: widget.parentCandidates,
      qrCodeCandidates: widget.qrCodeCandidates,
      onChanged: widget.onChanged,
      considerCorrections: widget.denpaMen.considerCorrections,
      onConsiderCorrectionsChanged: (value) => widget.onChanged(
        widget.denpaMen.copyWith(considerCorrections: value),
      ),
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
                    _AddDenpaMenPane(minWidth: widget.minPaneWidth, child: preview),
                    _AddDenpaMenPane(minWidth: widget.minPaneWidth, child: editable),
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
