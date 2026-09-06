// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'physique_evasion_rate_category_row.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PhysiqueEvasionRateCategoryRow {

 String get id; int get evasionRateStart; int get evasionRateEnd; int get columnIndex; String get textKey; EvasionRateSign? get sign;
/// Create a copy of PhysiqueEvasionRateCategoryRow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhysiqueEvasionRateCategoryRowCopyWith<PhysiqueEvasionRateCategoryRow> get copyWith => _$PhysiqueEvasionRateCategoryRowCopyWithImpl<PhysiqueEvasionRateCategoryRow>(this as PhysiqueEvasionRateCategoryRow, _$identity);

  /// Serializes this PhysiqueEvasionRateCategoryRow to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhysiqueEvasionRateCategoryRow&&(identical(other.id, id) || other.id == id)&&(identical(other.evasionRateStart, evasionRateStart) || other.evasionRateStart == evasionRateStart)&&(identical(other.evasionRateEnd, evasionRateEnd) || other.evasionRateEnd == evasionRateEnd)&&(identical(other.columnIndex, columnIndex) || other.columnIndex == columnIndex)&&(identical(other.textKey, textKey) || other.textKey == textKey)&&(identical(other.sign, sign) || other.sign == sign));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,evasionRateStart,evasionRateEnd,columnIndex,textKey,sign);

@override
String toString() {
  return 'PhysiqueEvasionRateCategoryRow(id: $id, evasionRateStart: $evasionRateStart, evasionRateEnd: $evasionRateEnd, columnIndex: $columnIndex, textKey: $textKey, sign: $sign)';
}


}

/// @nodoc
abstract mixin class $PhysiqueEvasionRateCategoryRowCopyWith<$Res>  {
  factory $PhysiqueEvasionRateCategoryRowCopyWith(PhysiqueEvasionRateCategoryRow value, $Res Function(PhysiqueEvasionRateCategoryRow) _then) = _$PhysiqueEvasionRateCategoryRowCopyWithImpl;
@useResult
$Res call({
 String id, int evasionRateStart, int evasionRateEnd, int columnIndex, String textKey, EvasionRateSign? sign
});




}
/// @nodoc
class _$PhysiqueEvasionRateCategoryRowCopyWithImpl<$Res>
    implements $PhysiqueEvasionRateCategoryRowCopyWith<$Res> {
  _$PhysiqueEvasionRateCategoryRowCopyWithImpl(this._self, this._then);

  final PhysiqueEvasionRateCategoryRow _self;
  final $Res Function(PhysiqueEvasionRateCategoryRow) _then;

/// Create a copy of PhysiqueEvasionRateCategoryRow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? evasionRateStart = null,Object? evasionRateEnd = null,Object? columnIndex = null,Object? textKey = null,Object? sign = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,evasionRateStart: null == evasionRateStart ? _self.evasionRateStart : evasionRateStart // ignore: cast_nullable_to_non_nullable
as int,evasionRateEnd: null == evasionRateEnd ? _self.evasionRateEnd : evasionRateEnd // ignore: cast_nullable_to_non_nullable
as int,columnIndex: null == columnIndex ? _self.columnIndex : columnIndex // ignore: cast_nullable_to_non_nullable
as int,textKey: null == textKey ? _self.textKey : textKey // ignore: cast_nullable_to_non_nullable
as String,sign: freezed == sign ? _self.sign : sign // ignore: cast_nullable_to_non_nullable
as EvasionRateSign?,
  ));
}

}


/// Adds pattern-matching-related methods to [PhysiqueEvasionRateCategoryRow].
extension PhysiqueEvasionRateCategoryRowPatterns on PhysiqueEvasionRateCategoryRow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhysiqueEvasionRateCategoryRow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhysiqueEvasionRateCategoryRow() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhysiqueEvasionRateCategoryRow value)  $default,){
final _that = this;
switch (_that) {
case _PhysiqueEvasionRateCategoryRow():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhysiqueEvasionRateCategoryRow value)?  $default,){
final _that = this;
switch (_that) {
case _PhysiqueEvasionRateCategoryRow() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int evasionRateStart,  int evasionRateEnd,  int columnIndex,  String textKey,  EvasionRateSign? sign)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhysiqueEvasionRateCategoryRow() when $default != null:
return $default(_that.id,_that.evasionRateStart,_that.evasionRateEnd,_that.columnIndex,_that.textKey,_that.sign);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int evasionRateStart,  int evasionRateEnd,  int columnIndex,  String textKey,  EvasionRateSign? sign)  $default,) {final _that = this;
switch (_that) {
case _PhysiqueEvasionRateCategoryRow():
return $default(_that.id,_that.evasionRateStart,_that.evasionRateEnd,_that.columnIndex,_that.textKey,_that.sign);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int evasionRateStart,  int evasionRateEnd,  int columnIndex,  String textKey,  EvasionRateSign? sign)?  $default,) {final _that = this;
switch (_that) {
case _PhysiqueEvasionRateCategoryRow() when $default != null:
return $default(_that.id,_that.evasionRateStart,_that.evasionRateEnd,_that.columnIndex,_that.textKey,_that.sign);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PhysiqueEvasionRateCategoryRow implements PhysiqueEvasionRateCategoryRow {
  const _PhysiqueEvasionRateCategoryRow({required this.id, required this.evasionRateStart, required this.evasionRateEnd, required this.columnIndex, required this.textKey, this.sign});
  factory _PhysiqueEvasionRateCategoryRow.fromJson(Map<String, dynamic> json) => _$PhysiqueEvasionRateCategoryRowFromJson(json);

@override final  String id;
@override final  int evasionRateStart;
@override final  int evasionRateEnd;
@override final  int columnIndex;
@override final  String textKey;
@override final  EvasionRateSign? sign;

/// Create a copy of PhysiqueEvasionRateCategoryRow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhysiqueEvasionRateCategoryRowCopyWith<_PhysiqueEvasionRateCategoryRow> get copyWith => __$PhysiqueEvasionRateCategoryRowCopyWithImpl<_PhysiqueEvasionRateCategoryRow>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PhysiqueEvasionRateCategoryRowToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhysiqueEvasionRateCategoryRow&&(identical(other.id, id) || other.id == id)&&(identical(other.evasionRateStart, evasionRateStart) || other.evasionRateStart == evasionRateStart)&&(identical(other.evasionRateEnd, evasionRateEnd) || other.evasionRateEnd == evasionRateEnd)&&(identical(other.columnIndex, columnIndex) || other.columnIndex == columnIndex)&&(identical(other.textKey, textKey) || other.textKey == textKey)&&(identical(other.sign, sign) || other.sign == sign));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,evasionRateStart,evasionRateEnd,columnIndex,textKey,sign);

@override
String toString() {
  return 'PhysiqueEvasionRateCategoryRow(id: $id, evasionRateStart: $evasionRateStart, evasionRateEnd: $evasionRateEnd, columnIndex: $columnIndex, textKey: $textKey, sign: $sign)';
}


}

/// @nodoc
abstract mixin class _$PhysiqueEvasionRateCategoryRowCopyWith<$Res> implements $PhysiqueEvasionRateCategoryRowCopyWith<$Res> {
  factory _$PhysiqueEvasionRateCategoryRowCopyWith(_PhysiqueEvasionRateCategoryRow value, $Res Function(_PhysiqueEvasionRateCategoryRow) _then) = __$PhysiqueEvasionRateCategoryRowCopyWithImpl;
@override @useResult
$Res call({
 String id, int evasionRateStart, int evasionRateEnd, int columnIndex, String textKey, EvasionRateSign? sign
});




}
/// @nodoc
class __$PhysiqueEvasionRateCategoryRowCopyWithImpl<$Res>
    implements _$PhysiqueEvasionRateCategoryRowCopyWith<$Res> {
  __$PhysiqueEvasionRateCategoryRowCopyWithImpl(this._self, this._then);

  final _PhysiqueEvasionRateCategoryRow _self;
  final $Res Function(_PhysiqueEvasionRateCategoryRow) _then;

/// Create a copy of PhysiqueEvasionRateCategoryRow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? evasionRateStart = null,Object? evasionRateEnd = null,Object? columnIndex = null,Object? textKey = null,Object? sign = freezed,}) {
  return _then(_PhysiqueEvasionRateCategoryRow(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,evasionRateStart: null == evasionRateStart ? _self.evasionRateStart : evasionRateStart // ignore: cast_nullable_to_non_nullable
as int,evasionRateEnd: null == evasionRateEnd ? _self.evasionRateEnd : evasionRateEnd // ignore: cast_nullable_to_non_nullable
as int,columnIndex: null == columnIndex ? _self.columnIndex : columnIndex // ignore: cast_nullable_to_non_nullable
as int,textKey: null == textKey ? _self.textKey : textKey // ignore: cast_nullable_to_non_nullable
as String,sign: freezed == sign ? _self.sign : sign // ignore: cast_nullable_to_non_nullable
as EvasionRateSign?,
  ));
}


}

// dart format on
