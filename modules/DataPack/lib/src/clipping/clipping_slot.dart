import 'package:freezed_annotation/freezed_annotation.dart';

import 'denpa_men_image_slot_type.dart';

part 'clipping_slot.freezed.dart';
part 'clipping_slot.g.dart';

/// A user-configured crop region for one [DenpaMenImageSlotType], stored
/// as a relative rectangle (each edge is a 0.0-1.0 fraction of the source
/// image's width/height) so it can be reapplied to any newly picked image
/// without reopening the interactive cropper. [priority] decides which
/// slot's image is used as an individual's representative thumbnail when
/// several slots have images (lower priority value shown first); it is
/// also editable independently of the crop region itself, e.g. by
/// dragging to reorder in the clipping settings screen.
@freezed
abstract class ClippingSlot with _$ClippingSlot {
  const ClippingSlot._();

  const factory ClippingSlot({
    required DenpaMenImageSlotType slotType,
    required String name,
    required int priority,
    required double left,
    required double top,
    required double right,
    required double bottom,
  }) = _ClippingSlot;

  factory ClippingSlot.fromJson(Map<String, dynamic> json) =>
      _$ClippingSlotFromJson(json);

  double get width => right - left;
  double get height => bottom - top;
}

/// Builds a [ClippingSlot], asserting that [left] < [right] and [top] <
/// [bottom]. Use this instead of [ClippingSlot.new] directly wherever the
/// rectangle is computed from user input (e.g. a crop result).
ClippingSlot createClippingSlot({
  required DenpaMenImageSlotType slotType,
  required String name,
  required int priority,
  required double left,
  required double top,
  required double right,
  required double bottom,
}) {
  assert(left < right, 'left must be less than right');
  assert(top < bottom, 'top must be less than bottom');
  return ClippingSlot(
    slotType: slotType,
    name: name,
    priority: priority,
    left: left,
    top: top,
    right: right,
    bottom: bottom,
  );
}
