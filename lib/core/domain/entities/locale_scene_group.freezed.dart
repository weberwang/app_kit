// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'locale_scene_group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LocaleSceneGroup {

 String get locale; List<Scene> get scenes;
/// Create a copy of LocaleSceneGroup
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocaleSceneGroupCopyWith<LocaleSceneGroup> get copyWith => _$LocaleSceneGroupCopyWithImpl<LocaleSceneGroup>(this as LocaleSceneGroup, _$identity);

  /// Serializes this LocaleSceneGroup to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocaleSceneGroup&&(identical(other.locale, locale) || other.locale == locale)&&const DeepCollectionEquality().equals(other.scenes, scenes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,locale,const DeepCollectionEquality().hash(scenes));

@override
String toString() {
  return 'LocaleSceneGroup(locale: $locale, scenes: $scenes)';
}


}

/// @nodoc
abstract mixin class $LocaleSceneGroupCopyWith<$Res>  {
  factory $LocaleSceneGroupCopyWith(LocaleSceneGroup value, $Res Function(LocaleSceneGroup) _then) = _$LocaleSceneGroupCopyWithImpl;
@useResult
$Res call({
 String locale, List<Scene> scenes
});




}
/// @nodoc
class _$LocaleSceneGroupCopyWithImpl<$Res>
    implements $LocaleSceneGroupCopyWith<$Res> {
  _$LocaleSceneGroupCopyWithImpl(this._self, this._then);

  final LocaleSceneGroup _self;
  final $Res Function(LocaleSceneGroup) _then;

/// Create a copy of LocaleSceneGroup
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? locale = null,Object? scenes = null,}) {
  return _then(_self.copyWith(
locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,scenes: null == scenes ? _self.scenes : scenes // ignore: cast_nullable_to_non_nullable
as List<Scene>,
  ));
}

}


/// Adds pattern-matching-related methods to [LocaleSceneGroup].
extension LocaleSceneGroupPatterns on LocaleSceneGroup {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocaleSceneGroup value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocaleSceneGroup() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocaleSceneGroup value)  $default,){
final _that = this;
switch (_that) {
case _LocaleSceneGroup():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocaleSceneGroup value)?  $default,){
final _that = this;
switch (_that) {
case _LocaleSceneGroup() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String locale,  List<Scene> scenes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocaleSceneGroup() when $default != null:
return $default(_that.locale,_that.scenes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String locale,  List<Scene> scenes)  $default,) {final _that = this;
switch (_that) {
case _LocaleSceneGroup():
return $default(_that.locale,_that.scenes);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String locale,  List<Scene> scenes)?  $default,) {final _that = this;
switch (_that) {
case _LocaleSceneGroup() when $default != null:
return $default(_that.locale,_that.scenes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LocaleSceneGroup implements LocaleSceneGroup {
  const _LocaleSceneGroup({required this.locale, final  List<Scene> scenes = const []}): _scenes = scenes;
  factory _LocaleSceneGroup.fromJson(Map<String, dynamic> json) => _$LocaleSceneGroupFromJson(json);

@override final  String locale;
 final  List<Scene> _scenes;
@override@JsonKey() List<Scene> get scenes {
  if (_scenes is EqualUnmodifiableListView) return _scenes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_scenes);
}


/// Create a copy of LocaleSceneGroup
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocaleSceneGroupCopyWith<_LocaleSceneGroup> get copyWith => __$LocaleSceneGroupCopyWithImpl<_LocaleSceneGroup>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LocaleSceneGroupToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocaleSceneGroup&&(identical(other.locale, locale) || other.locale == locale)&&const DeepCollectionEquality().equals(other._scenes, _scenes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,locale,const DeepCollectionEquality().hash(_scenes));

@override
String toString() {
  return 'LocaleSceneGroup(locale: $locale, scenes: $scenes)';
}


}

/// @nodoc
abstract mixin class _$LocaleSceneGroupCopyWith<$Res> implements $LocaleSceneGroupCopyWith<$Res> {
  factory _$LocaleSceneGroupCopyWith(_LocaleSceneGroup value, $Res Function(_LocaleSceneGroup) _then) = __$LocaleSceneGroupCopyWithImpl;
@override @useResult
$Res call({
 String locale, List<Scene> scenes
});




}
/// @nodoc
class __$LocaleSceneGroupCopyWithImpl<$Res>
    implements _$LocaleSceneGroupCopyWith<$Res> {
  __$LocaleSceneGroupCopyWithImpl(this._self, this._then);

  final _LocaleSceneGroup _self;
  final $Res Function(_LocaleSceneGroup) _then;

/// Create a copy of LocaleSceneGroup
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? locale = null,Object? scenes = null,}) {
  return _then(_LocaleSceneGroup(
locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,scenes: null == scenes ? _self._scenes : scenes // ignore: cast_nullable_to_non_nullable
as List<Scene>,
  ));
}


}

// dart format on
