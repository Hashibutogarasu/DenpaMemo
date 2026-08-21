// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'import_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ImportResult {

 List<DenpaMen> get added; List<DenpaMen> get merged; List<DenpaMen> get orphaned; List<DenpaMenEntryParseError> get failed;
/// Create a copy of ImportResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImportResultCopyWith<ImportResult> get copyWith => _$ImportResultCopyWithImpl<ImportResult>(this as ImportResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImportResult&&const DeepCollectionEquality().equals(other.added, added)&&const DeepCollectionEquality().equals(other.merged, merged)&&const DeepCollectionEquality().equals(other.orphaned, orphaned)&&const DeepCollectionEquality().equals(other.failed, failed));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(added),const DeepCollectionEquality().hash(merged),const DeepCollectionEquality().hash(orphaned),const DeepCollectionEquality().hash(failed));

@override
String toString() {
  return 'ImportResult(added: $added, merged: $merged, orphaned: $orphaned, failed: $failed)';
}


}

/// @nodoc
abstract mixin class $ImportResultCopyWith<$Res>  {
  factory $ImportResultCopyWith(ImportResult value, $Res Function(ImportResult) _then) = _$ImportResultCopyWithImpl;
@useResult
$Res call({
 List<DenpaMen> added, List<DenpaMen> merged, List<DenpaMen> orphaned, List<DenpaMenEntryParseError> failed
});




}
/// @nodoc
class _$ImportResultCopyWithImpl<$Res>
    implements $ImportResultCopyWith<$Res> {
  _$ImportResultCopyWithImpl(this._self, this._then);

  final ImportResult _self;
  final $Res Function(ImportResult) _then;

/// Create a copy of ImportResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? added = null,Object? merged = null,Object? orphaned = null,Object? failed = null,}) {
  return _then(_self.copyWith(
added: null == added ? _self.added : added // ignore: cast_nullable_to_non_nullable
as List<DenpaMen>,merged: null == merged ? _self.merged : merged // ignore: cast_nullable_to_non_nullable
as List<DenpaMen>,orphaned: null == orphaned ? _self.orphaned : orphaned // ignore: cast_nullable_to_non_nullable
as List<DenpaMen>,failed: null == failed ? _self.failed : failed // ignore: cast_nullable_to_non_nullable
as List<DenpaMenEntryParseError>,
  ));
}

}


/// Adds pattern-matching-related methods to [ImportResult].
extension ImportResultPatterns on ImportResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ImportResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ImportResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ImportResult value)  $default,){
final _that = this;
switch (_that) {
case _ImportResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ImportResult value)?  $default,){
final _that = this;
switch (_that) {
case _ImportResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<DenpaMen> added,  List<DenpaMen> merged,  List<DenpaMen> orphaned,  List<DenpaMenEntryParseError> failed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImportResult() when $default != null:
return $default(_that.added,_that.merged,_that.orphaned,_that.failed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<DenpaMen> added,  List<DenpaMen> merged,  List<DenpaMen> orphaned,  List<DenpaMenEntryParseError> failed)  $default,) {final _that = this;
switch (_that) {
case _ImportResult():
return $default(_that.added,_that.merged,_that.orphaned,_that.failed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<DenpaMen> added,  List<DenpaMen> merged,  List<DenpaMen> orphaned,  List<DenpaMenEntryParseError> failed)?  $default,) {final _that = this;
switch (_that) {
case _ImportResult() when $default != null:
return $default(_that.added,_that.merged,_that.orphaned,_that.failed);case _:
  return null;

}
}

}

/// @nodoc


class _ImportResult implements ImportResult {
  const _ImportResult({final  List<DenpaMen> added = const <DenpaMen>[], final  List<DenpaMen> merged = const <DenpaMen>[], final  List<DenpaMen> orphaned = const <DenpaMen>[], final  List<DenpaMenEntryParseError> failed = const <DenpaMenEntryParseError>[]}): _added = added,_merged = merged,_orphaned = orphaned,_failed = failed;
  

 final  List<DenpaMen> _added;
@override@JsonKey() List<DenpaMen> get added {
  if (_added is EqualUnmodifiableListView) return _added;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_added);
}

 final  List<DenpaMen> _merged;
@override@JsonKey() List<DenpaMen> get merged {
  if (_merged is EqualUnmodifiableListView) return _merged;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_merged);
}

 final  List<DenpaMen> _orphaned;
@override@JsonKey() List<DenpaMen> get orphaned {
  if (_orphaned is EqualUnmodifiableListView) return _orphaned;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_orphaned);
}

 final  List<DenpaMenEntryParseError> _failed;
@override@JsonKey() List<DenpaMenEntryParseError> get failed {
  if (_failed is EqualUnmodifiableListView) return _failed;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_failed);
}


/// Create a copy of ImportResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImportResultCopyWith<_ImportResult> get copyWith => __$ImportResultCopyWithImpl<_ImportResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImportResult&&const DeepCollectionEquality().equals(other._added, _added)&&const DeepCollectionEquality().equals(other._merged, _merged)&&const DeepCollectionEquality().equals(other._orphaned, _orphaned)&&const DeepCollectionEquality().equals(other._failed, _failed));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_added),const DeepCollectionEquality().hash(_merged),const DeepCollectionEquality().hash(_orphaned),const DeepCollectionEquality().hash(_failed));

@override
String toString() {
  return 'ImportResult(added: $added, merged: $merged, orphaned: $orphaned, failed: $failed)';
}


}

/// @nodoc
abstract mixin class _$ImportResultCopyWith<$Res> implements $ImportResultCopyWith<$Res> {
  factory _$ImportResultCopyWith(_ImportResult value, $Res Function(_ImportResult) _then) = __$ImportResultCopyWithImpl;
@override @useResult
$Res call({
 List<DenpaMen> added, List<DenpaMen> merged, List<DenpaMen> orphaned, List<DenpaMenEntryParseError> failed
});




}
/// @nodoc
class __$ImportResultCopyWithImpl<$Res>
    implements _$ImportResultCopyWith<$Res> {
  __$ImportResultCopyWithImpl(this._self, this._then);

  final _ImportResult _self;
  final $Res Function(_ImportResult) _then;

/// Create a copy of ImportResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? added = null,Object? merged = null,Object? orphaned = null,Object? failed = null,}) {
  return _then(_ImportResult(
added: null == added ? _self._added : added // ignore: cast_nullable_to_non_nullable
as List<DenpaMen>,merged: null == merged ? _self._merged : merged // ignore: cast_nullable_to_non_nullable
as List<DenpaMen>,orphaned: null == orphaned ? _self._orphaned : orphaned // ignore: cast_nullable_to_non_nullable
as List<DenpaMen>,failed: null == failed ? _self._failed : failed // ignore: cast_nullable_to_non_nullable
as List<DenpaMenEntryParseError>,
  ));
}


}

// dart format on
