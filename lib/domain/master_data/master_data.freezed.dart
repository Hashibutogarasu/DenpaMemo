// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'master_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MasterData {

 List<HeadShape> get headShapes; List<Anntena> get anntenas; List<Attribute> get attributes; List<AbnormalityType> get abnormalityTypes; List<BodyColorResistanceRule> get bodyColorResistanceRules; List<Physique> get physiques; List<Personality> get personalities; List<Pattern> get patterns;
/// Create a copy of MasterData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MasterDataCopyWith<MasterData> get copyWith => _$MasterDataCopyWithImpl<MasterData>(this as MasterData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MasterData&&const DeepCollectionEquality().equals(other.headShapes, headShapes)&&const DeepCollectionEquality().equals(other.anntenas, anntenas)&&const DeepCollectionEquality().equals(other.attributes, attributes)&&const DeepCollectionEquality().equals(other.abnormalityTypes, abnormalityTypes)&&const DeepCollectionEquality().equals(other.bodyColorResistanceRules, bodyColorResistanceRules)&&const DeepCollectionEquality().equals(other.physiques, physiques)&&const DeepCollectionEquality().equals(other.personalities, personalities)&&const DeepCollectionEquality().equals(other.patterns, patterns));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(headShapes),const DeepCollectionEquality().hash(anntenas),const DeepCollectionEquality().hash(attributes),const DeepCollectionEquality().hash(abnormalityTypes),const DeepCollectionEquality().hash(bodyColorResistanceRules),const DeepCollectionEquality().hash(physiques),const DeepCollectionEquality().hash(personalities),const DeepCollectionEquality().hash(patterns));

@override
String toString() {
  return 'MasterData(headShapes: $headShapes, anntenas: $anntenas, attributes: $attributes, abnormalityTypes: $abnormalityTypes, bodyColorResistanceRules: $bodyColorResistanceRules, physiques: $physiques, personalities: $personalities, patterns: $patterns)';
}


}

/// @nodoc
abstract mixin class $MasterDataCopyWith<$Res>  {
  factory $MasterDataCopyWith(MasterData value, $Res Function(MasterData) _then) = _$MasterDataCopyWithImpl;
@useResult
$Res call({
 List<HeadShape> headShapes, List<Anntena> anntenas, List<Attribute> attributes, List<AbnormalityType> abnormalityTypes, List<BodyColorResistanceRule> bodyColorResistanceRules, List<Physique> physiques, List<Personality> personalities, List<Pattern> patterns
});




}
/// @nodoc
class _$MasterDataCopyWithImpl<$Res>
    implements $MasterDataCopyWith<$Res> {
  _$MasterDataCopyWithImpl(this._self, this._then);

  final MasterData _self;
  final $Res Function(MasterData) _then;

/// Create a copy of MasterData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? headShapes = null,Object? anntenas = null,Object? attributes = null,Object? abnormalityTypes = null,Object? bodyColorResistanceRules = null,Object? physiques = null,Object? personalities = null,Object? patterns = null,}) {
  return _then(_self.copyWith(
headShapes: null == headShapes ? _self.headShapes : headShapes // ignore: cast_nullable_to_non_nullable
as List<HeadShape>,anntenas: null == anntenas ? _self.anntenas : anntenas // ignore: cast_nullable_to_non_nullable
as List<Anntena>,attributes: null == attributes ? _self.attributes : attributes // ignore: cast_nullable_to_non_nullable
as List<Attribute>,abnormalityTypes: null == abnormalityTypes ? _self.abnormalityTypes : abnormalityTypes // ignore: cast_nullable_to_non_nullable
as List<AbnormalityType>,bodyColorResistanceRules: null == bodyColorResistanceRules ? _self.bodyColorResistanceRules : bodyColorResistanceRules // ignore: cast_nullable_to_non_nullable
as List<BodyColorResistanceRule>,physiques: null == physiques ? _self.physiques : physiques // ignore: cast_nullable_to_non_nullable
as List<Physique>,personalities: null == personalities ? _self.personalities : personalities // ignore: cast_nullable_to_non_nullable
as List<Personality>,patterns: null == patterns ? _self.patterns : patterns // ignore: cast_nullable_to_non_nullable
as List<Pattern>,
  ));
}

}


/// Adds pattern-matching-related methods to [MasterData].
extension MasterDataPatterns on MasterData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MasterData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MasterData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MasterData value)  $default,){
final _that = this;
switch (_that) {
case _MasterData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MasterData value)?  $default,){
final _that = this;
switch (_that) {
case _MasterData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<HeadShape> headShapes,  List<Anntena> anntenas,  List<Attribute> attributes,  List<AbnormalityType> abnormalityTypes,  List<BodyColorResistanceRule> bodyColorResistanceRules,  List<Physique> physiques,  List<Personality> personalities,  List<Pattern> patterns)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MasterData() when $default != null:
return $default(_that.headShapes,_that.anntenas,_that.attributes,_that.abnormalityTypes,_that.bodyColorResistanceRules,_that.physiques,_that.personalities,_that.patterns);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<HeadShape> headShapes,  List<Anntena> anntenas,  List<Attribute> attributes,  List<AbnormalityType> abnormalityTypes,  List<BodyColorResistanceRule> bodyColorResistanceRules,  List<Physique> physiques,  List<Personality> personalities,  List<Pattern> patterns)  $default,) {final _that = this;
switch (_that) {
case _MasterData():
return $default(_that.headShapes,_that.anntenas,_that.attributes,_that.abnormalityTypes,_that.bodyColorResistanceRules,_that.physiques,_that.personalities,_that.patterns);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<HeadShape> headShapes,  List<Anntena> anntenas,  List<Attribute> attributes,  List<AbnormalityType> abnormalityTypes,  List<BodyColorResistanceRule> bodyColorResistanceRules,  List<Physique> physiques,  List<Personality> personalities,  List<Pattern> patterns)?  $default,) {final _that = this;
switch (_that) {
case _MasterData() when $default != null:
return $default(_that.headShapes,_that.anntenas,_that.attributes,_that.abnormalityTypes,_that.bodyColorResistanceRules,_that.physiques,_that.personalities,_that.patterns);case _:
  return null;

}
}

}

/// @nodoc


class _MasterData implements MasterData {
  const _MasterData({required final  List<HeadShape> headShapes, required final  List<Anntena> anntenas, required final  List<Attribute> attributes, required final  List<AbnormalityType> abnormalityTypes, required final  List<BodyColorResistanceRule> bodyColorResistanceRules, required final  List<Physique> physiques, required final  List<Personality> personalities, required final  List<Pattern> patterns}): _headShapes = headShapes,_anntenas = anntenas,_attributes = attributes,_abnormalityTypes = abnormalityTypes,_bodyColorResistanceRules = bodyColorResistanceRules,_physiques = physiques,_personalities = personalities,_patterns = patterns;
  

 final  List<HeadShape> _headShapes;
@override List<HeadShape> get headShapes {
  if (_headShapes is EqualUnmodifiableListView) return _headShapes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_headShapes);
}

 final  List<Anntena> _anntenas;
@override List<Anntena> get anntenas {
  if (_anntenas is EqualUnmodifiableListView) return _anntenas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_anntenas);
}

 final  List<Attribute> _attributes;
@override List<Attribute> get attributes {
  if (_attributes is EqualUnmodifiableListView) return _attributes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_attributes);
}

 final  List<AbnormalityType> _abnormalityTypes;
@override List<AbnormalityType> get abnormalityTypes {
  if (_abnormalityTypes is EqualUnmodifiableListView) return _abnormalityTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_abnormalityTypes);
}

 final  List<BodyColorResistanceRule> _bodyColorResistanceRules;
@override List<BodyColorResistanceRule> get bodyColorResistanceRules {
  if (_bodyColorResistanceRules is EqualUnmodifiableListView) return _bodyColorResistanceRules;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bodyColorResistanceRules);
}

 final  List<Physique> _physiques;
@override List<Physique> get physiques {
  if (_physiques is EqualUnmodifiableListView) return _physiques;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_physiques);
}

 final  List<Personality> _personalities;
@override List<Personality> get personalities {
  if (_personalities is EqualUnmodifiableListView) return _personalities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_personalities);
}

 final  List<Pattern> _patterns;
@override List<Pattern> get patterns {
  if (_patterns is EqualUnmodifiableListView) return _patterns;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_patterns);
}


/// Create a copy of MasterData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MasterDataCopyWith<_MasterData> get copyWith => __$MasterDataCopyWithImpl<_MasterData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MasterData&&const DeepCollectionEquality().equals(other._headShapes, _headShapes)&&const DeepCollectionEquality().equals(other._anntenas, _anntenas)&&const DeepCollectionEquality().equals(other._attributes, _attributes)&&const DeepCollectionEquality().equals(other._abnormalityTypes, _abnormalityTypes)&&const DeepCollectionEquality().equals(other._bodyColorResistanceRules, _bodyColorResistanceRules)&&const DeepCollectionEquality().equals(other._physiques, _physiques)&&const DeepCollectionEquality().equals(other._personalities, _personalities)&&const DeepCollectionEquality().equals(other._patterns, _patterns));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_headShapes),const DeepCollectionEquality().hash(_anntenas),const DeepCollectionEquality().hash(_attributes),const DeepCollectionEquality().hash(_abnormalityTypes),const DeepCollectionEquality().hash(_bodyColorResistanceRules),const DeepCollectionEquality().hash(_physiques),const DeepCollectionEquality().hash(_personalities),const DeepCollectionEquality().hash(_patterns));

@override
String toString() {
  return 'MasterData(headShapes: $headShapes, anntenas: $anntenas, attributes: $attributes, abnormalityTypes: $abnormalityTypes, bodyColorResistanceRules: $bodyColorResistanceRules, physiques: $physiques, personalities: $personalities, patterns: $patterns)';
}


}

/// @nodoc
abstract mixin class _$MasterDataCopyWith<$Res> implements $MasterDataCopyWith<$Res> {
  factory _$MasterDataCopyWith(_MasterData value, $Res Function(_MasterData) _then) = __$MasterDataCopyWithImpl;
@override @useResult
$Res call({
 List<HeadShape> headShapes, List<Anntena> anntenas, List<Attribute> attributes, List<AbnormalityType> abnormalityTypes, List<BodyColorResistanceRule> bodyColorResistanceRules, List<Physique> physiques, List<Personality> personalities, List<Pattern> patterns
});




}
/// @nodoc
class __$MasterDataCopyWithImpl<$Res>
    implements _$MasterDataCopyWith<$Res> {
  __$MasterDataCopyWithImpl(this._self, this._then);

  final _MasterData _self;
  final $Res Function(_MasterData) _then;

/// Create a copy of MasterData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? headShapes = null,Object? anntenas = null,Object? attributes = null,Object? abnormalityTypes = null,Object? bodyColorResistanceRules = null,Object? physiques = null,Object? personalities = null,Object? patterns = null,}) {
  return _then(_MasterData(
headShapes: null == headShapes ? _self._headShapes : headShapes // ignore: cast_nullable_to_non_nullable
as List<HeadShape>,anntenas: null == anntenas ? _self._anntenas : anntenas // ignore: cast_nullable_to_non_nullable
as List<Anntena>,attributes: null == attributes ? _self._attributes : attributes // ignore: cast_nullable_to_non_nullable
as List<Attribute>,abnormalityTypes: null == abnormalityTypes ? _self._abnormalityTypes : abnormalityTypes // ignore: cast_nullable_to_non_nullable
as List<AbnormalityType>,bodyColorResistanceRules: null == bodyColorResistanceRules ? _self._bodyColorResistanceRules : bodyColorResistanceRules // ignore: cast_nullable_to_non_nullable
as List<BodyColorResistanceRule>,physiques: null == physiques ? _self._physiques : physiques // ignore: cast_nullable_to_non_nullable
as List<Physique>,personalities: null == personalities ? _self._personalities : personalities // ignore: cast_nullable_to_non_nullable
as List<Personality>,patterns: null == patterns ? _self._patterns : patterns // ignore: cast_nullable_to_non_nullable
as List<Pattern>,
  ));
}


}

// dart format on
