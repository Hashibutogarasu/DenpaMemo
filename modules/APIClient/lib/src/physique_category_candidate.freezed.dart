// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'physique_category_candidate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PhysiqueCategoryCandidate {

 String get textKey; String? get text; EvasionRateSign? get sign; int get evasionRateStart; int get evasionRateEnd;
/// Create a copy of PhysiqueCategoryCandidate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhysiqueCategoryCandidateCopyWith<PhysiqueCategoryCandidate> get copyWith => _$PhysiqueCategoryCandidateCopyWithImpl<PhysiqueCategoryCandidate>(this as PhysiqueCategoryCandidate, _$identity);

  /// Serializes this PhysiqueCategoryCandidate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhysiqueCategoryCandidate&&(identical(other.textKey, textKey) || other.textKey == textKey)&&(identical(other.text, text) || other.text == text)&&(identical(other.sign, sign) || other.sign == sign)&&(identical(other.evasionRateStart, evasionRateStart) || other.evasionRateStart == evasionRateStart)&&(identical(other.evasionRateEnd, evasionRateEnd) || other.evasionRateEnd == evasionRateEnd));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,textKey,text,sign,evasionRateStart,evasionRateEnd);

@override
String toString() {
  return 'PhysiqueCategoryCandidate(textKey: $textKey, text: $text, sign: $sign, evasionRateStart: $evasionRateStart, evasionRateEnd: $evasionRateEnd)';
}


}

/// @nodoc
abstract mixin class $PhysiqueCategoryCandidateCopyWith<$Res>  {
  factory $PhysiqueCategoryCandidateCopyWith(PhysiqueCategoryCandidate value, $Res Function(PhysiqueCategoryCandidate) _then) = _$PhysiqueCategoryCandidateCopyWithImpl;
@useResult
$Res call({
 String textKey, String? text, EvasionRateSign? sign, int evasionRateStart, int evasionRateEnd
});




}
/// @nodoc
class _$PhysiqueCategoryCandidateCopyWithImpl<$Res>
    implements $PhysiqueCategoryCandidateCopyWith<$Res> {
  _$PhysiqueCategoryCandidateCopyWithImpl(this._self, this._then);

  final PhysiqueCategoryCandidate _self;
  final $Res Function(PhysiqueCategoryCandidate) _then;

/// Create a copy of PhysiqueCategoryCandidate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? textKey = null,Object? text = freezed,Object? sign = freezed,Object? evasionRateStart = null,Object? evasionRateEnd = null,}) {
  return _then(_self.copyWith(
textKey: null == textKey ? _self.textKey : textKey // ignore: cast_nullable_to_non_nullable
as String,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,sign: freezed == sign ? _self.sign : sign // ignore: cast_nullable_to_non_nullable
as EvasionRateSign?,evasionRateStart: null == evasionRateStart ? _self.evasionRateStart : evasionRateStart // ignore: cast_nullable_to_non_nullable
as int,evasionRateEnd: null == evasionRateEnd ? _self.evasionRateEnd : evasionRateEnd // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PhysiqueCategoryCandidate].
extension PhysiqueCategoryCandidatePatterns on PhysiqueCategoryCandidate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhysiqueCategoryCandidate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhysiqueCategoryCandidate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhysiqueCategoryCandidate value)  $default,){
final _that = this;
switch (_that) {
case _PhysiqueCategoryCandidate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhysiqueCategoryCandidate value)?  $default,){
final _that = this;
switch (_that) {
case _PhysiqueCategoryCandidate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String textKey,  String? text,  EvasionRateSign? sign,  int evasionRateStart,  int evasionRateEnd)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhysiqueCategoryCandidate() when $default != null:
return $default(_that.textKey,_that.text,_that.sign,_that.evasionRateStart,_that.evasionRateEnd);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String textKey,  String? text,  EvasionRateSign? sign,  int evasionRateStart,  int evasionRateEnd)  $default,) {final _that = this;
switch (_that) {
case _PhysiqueCategoryCandidate():
return $default(_that.textKey,_that.text,_that.sign,_that.evasionRateStart,_that.evasionRateEnd);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String textKey,  String? text,  EvasionRateSign? sign,  int evasionRateStart,  int evasionRateEnd)?  $default,) {final _that = this;
switch (_that) {
case _PhysiqueCategoryCandidate() when $default != null:
return $default(_that.textKey,_that.text,_that.sign,_that.evasionRateStart,_that.evasionRateEnd);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PhysiqueCategoryCandidate implements PhysiqueCategoryCandidate {
  const _PhysiqueCategoryCandidate({required this.textKey, this.text, this.sign, required this.evasionRateStart, required this.evasionRateEnd});
  factory _PhysiqueCategoryCandidate.fromJson(Map<String, dynamic> json) => _$PhysiqueCategoryCandidateFromJson(json);

@override final  String textKey;
@override final  String? text;
@override final  EvasionRateSign? sign;
@override final  int evasionRateStart;
@override final  int evasionRateEnd;

/// Create a copy of PhysiqueCategoryCandidate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhysiqueCategoryCandidateCopyWith<_PhysiqueCategoryCandidate> get copyWith => __$PhysiqueCategoryCandidateCopyWithImpl<_PhysiqueCategoryCandidate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PhysiqueCategoryCandidateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhysiqueCategoryCandidate&&(identical(other.textKey, textKey) || other.textKey == textKey)&&(identical(other.text, text) || other.text == text)&&(identical(other.sign, sign) || other.sign == sign)&&(identical(other.evasionRateStart, evasionRateStart) || other.evasionRateStart == evasionRateStart)&&(identical(other.evasionRateEnd, evasionRateEnd) || other.evasionRateEnd == evasionRateEnd));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,textKey,text,sign,evasionRateStart,evasionRateEnd);

@override
String toString() {
  return 'PhysiqueCategoryCandidate(textKey: $textKey, text: $text, sign: $sign, evasionRateStart: $evasionRateStart, evasionRateEnd: $evasionRateEnd)';
}


}

/// @nodoc
abstract mixin class _$PhysiqueCategoryCandidateCopyWith<$Res> implements $PhysiqueCategoryCandidateCopyWith<$Res> {
  factory _$PhysiqueCategoryCandidateCopyWith(_PhysiqueCategoryCandidate value, $Res Function(_PhysiqueCategoryCandidate) _then) = __$PhysiqueCategoryCandidateCopyWithImpl;
@override @useResult
$Res call({
 String textKey, String? text, EvasionRateSign? sign, int evasionRateStart, int evasionRateEnd
});




}
/// @nodoc
class __$PhysiqueCategoryCandidateCopyWithImpl<$Res>
    implements _$PhysiqueCategoryCandidateCopyWith<$Res> {
  __$PhysiqueCategoryCandidateCopyWithImpl(this._self, this._then);

  final _PhysiqueCategoryCandidate _self;
  final $Res Function(_PhysiqueCategoryCandidate) _then;

/// Create a copy of PhysiqueCategoryCandidate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? textKey = null,Object? text = freezed,Object? sign = freezed,Object? evasionRateStart = null,Object? evasionRateEnd = null,}) {
  return _then(_PhysiqueCategoryCandidate(
textKey: null == textKey ? _self.textKey : textKey // ignore: cast_nullable_to_non_nullable
as String,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,sign: freezed == sign ? _self.sign : sign // ignore: cast_nullable_to_non_nullable
as EvasionRateSign?,evasionRateStart: null == evasionRateStart ? _self.evasionRateStart : evasionRateStart // ignore: cast_nullable_to_non_nullable
as int,evasionRateEnd: null == evasionRateEnd ? _self.evasionRateEnd : evasionRateEnd // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
