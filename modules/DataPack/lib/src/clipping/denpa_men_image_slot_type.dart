/// The built-in image slots a [DenpaMen](../denpa_men/denpa_men.dart) can
/// have: a close-up face shot, a full-body shot, and the representative
/// icon. [name] (Dart's built-in enum accessor) is used directly as the
/// on-disk directory name / storage key for each slot, so renaming these
/// members changes on-disk layout. [defaultPriority] is the fallback
/// ranking used when a slot type has no persisted `ClippingSlot` yet (see
/// `ClippingSlot.priority`) — [icon] defaults to the highest priority so
/// existing single-icon data keeps behaving the same way after this
/// multi-slot feature is introduced.
enum DenpaMenImageSlotType {
  face,
  wholeBody,
  icon;

  static const Map<DenpaMenImageSlotType, int> defaultPriority = {
    DenpaMenImageSlotType.icon: 0,
    DenpaMenImageSlotType.face: 1,
    DenpaMenImageSlotType.wholeBody: 2,
  };
}
