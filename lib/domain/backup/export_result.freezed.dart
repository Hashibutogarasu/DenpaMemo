// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'export_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExportResult {

 List<DenpaMen> get exported; List<DenpaMen> get orphaned;
/// Create a copy of ExportResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExportResultCopyWith<ExportResult> get copyWith => _$ExportResultCopyWithImpl<ExportResult>(this as ExportResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExportResult&&const DeepCollectionEquality().equals(other.exported, exported)&&const DeepCollectionEquality().equals(other.orphaned, orphaned));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(exported),const DeepCollectionEquality().hash(orphaned));

@override
String toString() {
  return 'ExportResult(exported: $exported, orphaned: $orphaned)';
}


}

/// @nodoc
abstract mixin class $ExportResultCopyWith<$Res>  {
  factory $ExportResultCopyWith(ExportResult value, $Res Function(ExportResult) _then) = _$ExportResultCopyWithImpl;
@useResult
$Res call({
 List<DenpaMen> exported, List<DenpaMen> orphaned
});




}
/// @nodoc
class _$ExportResultCopyWithImpl<$Res>
    implements $ExportResultCopyWith<$Res> {
  _$ExportResultCopyWithImpl(this._self, this._then);

  final ExportResult _self;
  final $Res Function(ExportResult) _then;

/// Create a copy of ExportResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? exported = null,Object? orphaned = null,}) {
  return _then(_self.copyWith(
exported: null == exported ? _self.exported : exported // ignore: cast_nullable_to_non_nullable
as List<DenpaMen>,orphaned: null == orphaned ? _self.orphaned : orphaned // ignore: cast_nullable_to_non_nullable
as List<DenpaMen>,
  ));
}

}


/// Adds pattern-matching-related methods to [ExportResult].
extension ExportResultPatterns on ExportResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExportResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExportResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExportResult value)  $default,){
final _that = this;
switch (_that) {
case _ExportResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExportResult value)?  $default,){
final _that = this;
switch (_that) {
case _ExportResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<DenpaMen> exported,  List<DenpaMen> orphaned)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExportResult() when $default != null:
return $default(_that.exported,_that.orphaned);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<DenpaMen> exported,  List<DenpaMen> orphaned)  $default,) {final _that = this;
switch (_that) {
case _ExportResult():
return $default(_that.exported,_that.orphaned);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<DenpaMen> exported,  List<DenpaMen> orphaned)?  $default,) {final _that = this;
switch (_that) {
case _ExportResult() when $default != null:
return $default(_that.exported,_that.orphaned);case _:
  return null;

}
}

}

/// @nodoc


class _ExportResult implements ExportResult {
  const _ExportResult({final  List<DenpaMen> exported = const <DenpaMen>[], final  List<DenpaMen> orphaned = const <DenpaMen>[]}): _exported = exported,_orphaned = orphaned;
  

 final  List<DenpaMen> _exported;
@override@JsonKey() List<DenpaMen> get exported {
  if (_exported is EqualUnmodifiableListView) return _exported;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_exported);
}

 final  List<DenpaMen> _orphaned;
@override@JsonKey() List<DenpaMen> get orphaned {
  if (_orphaned is EqualUnmodifiableListView) return _orphaned;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_orphaned);
}


/// Create a copy of ExportResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExportResultCopyWith<_ExportResult> get copyWith => __$ExportResultCopyWithImpl<_ExportResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExportResult&&const DeepCollectionEquality().equals(other._exported, _exported)&&const DeepCollectionEquality().equals(other._orphaned, _orphaned));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_exported),const DeepCollectionEquality().hash(_orphaned));

@override
String toString() {
  return 'ExportResult(exported: $exported, orphaned: $orphaned)';
}


}

/// @nodoc
abstract mixin class _$ExportResultCopyWith<$Res> implements $ExportResultCopyWith<$Res> {
  factory _$ExportResultCopyWith(_ExportResult value, $Res Function(_ExportResult) _then) = __$ExportResultCopyWithImpl;
@override @useResult
$Res call({
 List<DenpaMen> exported, List<DenpaMen> orphaned
});




}
/// @nodoc
class __$ExportResultCopyWithImpl<$Res>
    implements _$ExportResultCopyWith<$Res> {
  __$ExportResultCopyWithImpl(this._self, this._then);

  final _ExportResult _self;
  final $Res Function(_ExportResult) _then;

/// Create a copy of ExportResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? exported = null,Object? orphaned = null,}) {
  return _then(_ExportResult(
exported: null == exported ? _self._exported : exported // ignore: cast_nullable_to_non_nullable
as List<DenpaMen>,orphaned: null == orphaned ? _self._orphaned : orphaned // ignore: cast_nullable_to_non_nullable
as List<DenpaMen>,
  ));
}


}

// dart format on
