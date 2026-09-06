// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'legend_cell.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LegendCell {

 String get categoryId; int get evasionRateStart; int get evasionRateEnd; int get columnIndex; String get textKey; String? get text; EvasionRateSign? get sign; List<int> get liveValues; bool get isMatch;
/// Create a copy of LegendCell
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LegendCellCopyWith<LegendCell> get copyWith => _$LegendCellCopyWithImpl<LegendCell>(this as LegendCell, _$identity);

  /// Serializes this LegendCell to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LegendCell&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.evasionRateStart, evasionRateStart) || other.evasionRateStart == evasionRateStart)&&(identical(other.evasionRateEnd, evasionRateEnd) || other.evasionRateEnd == evasionRateEnd)&&(identical(other.columnIndex, columnIndex) || other.columnIndex == columnIndex)&&(identical(other.textKey, textKey) || other.textKey == textKey)&&(identical(other.text, text) || other.text == text)&&(identical(other.sign, sign) || other.sign == sign)&&const DeepCollectionEquality().equals(other.liveValues, liveValues)&&(identical(other.isMatch, isMatch) || other.isMatch == isMatch));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,categoryId,evasionRateStart,evasionRateEnd,columnIndex,textKey,text,sign,const DeepCollectionEquality().hash(liveValues),isMatch);

@override
String toString() {
  return 'LegendCell(categoryId: $categoryId, evasionRateStart: $evasionRateStart, evasionRateEnd: $evasionRateEnd, columnIndex: $columnIndex, textKey: $textKey, text: $text, sign: $sign, liveValues: $liveValues, isMatch: $isMatch)';
}


}

/// @nodoc
abstract mixin class $LegendCellCopyWith<$Res>  {
  factory $LegendCellCopyWith(LegendCell value, $Res Function(LegendCell) _then) = _$LegendCellCopyWithImpl;
@useResult
$Res call({
 String categoryId, int evasionRateStart, int evasionRateEnd, int columnIndex, String textKey, String? text, EvasionRateSign? sign, List<int> liveValues, bool isMatch
});




}
/// @nodoc
class _$LegendCellCopyWithImpl<$Res>
    implements $LegendCellCopyWith<$Res> {
  _$LegendCellCopyWithImpl(this._self, this._then);

  final LegendCell _self;
  final $Res Function(LegendCell) _then;

/// Create a copy of LegendCell
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? categoryId = null,Object? evasionRateStart = null,Object? evasionRateEnd = null,Object? columnIndex = null,Object? textKey = null,Object? text = freezed,Object? sign = freezed,Object? liveValues = null,Object? isMatch = null,}) {
  return _then(_self.copyWith(
categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,evasionRateStart: null == evasionRateStart ? _self.evasionRateStart : evasionRateStart // ignore: cast_nullable_to_non_nullable
as int,evasionRateEnd: null == evasionRateEnd ? _self.evasionRateEnd : evasionRateEnd // ignore: cast_nullable_to_non_nullable
as int,columnIndex: null == columnIndex ? _self.columnIndex : columnIndex // ignore: cast_nullable_to_non_nullable
as int,textKey: null == textKey ? _self.textKey : textKey // ignore: cast_nullable_to_non_nullable
as String,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,sign: freezed == sign ? _self.sign : sign // ignore: cast_nullable_to_non_nullable
as EvasionRateSign?,liveValues: null == liveValues ? _self.liveValues : liveValues // ignore: cast_nullable_to_non_nullable
as List<int>,isMatch: null == isMatch ? _self.isMatch : isMatch // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [LegendCell].
extension LegendCellPatterns on LegendCell {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LegendCell value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LegendCell() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LegendCell value)  $default,){
final _that = this;
switch (_that) {
case _LegendCell():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LegendCell value)?  $default,){
final _that = this;
switch (_that) {
case _LegendCell() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String categoryId,  int evasionRateStart,  int evasionRateEnd,  int columnIndex,  String textKey,  String? text,  EvasionRateSign? sign,  List<int> liveValues,  bool isMatch)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LegendCell() when $default != null:
return $default(_that.categoryId,_that.evasionRateStart,_that.evasionRateEnd,_that.columnIndex,_that.textKey,_that.text,_that.sign,_that.liveValues,_that.isMatch);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String categoryId,  int evasionRateStart,  int evasionRateEnd,  int columnIndex,  String textKey,  String? text,  EvasionRateSign? sign,  List<int> liveValues,  bool isMatch)  $default,) {final _that = this;
switch (_that) {
case _LegendCell():
return $default(_that.categoryId,_that.evasionRateStart,_that.evasionRateEnd,_that.columnIndex,_that.textKey,_that.text,_that.sign,_that.liveValues,_that.isMatch);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String categoryId,  int evasionRateStart,  int evasionRateEnd,  int columnIndex,  String textKey,  String? text,  EvasionRateSign? sign,  List<int> liveValues,  bool isMatch)?  $default,) {final _that = this;
switch (_that) {
case _LegendCell() when $default != null:
return $default(_that.categoryId,_that.evasionRateStart,_that.evasionRateEnd,_that.columnIndex,_that.textKey,_that.text,_that.sign,_that.liveValues,_that.isMatch);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LegendCell implements LegendCell {
  const _LegendCell({required this.categoryId, required this.evasionRateStart, required this.evasionRateEnd, required this.columnIndex, required this.textKey, this.text, this.sign, required final  List<int> liveValues, required this.isMatch}): _liveValues = liveValues;
  factory _LegendCell.fromJson(Map<String, dynamic> json) => _$LegendCellFromJson(json);

@override final  String categoryId;
@override final  int evasionRateStart;
@override final  int evasionRateEnd;
@override final  int columnIndex;
@override final  String textKey;
@override final  String? text;
@override final  EvasionRateSign? sign;
 final  List<int> _liveValues;
@override List<int> get liveValues {
  if (_liveValues is EqualUnmodifiableListView) return _liveValues;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_liveValues);
}

@override final  bool isMatch;

/// Create a copy of LegendCell
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LegendCellCopyWith<_LegendCell> get copyWith => __$LegendCellCopyWithImpl<_LegendCell>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LegendCellToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LegendCell&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.evasionRateStart, evasionRateStart) || other.evasionRateStart == evasionRateStart)&&(identical(other.evasionRateEnd, evasionRateEnd) || other.evasionRateEnd == evasionRateEnd)&&(identical(other.columnIndex, columnIndex) || other.columnIndex == columnIndex)&&(identical(other.textKey, textKey) || other.textKey == textKey)&&(identical(other.text, text) || other.text == text)&&(identical(other.sign, sign) || other.sign == sign)&&const DeepCollectionEquality().equals(other._liveValues, _liveValues)&&(identical(other.isMatch, isMatch) || other.isMatch == isMatch));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,categoryId,evasionRateStart,evasionRateEnd,columnIndex,textKey,text,sign,const DeepCollectionEquality().hash(_liveValues),isMatch);

@override
String toString() {
  return 'LegendCell(categoryId: $categoryId, evasionRateStart: $evasionRateStart, evasionRateEnd: $evasionRateEnd, columnIndex: $columnIndex, textKey: $textKey, text: $text, sign: $sign, liveValues: $liveValues, isMatch: $isMatch)';
}


}

/// @nodoc
abstract mixin class _$LegendCellCopyWith<$Res> implements $LegendCellCopyWith<$Res> {
  factory _$LegendCellCopyWith(_LegendCell value, $Res Function(_LegendCell) _then) = __$LegendCellCopyWithImpl;
@override @useResult
$Res call({
 String categoryId, int evasionRateStart, int evasionRateEnd, int columnIndex, String textKey, String? text, EvasionRateSign? sign, List<int> liveValues, bool isMatch
});




}
/// @nodoc
class __$LegendCellCopyWithImpl<$Res>
    implements _$LegendCellCopyWith<$Res> {
  __$LegendCellCopyWithImpl(this._self, this._then);

  final _LegendCell _self;
  final $Res Function(_LegendCell) _then;

/// Create a copy of LegendCell
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? categoryId = null,Object? evasionRateStart = null,Object? evasionRateEnd = null,Object? columnIndex = null,Object? textKey = null,Object? text = freezed,Object? sign = freezed,Object? liveValues = null,Object? isMatch = null,}) {
  return _then(_LegendCell(
categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,evasionRateStart: null == evasionRateStart ? _self.evasionRateStart : evasionRateStart // ignore: cast_nullable_to_non_nullable
as int,evasionRateEnd: null == evasionRateEnd ? _self.evasionRateEnd : evasionRateEnd // ignore: cast_nullable_to_non_nullable
as int,columnIndex: null == columnIndex ? _self.columnIndex : columnIndex // ignore: cast_nullable_to_non_nullable
as int,textKey: null == textKey ? _self.textKey : textKey // ignore: cast_nullable_to_non_nullable
as String,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,sign: freezed == sign ? _self.sign : sign // ignore: cast_nullable_to_non_nullable
as EvasionRateSign?,liveValues: null == liveValues ? _self._liveValues : liveValues // ignore: cast_nullable_to_non_nullable
as List<int>,isMatch: null == isMatch ? _self.isMatch : isMatch // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
