// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'physique_antenna_category_antenna_link.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PhysiqueAntennaCategoryAntennaLink {

 String get major; String get minor; String get antennaId; String get antennaName;
/// Create a copy of PhysiqueAntennaCategoryAntennaLink
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhysiqueAntennaCategoryAntennaLinkCopyWith<PhysiqueAntennaCategoryAntennaLink> get copyWith => _$PhysiqueAntennaCategoryAntennaLinkCopyWithImpl<PhysiqueAntennaCategoryAntennaLink>(this as PhysiqueAntennaCategoryAntennaLink, _$identity);

  /// Serializes this PhysiqueAntennaCategoryAntennaLink to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhysiqueAntennaCategoryAntennaLink&&(identical(other.major, major) || other.major == major)&&(identical(other.minor, minor) || other.minor == minor)&&(identical(other.antennaId, antennaId) || other.antennaId == antennaId)&&(identical(other.antennaName, antennaName) || other.antennaName == antennaName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,major,minor,antennaId,antennaName);

@override
String toString() {
  return 'PhysiqueAntennaCategoryAntennaLink(major: $major, minor: $minor, antennaId: $antennaId, antennaName: $antennaName)';
}


}

/// @nodoc
abstract mixin class $PhysiqueAntennaCategoryAntennaLinkCopyWith<$Res>  {
  factory $PhysiqueAntennaCategoryAntennaLinkCopyWith(PhysiqueAntennaCategoryAntennaLink value, $Res Function(PhysiqueAntennaCategoryAntennaLink) _then) = _$PhysiqueAntennaCategoryAntennaLinkCopyWithImpl;
@useResult
$Res call({
 String major, String minor, String antennaId, String antennaName
});




}
/// @nodoc
class _$PhysiqueAntennaCategoryAntennaLinkCopyWithImpl<$Res>
    implements $PhysiqueAntennaCategoryAntennaLinkCopyWith<$Res> {
  _$PhysiqueAntennaCategoryAntennaLinkCopyWithImpl(this._self, this._then);

  final PhysiqueAntennaCategoryAntennaLink _self;
  final $Res Function(PhysiqueAntennaCategoryAntennaLink) _then;

/// Create a copy of PhysiqueAntennaCategoryAntennaLink
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? major = null,Object? minor = null,Object? antennaId = null,Object? antennaName = null,}) {
  return _then(_self.copyWith(
major: null == major ? _self.major : major // ignore: cast_nullable_to_non_nullable
as String,minor: null == minor ? _self.minor : minor // ignore: cast_nullable_to_non_nullable
as String,antennaId: null == antennaId ? _self.antennaId : antennaId // ignore: cast_nullable_to_non_nullable
as String,antennaName: null == antennaName ? _self.antennaName : antennaName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PhysiqueAntennaCategoryAntennaLink].
extension PhysiqueAntennaCategoryAntennaLinkPatterns on PhysiqueAntennaCategoryAntennaLink {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhysiqueAntennaCategoryAntennaLink value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhysiqueAntennaCategoryAntennaLink() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhysiqueAntennaCategoryAntennaLink value)  $default,){
final _that = this;
switch (_that) {
case _PhysiqueAntennaCategoryAntennaLink():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhysiqueAntennaCategoryAntennaLink value)?  $default,){
final _that = this;
switch (_that) {
case _PhysiqueAntennaCategoryAntennaLink() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String major,  String minor,  String antennaId,  String antennaName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhysiqueAntennaCategoryAntennaLink() when $default != null:
return $default(_that.major,_that.minor,_that.antennaId,_that.antennaName);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String major,  String minor,  String antennaId,  String antennaName)  $default,) {final _that = this;
switch (_that) {
case _PhysiqueAntennaCategoryAntennaLink():
return $default(_that.major,_that.minor,_that.antennaId,_that.antennaName);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String major,  String minor,  String antennaId,  String antennaName)?  $default,) {final _that = this;
switch (_that) {
case _PhysiqueAntennaCategoryAntennaLink() when $default != null:
return $default(_that.major,_that.minor,_that.antennaId,_that.antennaName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PhysiqueAntennaCategoryAntennaLink implements PhysiqueAntennaCategoryAntennaLink {
  const _PhysiqueAntennaCategoryAntennaLink({required this.major, required this.minor, required this.antennaId, required this.antennaName});
  factory _PhysiqueAntennaCategoryAntennaLink.fromJson(Map<String, dynamic> json) => _$PhysiqueAntennaCategoryAntennaLinkFromJson(json);

@override final  String major;
@override final  String minor;
@override final  String antennaId;
@override final  String antennaName;

/// Create a copy of PhysiqueAntennaCategoryAntennaLink
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhysiqueAntennaCategoryAntennaLinkCopyWith<_PhysiqueAntennaCategoryAntennaLink> get copyWith => __$PhysiqueAntennaCategoryAntennaLinkCopyWithImpl<_PhysiqueAntennaCategoryAntennaLink>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PhysiqueAntennaCategoryAntennaLinkToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhysiqueAntennaCategoryAntennaLink&&(identical(other.major, major) || other.major == major)&&(identical(other.minor, minor) || other.minor == minor)&&(identical(other.antennaId, antennaId) || other.antennaId == antennaId)&&(identical(other.antennaName, antennaName) || other.antennaName == antennaName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,major,minor,antennaId,antennaName);

@override
String toString() {
  return 'PhysiqueAntennaCategoryAntennaLink(major: $major, minor: $minor, antennaId: $antennaId, antennaName: $antennaName)';
}


}

/// @nodoc
abstract mixin class _$PhysiqueAntennaCategoryAntennaLinkCopyWith<$Res> implements $PhysiqueAntennaCategoryAntennaLinkCopyWith<$Res> {
  factory _$PhysiqueAntennaCategoryAntennaLinkCopyWith(_PhysiqueAntennaCategoryAntennaLink value, $Res Function(_PhysiqueAntennaCategoryAntennaLink) _then) = __$PhysiqueAntennaCategoryAntennaLinkCopyWithImpl;
@override @useResult
$Res call({
 String major, String minor, String antennaId, String antennaName
});




}
/// @nodoc
class __$PhysiqueAntennaCategoryAntennaLinkCopyWithImpl<$Res>
    implements _$PhysiqueAntennaCategoryAntennaLinkCopyWith<$Res> {
  __$PhysiqueAntennaCategoryAntennaLinkCopyWithImpl(this._self, this._then);

  final _PhysiqueAntennaCategoryAntennaLink _self;
  final $Res Function(_PhysiqueAntennaCategoryAntennaLink) _then;

/// Create a copy of PhysiqueAntennaCategoryAntennaLink
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? major = null,Object? minor = null,Object? antennaId = null,Object? antennaName = null,}) {
  return _then(_PhysiqueAntennaCategoryAntennaLink(
major: null == major ? _self.major : major // ignore: cast_nullable_to_non_nullable
as String,minor: null == minor ? _self.minor : minor // ignore: cast_nullable_to_non_nullable
as String,antennaId: null == antennaId ? _self.antennaId : antennaId // ignore: cast_nullable_to_non_nullable
as String,antennaName: null == antennaName ? _self.antennaName : antennaName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
