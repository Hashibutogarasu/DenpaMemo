// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'physique_search_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PhysiqueSearchResult {

 List<PhysiqueColumnMatch> get matches; PhysiqueSearchDebugInfo? get info;
/// Create a copy of PhysiqueSearchResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhysiqueSearchResultCopyWith<PhysiqueSearchResult> get copyWith => _$PhysiqueSearchResultCopyWithImpl<PhysiqueSearchResult>(this as PhysiqueSearchResult, _$identity);

  /// Serializes this PhysiqueSearchResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhysiqueSearchResult&&const DeepCollectionEquality().equals(other.matches, matches)&&(identical(other.info, info) || other.info == info));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(matches),info);

@override
String toString() {
  return 'PhysiqueSearchResult(matches: $matches, info: $info)';
}


}

/// @nodoc
abstract mixin class $PhysiqueSearchResultCopyWith<$Res>  {
  factory $PhysiqueSearchResultCopyWith(PhysiqueSearchResult value, $Res Function(PhysiqueSearchResult) _then) = _$PhysiqueSearchResultCopyWithImpl;
@useResult
$Res call({
 List<PhysiqueColumnMatch> matches, PhysiqueSearchDebugInfo? info
});


$PhysiqueSearchDebugInfoCopyWith<$Res>? get info;

}
/// @nodoc
class _$PhysiqueSearchResultCopyWithImpl<$Res>
    implements $PhysiqueSearchResultCopyWith<$Res> {
  _$PhysiqueSearchResultCopyWithImpl(this._self, this._then);

  final PhysiqueSearchResult _self;
  final $Res Function(PhysiqueSearchResult) _then;

/// Create a copy of PhysiqueSearchResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? matches = null,Object? info = freezed,}) {
  return _then(_self.copyWith(
matches: null == matches ? _self.matches : matches // ignore: cast_nullable_to_non_nullable
as List<PhysiqueColumnMatch>,info: freezed == info ? _self.info : info // ignore: cast_nullable_to_non_nullable
as PhysiqueSearchDebugInfo?,
  ));
}
/// Create a copy of PhysiqueSearchResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PhysiqueSearchDebugInfoCopyWith<$Res>? get info {
    if (_self.info == null) {
    return null;
  }

  return $PhysiqueSearchDebugInfoCopyWith<$Res>(_self.info!, (value) {
    return _then(_self.copyWith(info: value));
  });
}
}


/// Adds pattern-matching-related methods to [PhysiqueSearchResult].
extension PhysiqueSearchResultPatterns on PhysiqueSearchResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhysiqueSearchResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhysiqueSearchResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhysiqueSearchResult value)  $default,){
final _that = this;
switch (_that) {
case _PhysiqueSearchResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhysiqueSearchResult value)?  $default,){
final _that = this;
switch (_that) {
case _PhysiqueSearchResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<PhysiqueColumnMatch> matches,  PhysiqueSearchDebugInfo? info)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhysiqueSearchResult() when $default != null:
return $default(_that.matches,_that.info);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<PhysiqueColumnMatch> matches,  PhysiqueSearchDebugInfo? info)  $default,) {final _that = this;
switch (_that) {
case _PhysiqueSearchResult():
return $default(_that.matches,_that.info);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<PhysiqueColumnMatch> matches,  PhysiqueSearchDebugInfo? info)?  $default,) {final _that = this;
switch (_that) {
case _PhysiqueSearchResult() when $default != null:
return $default(_that.matches,_that.info);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PhysiqueSearchResult implements PhysiqueSearchResult {
  const _PhysiqueSearchResult({required final  List<PhysiqueColumnMatch> matches, this.info}): _matches = matches;
  factory _PhysiqueSearchResult.fromJson(Map<String, dynamic> json) => _$PhysiqueSearchResultFromJson(json);

 final  List<PhysiqueColumnMatch> _matches;
@override List<PhysiqueColumnMatch> get matches {
  if (_matches is EqualUnmodifiableListView) return _matches;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_matches);
}

@override final  PhysiqueSearchDebugInfo? info;

/// Create a copy of PhysiqueSearchResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhysiqueSearchResultCopyWith<_PhysiqueSearchResult> get copyWith => __$PhysiqueSearchResultCopyWithImpl<_PhysiqueSearchResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PhysiqueSearchResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhysiqueSearchResult&&const DeepCollectionEquality().equals(other._matches, _matches)&&(identical(other.info, info) || other.info == info));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_matches),info);

@override
String toString() {
  return 'PhysiqueSearchResult(matches: $matches, info: $info)';
}


}

/// @nodoc
abstract mixin class _$PhysiqueSearchResultCopyWith<$Res> implements $PhysiqueSearchResultCopyWith<$Res> {
  factory _$PhysiqueSearchResultCopyWith(_PhysiqueSearchResult value, $Res Function(_PhysiqueSearchResult) _then) = __$PhysiqueSearchResultCopyWithImpl;
@override @useResult
$Res call({
 List<PhysiqueColumnMatch> matches, PhysiqueSearchDebugInfo? info
});


@override $PhysiqueSearchDebugInfoCopyWith<$Res>? get info;

}
/// @nodoc
class __$PhysiqueSearchResultCopyWithImpl<$Res>
    implements _$PhysiqueSearchResultCopyWith<$Res> {
  __$PhysiqueSearchResultCopyWithImpl(this._self, this._then);

  final _PhysiqueSearchResult _self;
  final $Res Function(_PhysiqueSearchResult) _then;

/// Create a copy of PhysiqueSearchResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? matches = null,Object? info = freezed,}) {
  return _then(_PhysiqueSearchResult(
matches: null == matches ? _self._matches : matches // ignore: cast_nullable_to_non_nullable
as List<PhysiqueColumnMatch>,info: freezed == info ? _self.info : info // ignore: cast_nullable_to_non_nullable
as PhysiqueSearchDebugInfo?,
  ));
}

/// Create a copy of PhysiqueSearchResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PhysiqueSearchDebugInfoCopyWith<$Res>? get info {
    if (_self.info == null) {
    return null;
  }

  return $PhysiqueSearchDebugInfoCopyWith<$Res>(_self.info!, (value) {
    return _then(_self.copyWith(info: value));
  });
}
}

// dart format on
