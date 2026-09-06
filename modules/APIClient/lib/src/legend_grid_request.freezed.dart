// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'legend_grid_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LegendGridRequest {

 String get level; String get anntenaCategory; int get matchColumnIndex; int get matchLineOffset; int get matchEvasionRate;
/// Create a copy of LegendGridRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LegendGridRequestCopyWith<LegendGridRequest> get copyWith => _$LegendGridRequestCopyWithImpl<LegendGridRequest>(this as LegendGridRequest, _$identity);

  /// Serializes this LegendGridRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LegendGridRequest&&(identical(other.level, level) || other.level == level)&&(identical(other.anntenaCategory, anntenaCategory) || other.anntenaCategory == anntenaCategory)&&(identical(other.matchColumnIndex, matchColumnIndex) || other.matchColumnIndex == matchColumnIndex)&&(identical(other.matchLineOffset, matchLineOffset) || other.matchLineOffset == matchLineOffset)&&(identical(other.matchEvasionRate, matchEvasionRate) || other.matchEvasionRate == matchEvasionRate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,level,anntenaCategory,matchColumnIndex,matchLineOffset,matchEvasionRate);

@override
String toString() {
  return 'LegendGridRequest(level: $level, anntenaCategory: $anntenaCategory, matchColumnIndex: $matchColumnIndex, matchLineOffset: $matchLineOffset, matchEvasionRate: $matchEvasionRate)';
}


}

/// @nodoc
abstract mixin class $LegendGridRequestCopyWith<$Res>  {
  factory $LegendGridRequestCopyWith(LegendGridRequest value, $Res Function(LegendGridRequest) _then) = _$LegendGridRequestCopyWithImpl;
@useResult
$Res call({
 String level, String anntenaCategory, int matchColumnIndex, int matchLineOffset, int matchEvasionRate
});




}
/// @nodoc
class _$LegendGridRequestCopyWithImpl<$Res>
    implements $LegendGridRequestCopyWith<$Res> {
  _$LegendGridRequestCopyWithImpl(this._self, this._then);

  final LegendGridRequest _self;
  final $Res Function(LegendGridRequest) _then;

/// Create a copy of LegendGridRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? level = null,Object? anntenaCategory = null,Object? matchColumnIndex = null,Object? matchLineOffset = null,Object? matchEvasionRate = null,}) {
  return _then(_self.copyWith(
level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,anntenaCategory: null == anntenaCategory ? _self.anntenaCategory : anntenaCategory // ignore: cast_nullable_to_non_nullable
as String,matchColumnIndex: null == matchColumnIndex ? _self.matchColumnIndex : matchColumnIndex // ignore: cast_nullable_to_non_nullable
as int,matchLineOffset: null == matchLineOffset ? _self.matchLineOffset : matchLineOffset // ignore: cast_nullable_to_non_nullable
as int,matchEvasionRate: null == matchEvasionRate ? _self.matchEvasionRate : matchEvasionRate // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [LegendGridRequest].
extension LegendGridRequestPatterns on LegendGridRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LegendGridRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LegendGridRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LegendGridRequest value)  $default,){
final _that = this;
switch (_that) {
case _LegendGridRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LegendGridRequest value)?  $default,){
final _that = this;
switch (_that) {
case _LegendGridRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String level,  String anntenaCategory,  int matchColumnIndex,  int matchLineOffset,  int matchEvasionRate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LegendGridRequest() when $default != null:
return $default(_that.level,_that.anntenaCategory,_that.matchColumnIndex,_that.matchLineOffset,_that.matchEvasionRate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String level,  String anntenaCategory,  int matchColumnIndex,  int matchLineOffset,  int matchEvasionRate)  $default,) {final _that = this;
switch (_that) {
case _LegendGridRequest():
return $default(_that.level,_that.anntenaCategory,_that.matchColumnIndex,_that.matchLineOffset,_that.matchEvasionRate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String level,  String anntenaCategory,  int matchColumnIndex,  int matchLineOffset,  int matchEvasionRate)?  $default,) {final _that = this;
switch (_that) {
case _LegendGridRequest() when $default != null:
return $default(_that.level,_that.anntenaCategory,_that.matchColumnIndex,_that.matchLineOffset,_that.matchEvasionRate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LegendGridRequest implements LegendGridRequest {
  const _LegendGridRequest({required this.level, required this.anntenaCategory, required this.matchColumnIndex, required this.matchLineOffset, required this.matchEvasionRate});
  factory _LegendGridRequest.fromJson(Map<String, dynamic> json) => _$LegendGridRequestFromJson(json);

@override final  String level;
@override final  String anntenaCategory;
@override final  int matchColumnIndex;
@override final  int matchLineOffset;
@override final  int matchEvasionRate;

/// Create a copy of LegendGridRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LegendGridRequestCopyWith<_LegendGridRequest> get copyWith => __$LegendGridRequestCopyWithImpl<_LegendGridRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LegendGridRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LegendGridRequest&&(identical(other.level, level) || other.level == level)&&(identical(other.anntenaCategory, anntenaCategory) || other.anntenaCategory == anntenaCategory)&&(identical(other.matchColumnIndex, matchColumnIndex) || other.matchColumnIndex == matchColumnIndex)&&(identical(other.matchLineOffset, matchLineOffset) || other.matchLineOffset == matchLineOffset)&&(identical(other.matchEvasionRate, matchEvasionRate) || other.matchEvasionRate == matchEvasionRate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,level,anntenaCategory,matchColumnIndex,matchLineOffset,matchEvasionRate);

@override
String toString() {
  return 'LegendGridRequest(level: $level, anntenaCategory: $anntenaCategory, matchColumnIndex: $matchColumnIndex, matchLineOffset: $matchLineOffset, matchEvasionRate: $matchEvasionRate)';
}


}

/// @nodoc
abstract mixin class _$LegendGridRequestCopyWith<$Res> implements $LegendGridRequestCopyWith<$Res> {
  factory _$LegendGridRequestCopyWith(_LegendGridRequest value, $Res Function(_LegendGridRequest) _then) = __$LegendGridRequestCopyWithImpl;
@override @useResult
$Res call({
 String level, String anntenaCategory, int matchColumnIndex, int matchLineOffset, int matchEvasionRate
});




}
/// @nodoc
class __$LegendGridRequestCopyWithImpl<$Res>
    implements _$LegendGridRequestCopyWith<$Res> {
  __$LegendGridRequestCopyWithImpl(this._self, this._then);

  final _LegendGridRequest _self;
  final $Res Function(_LegendGridRequest) _then;

/// Create a copy of LegendGridRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? level = null,Object? anntenaCategory = null,Object? matchColumnIndex = null,Object? matchLineOffset = null,Object? matchEvasionRate = null,}) {
  return _then(_LegendGridRequest(
level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,anntenaCategory: null == anntenaCategory ? _self.anntenaCategory : anntenaCategory // ignore: cast_nullable_to_non_nullable
as String,matchColumnIndex: null == matchColumnIndex ? _self.matchColumnIndex : matchColumnIndex // ignore: cast_nullable_to_non_nullable
as int,matchLineOffset: null == matchLineOffset ? _self.matchLineOffset : matchLineOffset // ignore: cast_nullable_to_non_nullable
as int,matchEvasionRate: null == matchEvasionRate ? _self.matchEvasionRate : matchEvasionRate // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
