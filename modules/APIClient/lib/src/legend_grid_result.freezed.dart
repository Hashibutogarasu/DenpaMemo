// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'legend_grid_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LegendGridResult {

 String get level; String get anntenaCategory; List<LegendCell> get legendCells; List<HpCell> get hpCells;
/// Create a copy of LegendGridResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LegendGridResultCopyWith<LegendGridResult> get copyWith => _$LegendGridResultCopyWithImpl<LegendGridResult>(this as LegendGridResult, _$identity);

  /// Serializes this LegendGridResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LegendGridResult&&(identical(other.level, level) || other.level == level)&&(identical(other.anntenaCategory, anntenaCategory) || other.anntenaCategory == anntenaCategory)&&const DeepCollectionEquality().equals(other.legendCells, legendCells)&&const DeepCollectionEquality().equals(other.hpCells, hpCells));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,level,anntenaCategory,const DeepCollectionEquality().hash(legendCells),const DeepCollectionEquality().hash(hpCells));

@override
String toString() {
  return 'LegendGridResult(level: $level, anntenaCategory: $anntenaCategory, legendCells: $legendCells, hpCells: $hpCells)';
}


}

/// @nodoc
abstract mixin class $LegendGridResultCopyWith<$Res>  {
  factory $LegendGridResultCopyWith(LegendGridResult value, $Res Function(LegendGridResult) _then) = _$LegendGridResultCopyWithImpl;
@useResult
$Res call({
 String level, String anntenaCategory, List<LegendCell> legendCells, List<HpCell> hpCells
});




}
/// @nodoc
class _$LegendGridResultCopyWithImpl<$Res>
    implements $LegendGridResultCopyWith<$Res> {
  _$LegendGridResultCopyWithImpl(this._self, this._then);

  final LegendGridResult _self;
  final $Res Function(LegendGridResult) _then;

/// Create a copy of LegendGridResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? level = null,Object? anntenaCategory = null,Object? legendCells = null,Object? hpCells = null,}) {
  return _then(_self.copyWith(
level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,anntenaCategory: null == anntenaCategory ? _self.anntenaCategory : anntenaCategory // ignore: cast_nullable_to_non_nullable
as String,legendCells: null == legendCells ? _self.legendCells : legendCells // ignore: cast_nullable_to_non_nullable
as List<LegendCell>,hpCells: null == hpCells ? _self.hpCells : hpCells // ignore: cast_nullable_to_non_nullable
as List<HpCell>,
  ));
}

}


/// Adds pattern-matching-related methods to [LegendGridResult].
extension LegendGridResultPatterns on LegendGridResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LegendGridResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LegendGridResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LegendGridResult value)  $default,){
final _that = this;
switch (_that) {
case _LegendGridResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LegendGridResult value)?  $default,){
final _that = this;
switch (_that) {
case _LegendGridResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String level,  String anntenaCategory,  List<LegendCell> legendCells,  List<HpCell> hpCells)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LegendGridResult() when $default != null:
return $default(_that.level,_that.anntenaCategory,_that.legendCells,_that.hpCells);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String level,  String anntenaCategory,  List<LegendCell> legendCells,  List<HpCell> hpCells)  $default,) {final _that = this;
switch (_that) {
case _LegendGridResult():
return $default(_that.level,_that.anntenaCategory,_that.legendCells,_that.hpCells);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String level,  String anntenaCategory,  List<LegendCell> legendCells,  List<HpCell> hpCells)?  $default,) {final _that = this;
switch (_that) {
case _LegendGridResult() when $default != null:
return $default(_that.level,_that.anntenaCategory,_that.legendCells,_that.hpCells);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LegendGridResult implements LegendGridResult {
  const _LegendGridResult({required this.level, required this.anntenaCategory, required final  List<LegendCell> legendCells, required final  List<HpCell> hpCells}): _legendCells = legendCells,_hpCells = hpCells;
  factory _LegendGridResult.fromJson(Map<String, dynamic> json) => _$LegendGridResultFromJson(json);

@override final  String level;
@override final  String anntenaCategory;
 final  List<LegendCell> _legendCells;
@override List<LegendCell> get legendCells {
  if (_legendCells is EqualUnmodifiableListView) return _legendCells;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_legendCells);
}

 final  List<HpCell> _hpCells;
@override List<HpCell> get hpCells {
  if (_hpCells is EqualUnmodifiableListView) return _hpCells;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_hpCells);
}


/// Create a copy of LegendGridResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LegendGridResultCopyWith<_LegendGridResult> get copyWith => __$LegendGridResultCopyWithImpl<_LegendGridResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LegendGridResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LegendGridResult&&(identical(other.level, level) || other.level == level)&&(identical(other.anntenaCategory, anntenaCategory) || other.anntenaCategory == anntenaCategory)&&const DeepCollectionEquality().equals(other._legendCells, _legendCells)&&const DeepCollectionEquality().equals(other._hpCells, _hpCells));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,level,anntenaCategory,const DeepCollectionEquality().hash(_legendCells),const DeepCollectionEquality().hash(_hpCells));

@override
String toString() {
  return 'LegendGridResult(level: $level, anntenaCategory: $anntenaCategory, legendCells: $legendCells, hpCells: $hpCells)';
}


}

/// @nodoc
abstract mixin class _$LegendGridResultCopyWith<$Res> implements $LegendGridResultCopyWith<$Res> {
  factory _$LegendGridResultCopyWith(_LegendGridResult value, $Res Function(_LegendGridResult) _then) = __$LegendGridResultCopyWithImpl;
@override @useResult
$Res call({
 String level, String anntenaCategory, List<LegendCell> legendCells, List<HpCell> hpCells
});




}
/// @nodoc
class __$LegendGridResultCopyWithImpl<$Res>
    implements _$LegendGridResultCopyWith<$Res> {
  __$LegendGridResultCopyWithImpl(this._self, this._then);

  final _LegendGridResult _self;
  final $Res Function(_LegendGridResult) _then;

/// Create a copy of LegendGridResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? level = null,Object? anntenaCategory = null,Object? legendCells = null,Object? hpCells = null,}) {
  return _then(_LegendGridResult(
level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,anntenaCategory: null == anntenaCategory ? _self.anntenaCategory : anntenaCategory // ignore: cast_nullable_to_non_nullable
as String,legendCells: null == legendCells ? _self._legendCells : legendCells // ignore: cast_nullable_to_non_nullable
as List<LegendCell>,hpCells: null == hpCells ? _self._hpCells : hpCells // ignore: cast_nullable_to_non_nullable
as List<HpCell>,
  ));
}


}

// dart format on
