// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'operation_progress_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OperationProgressDetail {

 String get kind; String? get currentIndividualId; String? get currentIndividualName; double? get itemsPerSecond; double? get bytesPerSecond; DateTime get updatedAt;
/// Create a copy of OperationProgressDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OperationProgressDetailCopyWith<OperationProgressDetail> get copyWith => _$OperationProgressDetailCopyWithImpl<OperationProgressDetail>(this as OperationProgressDetail, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OperationProgressDetail&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.currentIndividualId, currentIndividualId) || other.currentIndividualId == currentIndividualId)&&(identical(other.currentIndividualName, currentIndividualName) || other.currentIndividualName == currentIndividualName)&&(identical(other.itemsPerSecond, itemsPerSecond) || other.itemsPerSecond == itemsPerSecond)&&(identical(other.bytesPerSecond, bytesPerSecond) || other.bytesPerSecond == bytesPerSecond)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,kind,currentIndividualId,currentIndividualName,itemsPerSecond,bytesPerSecond,updatedAt);

@override
String toString() {
  return 'OperationProgressDetail(kind: $kind, currentIndividualId: $currentIndividualId, currentIndividualName: $currentIndividualName, itemsPerSecond: $itemsPerSecond, bytesPerSecond: $bytesPerSecond, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $OperationProgressDetailCopyWith<$Res>  {
  factory $OperationProgressDetailCopyWith(OperationProgressDetail value, $Res Function(OperationProgressDetail) _then) = _$OperationProgressDetailCopyWithImpl;
@useResult
$Res call({
 String kind, String? currentIndividualId, String? currentIndividualName, double? itemsPerSecond, double? bytesPerSecond, DateTime updatedAt
});




}
/// @nodoc
class _$OperationProgressDetailCopyWithImpl<$Res>
    implements $OperationProgressDetailCopyWith<$Res> {
  _$OperationProgressDetailCopyWithImpl(this._self, this._then);

  final OperationProgressDetail _self;
  final $Res Function(OperationProgressDetail) _then;

/// Create a copy of OperationProgressDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? currentIndividualId = freezed,Object? currentIndividualName = freezed,Object? itemsPerSecond = freezed,Object? bytesPerSecond = freezed,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,currentIndividualId: freezed == currentIndividualId ? _self.currentIndividualId : currentIndividualId // ignore: cast_nullable_to_non_nullable
as String?,currentIndividualName: freezed == currentIndividualName ? _self.currentIndividualName : currentIndividualName // ignore: cast_nullable_to_non_nullable
as String?,itemsPerSecond: freezed == itemsPerSecond ? _self.itemsPerSecond : itemsPerSecond // ignore: cast_nullable_to_non_nullable
as double?,bytesPerSecond: freezed == bytesPerSecond ? _self.bytesPerSecond : bytesPerSecond // ignore: cast_nullable_to_non_nullable
as double?,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [OperationProgressDetail].
extension OperationProgressDetailPatterns on OperationProgressDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OperationProgressDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OperationProgressDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OperationProgressDetail value)  $default,){
final _that = this;
switch (_that) {
case _OperationProgressDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OperationProgressDetail value)?  $default,){
final _that = this;
switch (_that) {
case _OperationProgressDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String kind,  String? currentIndividualId,  String? currentIndividualName,  double? itemsPerSecond,  double? bytesPerSecond,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OperationProgressDetail() when $default != null:
return $default(_that.kind,_that.currentIndividualId,_that.currentIndividualName,_that.itemsPerSecond,_that.bytesPerSecond,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String kind,  String? currentIndividualId,  String? currentIndividualName,  double? itemsPerSecond,  double? bytesPerSecond,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _OperationProgressDetail():
return $default(_that.kind,_that.currentIndividualId,_that.currentIndividualName,_that.itemsPerSecond,_that.bytesPerSecond,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String kind,  String? currentIndividualId,  String? currentIndividualName,  double? itemsPerSecond,  double? bytesPerSecond,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _OperationProgressDetail() when $default != null:
return $default(_that.kind,_that.currentIndividualId,_that.currentIndividualName,_that.itemsPerSecond,_that.bytesPerSecond,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _OperationProgressDetail implements OperationProgressDetail {
  const _OperationProgressDetail({required this.kind, this.currentIndividualId, this.currentIndividualName, this.itemsPerSecond, this.bytesPerSecond, required this.updatedAt});
  

@override final  String kind;
@override final  String? currentIndividualId;
@override final  String? currentIndividualName;
@override final  double? itemsPerSecond;
@override final  double? bytesPerSecond;
@override final  DateTime updatedAt;

/// Create a copy of OperationProgressDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OperationProgressDetailCopyWith<_OperationProgressDetail> get copyWith => __$OperationProgressDetailCopyWithImpl<_OperationProgressDetail>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OperationProgressDetail&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.currentIndividualId, currentIndividualId) || other.currentIndividualId == currentIndividualId)&&(identical(other.currentIndividualName, currentIndividualName) || other.currentIndividualName == currentIndividualName)&&(identical(other.itemsPerSecond, itemsPerSecond) || other.itemsPerSecond == itemsPerSecond)&&(identical(other.bytesPerSecond, bytesPerSecond) || other.bytesPerSecond == bytesPerSecond)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,kind,currentIndividualId,currentIndividualName,itemsPerSecond,bytesPerSecond,updatedAt);

@override
String toString() {
  return 'OperationProgressDetail(kind: $kind, currentIndividualId: $currentIndividualId, currentIndividualName: $currentIndividualName, itemsPerSecond: $itemsPerSecond, bytesPerSecond: $bytesPerSecond, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$OperationProgressDetailCopyWith<$Res> implements $OperationProgressDetailCopyWith<$Res> {
  factory _$OperationProgressDetailCopyWith(_OperationProgressDetail value, $Res Function(_OperationProgressDetail) _then) = __$OperationProgressDetailCopyWithImpl;
@override @useResult
$Res call({
 String kind, String? currentIndividualId, String? currentIndividualName, double? itemsPerSecond, double? bytesPerSecond, DateTime updatedAt
});




}
/// @nodoc
class __$OperationProgressDetailCopyWithImpl<$Res>
    implements _$OperationProgressDetailCopyWith<$Res> {
  __$OperationProgressDetailCopyWithImpl(this._self, this._then);

  final _OperationProgressDetail _self;
  final $Res Function(_OperationProgressDetail) _then;

/// Create a copy of OperationProgressDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? currentIndividualId = freezed,Object? currentIndividualName = freezed,Object? itemsPerSecond = freezed,Object? bytesPerSecond = freezed,Object? updatedAt = null,}) {
  return _then(_OperationProgressDetail(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,currentIndividualId: freezed == currentIndividualId ? _self.currentIndividualId : currentIndividualId // ignore: cast_nullable_to_non_nullable
as String?,currentIndividualName: freezed == currentIndividualName ? _self.currentIndividualName : currentIndividualName // ignore: cast_nullable_to_non_nullable
as String?,itemsPerSecond: freezed == itemsPerSecond ? _self.itemsPerSecond : itemsPerSecond // ignore: cast_nullable_to_non_nullable
as double?,bytesPerSecond: freezed == bytesPerSecond ? _self.bytesPerSecond : bytesPerSecond // ignore: cast_nullable_to_non_nullable
as double?,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
