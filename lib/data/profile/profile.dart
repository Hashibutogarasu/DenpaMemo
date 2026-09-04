import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

/// A named, domain-agnostic profile. Used to keep several independent
/// sets of settings under one feature's storage (see `ProfileStorage`),
/// switchable through the generic `ProfileSwitchPage` without that page
/// or this model knowing what the settings themselves are for.
@freezed
abstract class Profile with _$Profile {
  const factory Profile({required String id, required String name}) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
}
