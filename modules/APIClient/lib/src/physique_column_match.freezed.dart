// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'physique_column_match.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PhysiqueColumnMatch {

 String get level; String get anntenaCategory; int get lineOffset; int get columnIndex;
/// Create a copy of PhysiqueColumnMatch
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhysiqueColumnMatchCopyWith<PhysiqueColumnMatch> get copyWith => _$PhysiqueColumnMatchCopyWithImpl<PhysiqueColumnMatch>(this as PhysiqueColumnMatch, _$identity);

  /// Serializes this PhysiqueColumnMatch to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhysiqueColumnMatch&&(identical(other.level, level) || other.level == level)&&(identical(other.anntenaCategory, anntenaCategory) || other.anntenaCategory == anntenaCategory)&&(identical(other.lineOffset, lineOffset) || other.lineOffset == lineOffset)&&(identical(other.columnIndex, columnIndex) || other.columnIndex == columnIndex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,level,anntenaCategory,lineOffset,columnIndex);

@override
String toString() {
  return 'PhysiqueColumnMatch(level: $level, anntenaCategory: $anntenaCategory, lineOffset: $lineOffset, columnIndex: $columnIndex)';
}


}

/// @nodoc
abstract mixin class $PhysiqueColumnMatchCopyWith<$Res>  {
  factory $PhysiqueColumnMatchCopyWith(PhysiqueColumnMatch value, $Res Function(PhysiqueColumnMatch) _then) = _$PhysiqueColumnMatchCopyWithImpl;
@useResult
$Res call({
 String level, String anntenaCategory, int lineOffset, int columnIndex
});




}
/// @nodoc
class _$PhysiqueColumnMatchCopyWithImpl<$Res>
    implements $PhysiqueColumnMatchCopyWith<$Res> {
  _$PhysiqueColumnMatchCopyWithImpl(this._self, this._then);

  final PhysiqueColumnMatch _self;
  final $Res Function(PhysiqueColumnMatch) _then;

/// Create a copy of PhysiqueColumnMatch
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? level = null,Object? anntenaCategory = null,Object? lineOffset = null,Object? columnIndex = null,}) {
  return _then(_self.copyWith(
level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,anntenaCategory: null == anntenaCategory ? _self.anntenaCategory : anntenaCategory // ignore: cast_nullable_to_non_nullable
as String,lineOffset: null == lineOffset ? _self.lineOffset : lineOffset // ignore: cast_nullable_to_non_nullable
as int,columnIndex: null == columnIndex ? _self.columnIndex : columnIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PhysiqueColumnMatch].
extension PhysiqueColumnMatchPatterns on PhysiqueColumnMatch {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhysiqueColumnMatch value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhysiqueColumnMatch() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhysiqueColumnMatch value)  $default,){
final _that = this;
switch (_that) {
case _PhysiqueColumnMatch():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhysiqueColumnMatch value)?  $default,){
final _that = this;
switch (_that) {
case _PhysiqueColumnMatch() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String level,  String anntenaCategory,  int lineOffset,  int columnIndex)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhysiqueColumnMatch() when $default != null:
return $default(_that.level,_that.anntenaCategory,_that.lineOffset,_that.columnIndex);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String level,  String anntenaCategory,  int lineOffset,  int columnIndex)  $default,) {final _that = this;
switch (_that) {
case _PhysiqueColumnMatch():
return $default(_that.level,_that.anntenaCategory,_that.lineOffset,_that.columnIndex);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String level,  String anntenaCategory,  int lineOffset,  int columnIndex)?  $default,) {final _that = this;
switch (_that) {
case _PhysiqueColumnMatch() when $default != null:
return $default(_that.level,_that.anntenaCategory,_that.lineOffset,_that.columnIndex);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PhysiqueColumnMatch implements PhysiqueColumnMatch {
  const _PhysiqueColumnMatch({required this.level, required this.anntenaCategory, required this.lineOffset, required this.columnIndex});
  factory _PhysiqueColumnMatch.fromJson(Map<String, dynamic> json) => _$PhysiqueColumnMatchFromJson(json);

@override final  String level;
@override final  String anntenaCategory;
@override final  int lineOffset;
@override final  int columnIndex;

/// Create a copy of PhysiqueColumnMatch
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhysiqueColumnMatchCopyWith<_PhysiqueColumnMatch> get copyWith => __$PhysiqueColumnMatchCopyWithImpl<_PhysiqueColumnMatch>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PhysiqueColumnMatchToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhysiqueColumnMatch&&(identical(other.level, level) || other.level == level)&&(identical(other.anntenaCategory, anntenaCategory) || other.anntenaCategory == anntenaCategory)&&(identical(other.lineOffset, lineOffset) || other.lineOffset == lineOffset)&&(identical(other.columnIndex, columnIndex) || other.columnIndex == columnIndex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,level,anntenaCategory,lineOffset,columnIndex);

@override
String toString() {
  return 'PhysiqueColumnMatch(level: $level, anntenaCategory: $anntenaCategory, lineOffset: $lineOffset, columnIndex: $columnIndex)';
}


}

/// @nodoc
abstract mixin class _$PhysiqueColumnMatchCopyWith<$Res> implements $PhysiqueColumnMatchCopyWith<$Res> {
  factory _$PhysiqueColumnMatchCopyWith(_PhysiqueColumnMatch value, $Res Function(_PhysiqueColumnMatch) _then) = __$PhysiqueColumnMatchCopyWithImpl;
@override @useResult
$Res call({
 String level, String anntenaCategory, int lineOffset, int columnIndex
});




}
/// @nodoc
class __$PhysiqueColumnMatchCopyWithImpl<$Res>
    implements _$PhysiqueColumnMatchCopyWith<$Res> {
  __$PhysiqueColumnMatchCopyWithImpl(this._self, this._then);

  final _PhysiqueColumnMatch _self;
  final $Res Function(_PhysiqueColumnMatch) _then;

/// Create a copy of PhysiqueColumnMatch
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? level = null,Object? anntenaCategory = null,Object? lineOffset = null,Object? columnIndex = null,}) {
  return _then(_PhysiqueColumnMatch(
level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,anntenaCategory: null == anntenaCategory ? _self.anntenaCategory : anntenaCategory // ignore: cast_nullable_to_non_nullable
as String,lineOffset: null == lineOffset ? _self.lineOffset : lineOffset // ignore: cast_nullable_to_non_nullable
as int,columnIndex: null == columnIndex ? _self.columnIndex : columnIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
