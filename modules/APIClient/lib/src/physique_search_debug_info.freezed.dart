// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'physique_search_debug_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PhysiqueSearchDebugInfo {

 Map<String, dynamic> get query; List<dynamic> get primaryRows; List<dynamic> get targetRows; List<dynamic> get matches; List<dynamic> get categoryRows;
/// Create a copy of PhysiqueSearchDebugInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhysiqueSearchDebugInfoCopyWith<PhysiqueSearchDebugInfo> get copyWith => _$PhysiqueSearchDebugInfoCopyWithImpl<PhysiqueSearchDebugInfo>(this as PhysiqueSearchDebugInfo, _$identity);

  /// Serializes this PhysiqueSearchDebugInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhysiqueSearchDebugInfo&&const DeepCollectionEquality().equals(other.query, query)&&const DeepCollectionEquality().equals(other.primaryRows, primaryRows)&&const DeepCollectionEquality().equals(other.targetRows, targetRows)&&const DeepCollectionEquality().equals(other.matches, matches)&&const DeepCollectionEquality().equals(other.categoryRows, categoryRows));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(query),const DeepCollectionEquality().hash(primaryRows),const DeepCollectionEquality().hash(targetRows),const DeepCollectionEquality().hash(matches),const DeepCollectionEquality().hash(categoryRows));

@override
String toString() {
  return 'PhysiqueSearchDebugInfo(query: $query, primaryRows: $primaryRows, targetRows: $targetRows, matches: $matches, categoryRows: $categoryRows)';
}


}

/// @nodoc
abstract mixin class $PhysiqueSearchDebugInfoCopyWith<$Res>  {
  factory $PhysiqueSearchDebugInfoCopyWith(PhysiqueSearchDebugInfo value, $Res Function(PhysiqueSearchDebugInfo) _then) = _$PhysiqueSearchDebugInfoCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> query, List<dynamic> primaryRows, List<dynamic> targetRows, List<dynamic> matches, List<dynamic> categoryRows
});




}
/// @nodoc
class _$PhysiqueSearchDebugInfoCopyWithImpl<$Res>
    implements $PhysiqueSearchDebugInfoCopyWith<$Res> {
  _$PhysiqueSearchDebugInfoCopyWithImpl(this._self, this._then);

  final PhysiqueSearchDebugInfo _self;
  final $Res Function(PhysiqueSearchDebugInfo) _then;

/// Create a copy of PhysiqueSearchDebugInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? query = null,Object? primaryRows = null,Object? targetRows = null,Object? matches = null,Object? categoryRows = null,}) {
  return _then(_self.copyWith(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,primaryRows: null == primaryRows ? _self.primaryRows : primaryRows // ignore: cast_nullable_to_non_nullable
as List<dynamic>,targetRows: null == targetRows ? _self.targetRows : targetRows // ignore: cast_nullable_to_non_nullable
as List<dynamic>,matches: null == matches ? _self.matches : matches // ignore: cast_nullable_to_non_nullable
as List<dynamic>,categoryRows: null == categoryRows ? _self.categoryRows : categoryRows // ignore: cast_nullable_to_non_nullable
as List<dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [PhysiqueSearchDebugInfo].
extension PhysiqueSearchDebugInfoPatterns on PhysiqueSearchDebugInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhysiqueSearchDebugInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhysiqueSearchDebugInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhysiqueSearchDebugInfo value)  $default,){
final _that = this;
switch (_that) {
case _PhysiqueSearchDebugInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhysiqueSearchDebugInfo value)?  $default,){
final _that = this;
switch (_that) {
case _PhysiqueSearchDebugInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<String, dynamic> query,  List<dynamic> primaryRows,  List<dynamic> targetRows,  List<dynamic> matches,  List<dynamic> categoryRows)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhysiqueSearchDebugInfo() when $default != null:
return $default(_that.query,_that.primaryRows,_that.targetRows,_that.matches,_that.categoryRows);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<String, dynamic> query,  List<dynamic> primaryRows,  List<dynamic> targetRows,  List<dynamic> matches,  List<dynamic> categoryRows)  $default,) {final _that = this;
switch (_that) {
case _PhysiqueSearchDebugInfo():
return $default(_that.query,_that.primaryRows,_that.targetRows,_that.matches,_that.categoryRows);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<String, dynamic> query,  List<dynamic> primaryRows,  List<dynamic> targetRows,  List<dynamic> matches,  List<dynamic> categoryRows)?  $default,) {final _that = this;
switch (_that) {
case _PhysiqueSearchDebugInfo() when $default != null:
return $default(_that.query,_that.primaryRows,_that.targetRows,_that.matches,_that.categoryRows);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PhysiqueSearchDebugInfo implements PhysiqueSearchDebugInfo {
  const _PhysiqueSearchDebugInfo({required final  Map<String, dynamic> query, required final  List<dynamic> primaryRows, required final  List<dynamic> targetRows, required final  List<dynamic> matches, required final  List<dynamic> categoryRows}): _query = query,_primaryRows = primaryRows,_targetRows = targetRows,_matches = matches,_categoryRows = categoryRows;
  factory _PhysiqueSearchDebugInfo.fromJson(Map<String, dynamic> json) => _$PhysiqueSearchDebugInfoFromJson(json);

 final  Map<String, dynamic> _query;
@override Map<String, dynamic> get query {
  if (_query is EqualUnmodifiableMapView) return _query;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_query);
}

 final  List<dynamic> _primaryRows;
@override List<dynamic> get primaryRows {
  if (_primaryRows is EqualUnmodifiableListView) return _primaryRows;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_primaryRows);
}

 final  List<dynamic> _targetRows;
@override List<dynamic> get targetRows {
  if (_targetRows is EqualUnmodifiableListView) return _targetRows;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_targetRows);
}

 final  List<dynamic> _matches;
@override List<dynamic> get matches {
  if (_matches is EqualUnmodifiableListView) return _matches;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_matches);
}

 final  List<dynamic> _categoryRows;
@override List<dynamic> get categoryRows {
  if (_categoryRows is EqualUnmodifiableListView) return _categoryRows;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categoryRows);
}


/// Create a copy of PhysiqueSearchDebugInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhysiqueSearchDebugInfoCopyWith<_PhysiqueSearchDebugInfo> get copyWith => __$PhysiqueSearchDebugInfoCopyWithImpl<_PhysiqueSearchDebugInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PhysiqueSearchDebugInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhysiqueSearchDebugInfo&&const DeepCollectionEquality().equals(other._query, _query)&&const DeepCollectionEquality().equals(other._primaryRows, _primaryRows)&&const DeepCollectionEquality().equals(other._targetRows, _targetRows)&&const DeepCollectionEquality().equals(other._matches, _matches)&&const DeepCollectionEquality().equals(other._categoryRows, _categoryRows));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_query),const DeepCollectionEquality().hash(_primaryRows),const DeepCollectionEquality().hash(_targetRows),const DeepCollectionEquality().hash(_matches),const DeepCollectionEquality().hash(_categoryRows));

@override
String toString() {
  return 'PhysiqueSearchDebugInfo(query: $query, primaryRows: $primaryRows, targetRows: $targetRows, matches: $matches, categoryRows: $categoryRows)';
}


}

/// @nodoc
abstract mixin class _$PhysiqueSearchDebugInfoCopyWith<$Res> implements $PhysiqueSearchDebugInfoCopyWith<$Res> {
  factory _$PhysiqueSearchDebugInfoCopyWith(_PhysiqueSearchDebugInfo value, $Res Function(_PhysiqueSearchDebugInfo) _then) = __$PhysiqueSearchDebugInfoCopyWithImpl;
@override @useResult
$Res call({
 Map<String, dynamic> query, List<dynamic> primaryRows, List<dynamic> targetRows, List<dynamic> matches, List<dynamic> categoryRows
});




}
/// @nodoc
class __$PhysiqueSearchDebugInfoCopyWithImpl<$Res>
    implements _$PhysiqueSearchDebugInfoCopyWith<$Res> {
  __$PhysiqueSearchDebugInfoCopyWithImpl(this._self, this._then);

  final _PhysiqueSearchDebugInfo _self;
  final $Res Function(_PhysiqueSearchDebugInfo) _then;

/// Create a copy of PhysiqueSearchDebugInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? query = null,Object? primaryRows = null,Object? targetRows = null,Object? matches = null,Object? categoryRows = null,}) {
  return _then(_PhysiqueSearchDebugInfo(
query: null == query ? _self._query : query // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,primaryRows: null == primaryRows ? _self._primaryRows : primaryRows // ignore: cast_nullable_to_non_nullable
as List<dynamic>,targetRows: null == targetRows ? _self._targetRows : targetRows // ignore: cast_nullable_to_non_nullable
as List<dynamic>,matches: null == matches ? _self._matches : matches // ignore: cast_nullable_to_non_nullable
as List<dynamic>,categoryRows: null == categoryRows ? _self._categoryRows : categoryRows // ignore: cast_nullable_to_non_nullable
as List<dynamic>,
  ));
}


}

// dart format on
