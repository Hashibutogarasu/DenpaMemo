// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'qr_code.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QRCode {

 String get rawString; List<DenpaMen> get denpaMens; String? get memo; DateTime get createdAt; DateTime? get updatedAt; DateTime? get deletedAt;
/// Create a copy of QRCode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QRCodeCopyWith<QRCode> get copyWith => _$QRCodeCopyWithImpl<QRCode>(this as QRCode, _$identity);

  /// Serializes this QRCode to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QRCode&&(identical(other.rawString, rawString) || other.rawString == rawString)&&const DeepCollectionEquality().equals(other.denpaMens, denpaMens)&&(identical(other.memo, memo) || other.memo == memo)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rawString,const DeepCollectionEquality().hash(denpaMens),memo,createdAt,updatedAt,deletedAt);

@override
String toString() {
  return 'QRCode(rawString: $rawString, denpaMens: $denpaMens, memo: $memo, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class $QRCodeCopyWith<$Res>  {
  factory $QRCodeCopyWith(QRCode value, $Res Function(QRCode) _then) = _$QRCodeCopyWithImpl;
@useResult
$Res call({
 String rawString, List<DenpaMen> denpaMens, String? memo, DateTime createdAt, DateTime? updatedAt, DateTime? deletedAt
});




}
/// @nodoc
class _$QRCodeCopyWithImpl<$Res>
    implements $QRCodeCopyWith<$Res> {
  _$QRCodeCopyWithImpl(this._self, this._then);

  final QRCode _self;
  final $Res Function(QRCode) _then;

/// Create a copy of QRCode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rawString = null,Object? denpaMens = null,Object? memo = freezed,Object? createdAt = null,Object? updatedAt = freezed,Object? deletedAt = freezed,}) {
  return _then(_self.copyWith(
rawString: null == rawString ? _self.rawString : rawString // ignore: cast_nullable_to_non_nullable
as String,denpaMens: null == denpaMens ? _self.denpaMens : denpaMens // ignore: cast_nullable_to_non_nullable
as List<DenpaMen>,memo: freezed == memo ? _self.memo : memo // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [QRCode].
extension QRCodePatterns on QRCode {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QRCode value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QRCode() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QRCode value)  $default,){
final _that = this;
switch (_that) {
case _QRCode():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QRCode value)?  $default,){
final _that = this;
switch (_that) {
case _QRCode() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String rawString,  List<DenpaMen> denpaMens,  String? memo,  DateTime createdAt,  DateTime? updatedAt,  DateTime? deletedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QRCode() when $default != null:
return $default(_that.rawString,_that.denpaMens,_that.memo,_that.createdAt,_that.updatedAt,_that.deletedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String rawString,  List<DenpaMen> denpaMens,  String? memo,  DateTime createdAt,  DateTime? updatedAt,  DateTime? deletedAt)  $default,) {final _that = this;
switch (_that) {
case _QRCode():
return $default(_that.rawString,_that.denpaMens,_that.memo,_that.createdAt,_that.updatedAt,_that.deletedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String rawString,  List<DenpaMen> denpaMens,  String? memo,  DateTime createdAt,  DateTime? updatedAt,  DateTime? deletedAt)?  $default,) {final _that = this;
switch (_that) {
case _QRCode() when $default != null:
return $default(_that.rawString,_that.denpaMens,_that.memo,_that.createdAt,_that.updatedAt,_that.deletedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QRCode implements QRCode {
  const _QRCode({required this.rawString, final  List<DenpaMen> denpaMens = const [], this.memo, required this.createdAt, this.updatedAt, this.deletedAt}): _denpaMens = denpaMens;
  factory _QRCode.fromJson(Map<String, dynamic> json) => _$QRCodeFromJson(json);

@override final  String rawString;
 final  List<DenpaMen> _denpaMens;
@override@JsonKey() List<DenpaMen> get denpaMens {
  if (_denpaMens is EqualUnmodifiableListView) return _denpaMens;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_denpaMens);
}

@override final  String? memo;
@override final  DateTime createdAt;
@override final  DateTime? updatedAt;
@override final  DateTime? deletedAt;

/// Create a copy of QRCode
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QRCodeCopyWith<_QRCode> get copyWith => __$QRCodeCopyWithImpl<_QRCode>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QRCodeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QRCode&&(identical(other.rawString, rawString) || other.rawString == rawString)&&const DeepCollectionEquality().equals(other._denpaMens, _denpaMens)&&(identical(other.memo, memo) || other.memo == memo)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rawString,const DeepCollectionEquality().hash(_denpaMens),memo,createdAt,updatedAt,deletedAt);

@override
String toString() {
  return 'QRCode(rawString: $rawString, denpaMens: $denpaMens, memo: $memo, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class _$QRCodeCopyWith<$Res> implements $QRCodeCopyWith<$Res> {
  factory _$QRCodeCopyWith(_QRCode value, $Res Function(_QRCode) _then) = __$QRCodeCopyWithImpl;
@override @useResult
$Res call({
 String rawString, List<DenpaMen> denpaMens, String? memo, DateTime createdAt, DateTime? updatedAt, DateTime? deletedAt
});




}
/// @nodoc
class __$QRCodeCopyWithImpl<$Res>
    implements _$QRCodeCopyWith<$Res> {
  __$QRCodeCopyWithImpl(this._self, this._then);

  final _QRCode _self;
  final $Res Function(_QRCode) _then;

/// Create a copy of QRCode
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rawString = null,Object? denpaMens = null,Object? memo = freezed,Object? createdAt = null,Object? updatedAt = freezed,Object? deletedAt = freezed,}) {
  return _then(_QRCode(
rawString: null == rawString ? _self.rawString : rawString // ignore: cast_nullable_to_non_nullable
as String,denpaMens: null == denpaMens ? _self._denpaMens : denpaMens // ignore: cast_nullable_to_non_nullable
as List<DenpaMen>,memo: freezed == memo ? _self.memo : memo // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
