import 'package:data_pack/data_pack.dart';
import 'package:flutter/material.dart';

import 'editable_denpa_men_icon.dart';

/// Bundles all three [DenpaMenImageSlotType] icons (`face`, `wholeBody`,
/// `icon`) for [denpaMenId] behind a single [size]×[size] icon, swipeable
/// with a [PageView] — exactly one is ever visible at a time, matching
/// [MediaZoomDialog](../../../modules/Widgets/lib/src/dialog/media_zoom_dialog.dart)'s
/// own swipe-between-images convention, rather than showing several
/// icons side by side. Each page is independently editable via
/// [EditableDenpaMenIcon]. Used as the `icon` slot of `AddDenpaMen` in
/// the `DenpaMenEditor` page.
class EditableDenpaMenIconSwiper extends StatefulWidget {
  const EditableDenpaMenIconSwiper({
    super.key,
    required this.denpaMenId,
    required this.size,
  });

  final String denpaMenId;
  final double size;

  @override
  State<EditableDenpaMenIconSwiper> createState() =>
      _EditableDenpaMenIconSwiperState();
}

class _EditableDenpaMenIconSwiperState
    extends State<EditableDenpaMenIconSwiper> {
  late final PageController _controller = PageController(
    initialPage: DenpaMenImageSlotType.values.indexOf(
      DenpaMenImageSlotType.icon,
    ),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: PageView(
        controller: _controller,
        children: [
          for (final slot in DenpaMenImageSlotType.values)
            EditableDenpaMenIcon(
              denpaMenId: widget.denpaMenId,
              slot: slot,
              size: widget.size,
            ),
        ],
      ),
    );
  }
}
