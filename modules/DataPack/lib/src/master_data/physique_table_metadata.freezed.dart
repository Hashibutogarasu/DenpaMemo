// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'physique_table_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PhysiqueTableMetadata {

 List<PhysiqueAntennaCategory> get physiqueAntennaCategories; List<PhysiqueStatusCategory> get physiqueStatusCategories;
/// Create a copy of PhysiqueTableMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhysiqueTableMetadataCopyWith<PhysiqueTableMetadata> get copyWith => _$PhysiqueTableMetadataCopyWithImpl<PhysiqueTableMetadata>(this as PhysiqueTableMetadata, _$identity);

  /// Serializes this PhysiqueTableMetadata to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhysiqueTableMetadata&&const DeepCollectionEquality().equals(other.physiqueAntennaCategories, physiqueAntennaCategories)&&const DeepCollectionEquality().equals(other.physiqueStatusCategories, physiqueStatusCategories));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(physiqueAntennaCategories),const DeepCollectionEquality().hash(physiqueStatusCategories));

@override
String toString() {
  return 'PhysiqueTableMetadata(physiqueAntennaCategories: $physiqueAntennaCategories, physiqueStatusCategories: $physiqueStatusCategories)';
}


}

/// @nodoc
abstract mixin class $PhysiqueTableMetadataCopyWith<$Res>  {
  factory $PhysiqueTableMetadataCopyWith(PhysiqueTableMetadata value, $Res Function(PhysiqueTableMetadata) _then) = _$PhysiqueTableMetadataCopyWithImpl;
@useResult
$Res call({
 List<PhysiqueAntennaCategory> physiqueAntennaCategories, List<PhysiqueStatusCategory> physiqueStatusCategories
});




}
/// @nodoc
class _$PhysiqueTableMetadataCopyWithImpl<$Res>
    implements $PhysiqueTableMetadataCopyWith<$Res> {
  _$PhysiqueTableMetadataCopyWithImpl(this._self, this._then);

  final PhysiqueTableMetadata _self;
  final $Res Function(PhysiqueTableMetadata) _then;

/// Create a copy of PhysiqueTableMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? physiqueAntennaCategories = null,Object? physiqueStatusCategories = null,}) {
  return _then(_self.copyWith(
physiqueAntennaCategories: null == physiqueAntennaCategories ? _self.physiqueAntennaCategories : physiqueAntennaCategories // ignore: cast_nullable_to_non_nullable
as List<PhysiqueAntennaCategory>,physiqueStatusCategories: null == physiqueStatusCategories ? _self.physiqueStatusCategories : physiqueStatusCategories // ignore: cast_nullable_to_non_nullable
as List<PhysiqueStatusCategory>,
  ));
}

}


/// Adds pattern-matching-related methods to [PhysiqueTableMetadata].
extension PhysiqueTableMetadataPatterns on PhysiqueTableMetadata {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhysiqueTableMetadata value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhysiqueTableMetadata() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhysiqueTableMetadata value)  $default,){
final _that = this;
switch (_that) {
case _PhysiqueTableMetadata():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhysiqueTableMetadata value)?  $default,){
final _that = this;
switch (_that) {
case _PhysiqueTableMetadata() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<PhysiqueAntennaCategory> physiqueAntennaCategories,  List<PhysiqueStatusCategory> physiqueStatusCategories)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhysiqueTableMetadata() when $default != null:
return $default(_that.physiqueAntennaCategories,_that.physiqueStatusCategories);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<PhysiqueAntennaCategory> physiqueAntennaCategories,  List<PhysiqueStatusCategory> physiqueStatusCategories)  $default,) {final _that = this;
switch (_that) {
case _PhysiqueTableMetadata():
return $default(_that.physiqueAntennaCategories,_that.physiqueStatusCategories);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<PhysiqueAntennaCategory> physiqueAntennaCategories,  List<PhysiqueStatusCategory> physiqueStatusCategories)?  $default,) {final _that = this;
switch (_that) {
case _PhysiqueTableMetadata() when $default != null:
return $default(_that.physiqueAntennaCategories,_that.physiqueStatusCategories);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PhysiqueTableMetadata implements PhysiqueTableMetadata {
  const _PhysiqueTableMetadata({required final  List<PhysiqueAntennaCategory> physiqueAntennaCategories, required final  List<PhysiqueStatusCategory> physiqueStatusCategories}): _physiqueAntennaCategories = physiqueAntennaCategories,_physiqueStatusCategories = physiqueStatusCategories;
  factory _PhysiqueTableMetadata.fromJson(Map<String, dynamic> json) => _$PhysiqueTableMetadataFromJson(json);

 final  List<PhysiqueAntennaCategory> _physiqueAntennaCategories;
@override List<PhysiqueAntennaCategory> get physiqueAntennaCategories {
  if (_physiqueAntennaCategories is EqualUnmodifiableListView) return _physiqueAntennaCategories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_physiqueAntennaCategories);
}

 final  List<PhysiqueStatusCategory> _physiqueStatusCategories;
@override List<PhysiqueStatusCategory> get physiqueStatusCategories {
  if (_physiqueStatusCategories is EqualUnmodifiableListView) return _physiqueStatusCategories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_physiqueStatusCategories);
}


/// Create a copy of PhysiqueTableMetadata
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhysiqueTableMetadataCopyWith<_PhysiqueTableMetadata> get copyWith => __$PhysiqueTableMetadataCopyWithImpl<_PhysiqueTableMetadata>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PhysiqueTableMetadataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhysiqueTableMetadata&&const DeepCollectionEquality().equals(other._physiqueAntennaCategories, _physiqueAntennaCategories)&&const DeepCollectionEquality().equals(other._physiqueStatusCategories, _physiqueStatusCategories));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_physiqueAntennaCategories),const DeepCollectionEquality().hash(_physiqueStatusCategories));

@override
String toString() {
  return 'PhysiqueTableMetadata(physiqueAntennaCategories: $physiqueAntennaCategories, physiqueStatusCategories: $physiqueStatusCategories)';
}


}

/// @nodoc
abstract mixin class _$PhysiqueTableMetadataCopyWith<$Res> implements $PhysiqueTableMetadataCopyWith<$Res> {
  factory _$PhysiqueTableMetadataCopyWith(_PhysiqueTableMetadata value, $Res Function(_PhysiqueTableMetadata) _then) = __$PhysiqueTableMetadataCopyWithImpl;
@override @useResult
$Res call({
 List<PhysiqueAntennaCategory> physiqueAntennaCategories, List<PhysiqueStatusCategory> physiqueStatusCategories
});




}
/// @nodoc
class __$PhysiqueTableMetadataCopyWithImpl<$Res>
    implements _$PhysiqueTableMetadataCopyWith<$Res> {
  __$PhysiqueTableMetadataCopyWithImpl(this._self, this._then);

  final _PhysiqueTableMetadata _self;
  final $Res Function(_PhysiqueTableMetadata) _then;

/// Create a copy of PhysiqueTableMetadata
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? physiqueAntennaCategories = null,Object? physiqueStatusCategories = null,}) {
  return _then(_PhysiqueTableMetadata(
physiqueAntennaCategories: null == physiqueAntennaCategories ? _self._physiqueAntennaCategories : physiqueAntennaCategories // ignore: cast_nullable_to_non_nullable
as List<PhysiqueAntennaCategory>,physiqueStatusCategories: null == physiqueStatusCategories ? _self._physiqueStatusCategories : physiqueStatusCategories // ignore: cast_nullable_to_non_nullable
as List<PhysiqueStatusCategory>,
  ));
}


}

// dart format on
