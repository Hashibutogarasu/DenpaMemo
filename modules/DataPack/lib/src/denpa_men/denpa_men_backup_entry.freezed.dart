// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'denpa_men_backup_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DenpaMenBackupEntry {

 DenpaMen get denpaMen; QrCode? get qrCode;
/// Create a copy of DenpaMenBackupEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DenpaMenBackupEntryCopyWith<DenpaMenBackupEntry> get copyWith => _$DenpaMenBackupEntryCopyWithImpl<DenpaMenBackupEntry>(this as DenpaMenBackupEntry, _$identity);

  /// Serializes this DenpaMenBackupEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DenpaMenBackupEntry&&(identical(other.denpaMen, denpaMen) || other.denpaMen == denpaMen)&&(identical(other.qrCode, qrCode) || other.qrCode == qrCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,denpaMen,qrCode);

@override
String toString() {
  return 'DenpaMenBackupEntry(denpaMen: $denpaMen, qrCode: $qrCode)';
}


}

/// @nodoc
abstract mixin class $DenpaMenBackupEntryCopyWith<$Res>  {
  factory $DenpaMenBackupEntryCopyWith(DenpaMenBackupEntry value, $Res Function(DenpaMenBackupEntry) _then) = _$DenpaMenBackupEntryCopyWithImpl;
@useResult
$Res call({
 DenpaMen denpaMen, QrCode? qrCode
});


$DenpaMenCopyWith<$Res> get denpaMen;$QrCodeCopyWith<$Res>? get qrCode;

}
/// @nodoc
class _$DenpaMenBackupEntryCopyWithImpl<$Res>
    implements $DenpaMenBackupEntryCopyWith<$Res> {
  _$DenpaMenBackupEntryCopyWithImpl(this._self, this._then);

  final DenpaMenBackupEntry _self;
  final $Res Function(DenpaMenBackupEntry) _then;

/// Create a copy of DenpaMenBackupEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? denpaMen = null,Object? qrCode = freezed,}) {
  return _then(_self.copyWith(
denpaMen: null == denpaMen ? _self.denpaMen : denpaMen // ignore: cast_nullable_to_non_nullable
as DenpaMen,qrCode: freezed == qrCode ? _self.qrCode : qrCode // ignore: cast_nullable_to_non_nullable
as QrCode?,
  ));
}
/// Create a copy of DenpaMenBackupEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DenpaMenCopyWith<$Res> get denpaMen {
  
  return $DenpaMenCopyWith<$Res>(_self.denpaMen, (value) {
    return _then(_self.copyWith(denpaMen: value));
  });
}/// Create a copy of DenpaMenBackupEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QrCodeCopyWith<$Res>? get qrCode {
    if (_self.qrCode == null) {
    return null;
  }

  return $QrCodeCopyWith<$Res>(_self.qrCode!, (value) {
    return _then(_self.copyWith(qrCode: value));
  });
}
}


/// Adds pattern-matching-related methods to [DenpaMenBackupEntry].
extension DenpaMenBackupEntryPatterns on DenpaMenBackupEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DenpaMenBackupEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DenpaMenBackupEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DenpaMenBackupEntry value)  $default,){
final _that = this;
switch (_that) {
case _DenpaMenBackupEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DenpaMenBackupEntry value)?  $default,){
final _that = this;
switch (_that) {
case _DenpaMenBackupEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DenpaMen denpaMen,  QrCode? qrCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DenpaMenBackupEntry() when $default != null:
return $default(_that.denpaMen,_that.qrCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DenpaMen denpaMen,  QrCode? qrCode)  $default,) {final _that = this;
switch (_that) {
case _DenpaMenBackupEntry():
return $default(_that.denpaMen,_that.qrCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DenpaMen denpaMen,  QrCode? qrCode)?  $default,) {final _that = this;
switch (_that) {
case _DenpaMenBackupEntry() when $default != null:
return $default(_that.denpaMen,_that.qrCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DenpaMenBackupEntry implements DenpaMenBackupEntry {
  const _DenpaMenBackupEntry({required this.denpaMen, this.qrCode});
  factory _DenpaMenBackupEntry.fromJson(Map<String, dynamic> json) => _$DenpaMenBackupEntryFromJson(json);

@override final  DenpaMen denpaMen;
@override final  QrCode? qrCode;

/// Create a copy of DenpaMenBackupEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DenpaMenBackupEntryCopyWith<_DenpaMenBackupEntry> get copyWith => __$DenpaMenBackupEntryCopyWithImpl<_DenpaMenBackupEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DenpaMenBackupEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DenpaMenBackupEntry&&(identical(other.denpaMen, denpaMen) || other.denpaMen == denpaMen)&&(identical(other.qrCode, qrCode) || other.qrCode == qrCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,denpaMen,qrCode);

@override
String toString() {
  return 'DenpaMenBackupEntry(denpaMen: $denpaMen, qrCode: $qrCode)';
}


}

/// @nodoc
abstract mixin class _$DenpaMenBackupEntryCopyWith<$Res> implements $DenpaMenBackupEntryCopyWith<$Res> {
  factory _$DenpaMenBackupEntryCopyWith(_DenpaMenBackupEntry value, $Res Function(_DenpaMenBackupEntry) _then) = __$DenpaMenBackupEntryCopyWithImpl;
@override @useResult
$Res call({
 DenpaMen denpaMen, QrCode? qrCode
});


@override $DenpaMenCopyWith<$Res> get denpaMen;@override $QrCodeCopyWith<$Res>? get qrCode;

}
/// @nodoc
class __$DenpaMenBackupEntryCopyWithImpl<$Res>
    implements _$DenpaMenBackupEntryCopyWith<$Res> {
  __$DenpaMenBackupEntryCopyWithImpl(this._self, this._then);

  final _DenpaMenBackupEntry _self;
  final $Res Function(_DenpaMenBackupEntry) _then;

/// Create a copy of DenpaMenBackupEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? denpaMen = null,Object? qrCode = freezed,}) {
  return _then(_DenpaMenBackupEntry(
denpaMen: null == denpaMen ? _self.denpaMen : denpaMen // ignore: cast_nullable_to_non_nullable
as DenpaMen,qrCode: freezed == qrCode ? _self.qrCode : qrCode // ignore: cast_nullable_to_non_nullable
as QrCode?,
  ));
}

/// Create a copy of DenpaMenBackupEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DenpaMenCopyWith<$Res> get denpaMen {
  
  return $DenpaMenCopyWith<$Res>(_self.denpaMen, (value) {
    return _then(_self.copyWith(denpaMen: value));
  });
}/// Create a copy of DenpaMenBackupEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QrCodeCopyWith<$Res>? get qrCode {
    if (_self.qrCode == null) {
    return null;
  }

  return $QrCodeCopyWith<$Res>(_self.qrCode!, (value) {
    return _then(_self.copyWith(qrCode: value));
  });
}
}

// dart format on
