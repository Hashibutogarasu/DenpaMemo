// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hp_cell.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HpCell {

 int get columnIndex; int get lineOffset; num get value; bool get isMatch;
/// Create a copy of HpCell
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HpCellCopyWith<HpCell> get copyWith => _$HpCellCopyWithImpl<HpCell>(this as HpCell, _$identity);

  /// Serializes this HpCell to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HpCell&&(identical(other.columnIndex, columnIndex) || other.columnIndex == columnIndex)&&(identical(other.lineOffset, lineOffset) || other.lineOffset == lineOffset)&&(identical(other.value, value) || other.value == value)&&(identical(other.isMatch, isMatch) || other.isMatch == isMatch));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,columnIndex,lineOffset,value,isMatch);

@override
String toString() {
  return 'HpCell(columnIndex: $columnIndex, lineOffset: $lineOffset, value: $value, isMatch: $isMatch)';
}


}

/// @nodoc
abstract mixin class $HpCellCopyWith<$Res>  {
  factory $HpCellCopyWith(HpCell value, $Res Function(HpCell) _then) = _$HpCellCopyWithImpl;
@useResult
$Res call({
 int columnIndex, int lineOffset, num value, bool isMatch
});




}
/// @nodoc
class _$HpCellCopyWithImpl<$Res>
    implements $HpCellCopyWith<$Res> {
  _$HpCellCopyWithImpl(this._self, this._then);

  final HpCell _self;
  final $Res Function(HpCell) _then;

/// Create a copy of HpCell
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? columnIndex = null,Object? lineOffset = null,Object? value = null,Object? isMatch = null,}) {
  return _then(_self.copyWith(
columnIndex: null == columnIndex ? _self.columnIndex : columnIndex // ignore: cast_nullable_to_non_nullable
as int,lineOffset: null == lineOffset ? _self.lineOffset : lineOffset // ignore: cast_nullable_to_non_nullable
as int,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as num,isMatch: null == isMatch ? _self.isMatch : isMatch // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [HpCell].
extension HpCellPatterns on HpCell {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HpCell value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HpCell() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HpCell value)  $default,){
final _that = this;
switch (_that) {
case _HpCell():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HpCell value)?  $default,){
final _that = this;
switch (_that) {
case _HpCell() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int columnIndex,  int lineOffset,  num value,  bool isMatch)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HpCell() when $default != null:
return $default(_that.columnIndex,_that.lineOffset,_that.value,_that.isMatch);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int columnIndex,  int lineOffset,  num value,  bool isMatch)  $default,) {final _that = this;
switch (_that) {
case _HpCell():
return $default(_that.columnIndex,_that.lineOffset,_that.value,_that.isMatch);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int columnIndex,  int lineOffset,  num value,  bool isMatch)?  $default,) {final _that = this;
switch (_that) {
case _HpCell() when $default != null:
return $default(_that.columnIndex,_that.lineOffset,_that.value,_that.isMatch);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HpCell implements HpCell {
  const _HpCell({required this.columnIndex, required this.lineOffset, required this.value, required this.isMatch});
  factory _HpCell.fromJson(Map<String, dynamic> json) => _$HpCellFromJson(json);

@override final  int columnIndex;
@override final  int lineOffset;
@override final  num value;
@override final  bool isMatch;

/// Create a copy of HpCell
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HpCellCopyWith<_HpCell> get copyWith => __$HpCellCopyWithImpl<_HpCell>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HpCellToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HpCell&&(identical(other.columnIndex, columnIndex) || other.columnIndex == columnIndex)&&(identical(other.lineOffset, lineOffset) || other.lineOffset == lineOffset)&&(identical(other.value, value) || other.value == value)&&(identical(other.isMatch, isMatch) || other.isMatch == isMatch));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,columnIndex,lineOffset,value,isMatch);

@override
String toString() {
  return 'HpCell(columnIndex: $columnIndex, lineOffset: $lineOffset, value: $value, isMatch: $isMatch)';
}


}

/// @nodoc
abstract mixin class _$HpCellCopyWith<$Res> implements $HpCellCopyWith<$Res> {
  factory _$HpCellCopyWith(_HpCell value, $Res Function(_HpCell) _then) = __$HpCellCopyWithImpl;
@override @useResult
$Res call({
 int columnIndex, int lineOffset, num value, bool isMatch
});




}
/// @nodoc
class __$HpCellCopyWithImpl<$Res>
    implements _$HpCellCopyWith<$Res> {
  __$HpCellCopyWithImpl(this._self, this._then);

  final _HpCell _self;
  final $Res Function(_HpCell) _then;

/// Create a copy of HpCell
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? columnIndex = null,Object? lineOffset = null,Object? value = null,Object? isMatch = null,}) {
  return _then(_HpCell(
columnIndex: null == columnIndex ? _self.columnIndex : columnIndex // ignore: cast_nullable_to_non_nullable
as int,lineOffset: null == lineOffset ? _self.lineOffset : lineOffset // ignore: cast_nullable_to_non_nullable
as int,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as num,isMatch: null == isMatch ? _self.isMatch : isMatch // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
