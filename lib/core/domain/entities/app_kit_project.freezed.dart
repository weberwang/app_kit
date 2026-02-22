// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_kit_project.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppKitProject {

 String get id; String get name; List<LocaleSceneGroup> get localeGroups; DateTime get createdAt; DateTime get updatedAt; String? get savedPath;
/// Create a copy of AppKitProject
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppKitProjectCopyWith<AppKitProject> get copyWith => _$AppKitProjectCopyWithImpl<AppKitProject>(this as AppKitProject, _$identity);

  /// Serializes this AppKitProject to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppKitProject&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.localeGroups, localeGroups)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.savedPath, savedPath) || other.savedPath == savedPath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(localeGroups),createdAt,updatedAt,savedPath);

@override
String toString() {
  return 'AppKitProject(id: $id, name: $name, localeGroups: $localeGroups, createdAt: $createdAt, updatedAt: $updatedAt, savedPath: $savedPath)';
}


}

/// @nodoc
abstract mixin class $AppKitProjectCopyWith<$Res>  {
  factory $AppKitProjectCopyWith(AppKitProject value, $Res Function(AppKitProject) _then) = _$AppKitProjectCopyWithImpl;
@useResult
$Res call({
 String id, String name, List<LocaleSceneGroup> localeGroups, DateTime createdAt, DateTime updatedAt, String? savedPath
});




}
/// @nodoc
class _$AppKitProjectCopyWithImpl<$Res>
    implements $AppKitProjectCopyWith<$Res> {
  _$AppKitProjectCopyWithImpl(this._self, this._then);

  final AppKitProject _self;
  final $Res Function(AppKitProject) _then;

/// Create a copy of AppKitProject
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? localeGroups = null,Object? createdAt = null,Object? updatedAt = null,Object? savedPath = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,localeGroups: null == localeGroups ? _self.localeGroups : localeGroups // ignore: cast_nullable_to_non_nullable
as List<LocaleSceneGroup>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,savedPath: freezed == savedPath ? _self.savedPath : savedPath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AppKitProject].
extension AppKitProjectPatterns on AppKitProject {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppKitProject value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppKitProject() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppKitProject value)  $default,){
final _that = this;
switch (_that) {
case _AppKitProject():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppKitProject value)?  $default,){
final _that = this;
switch (_that) {
case _AppKitProject() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  List<LocaleSceneGroup> localeGroups,  DateTime createdAt,  DateTime updatedAt,  String? savedPath)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppKitProject() when $default != null:
return $default(_that.id,_that.name,_that.localeGroups,_that.createdAt,_that.updatedAt,_that.savedPath);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  List<LocaleSceneGroup> localeGroups,  DateTime createdAt,  DateTime updatedAt,  String? savedPath)  $default,) {final _that = this;
switch (_that) {
case _AppKitProject():
return $default(_that.id,_that.name,_that.localeGroups,_that.createdAt,_that.updatedAt,_that.savedPath);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  List<LocaleSceneGroup> localeGroups,  DateTime createdAt,  DateTime updatedAt,  String? savedPath)?  $default,) {final _that = this;
switch (_that) {
case _AppKitProject() when $default != null:
return $default(_that.id,_that.name,_that.localeGroups,_that.createdAt,_that.updatedAt,_that.savedPath);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppKitProject implements AppKitProject {
  const _AppKitProject({required this.id, required this.name, final  List<LocaleSceneGroup> localeGroups = const [], required this.createdAt, required this.updatedAt, this.savedPath}): _localeGroups = localeGroups;
  factory _AppKitProject.fromJson(Map<String, dynamic> json) => _$AppKitProjectFromJson(json);

@override final  String id;
@override final  String name;
 final  List<LocaleSceneGroup> _localeGroups;
@override@JsonKey() List<LocaleSceneGroup> get localeGroups {
  if (_localeGroups is EqualUnmodifiableListView) return _localeGroups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_localeGroups);
}

@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  String? savedPath;

/// Create a copy of AppKitProject
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppKitProjectCopyWith<_AppKitProject> get copyWith => __$AppKitProjectCopyWithImpl<_AppKitProject>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppKitProjectToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppKitProject&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._localeGroups, _localeGroups)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.savedPath, savedPath) || other.savedPath == savedPath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(_localeGroups),createdAt,updatedAt,savedPath);

@override
String toString() {
  return 'AppKitProject(id: $id, name: $name, localeGroups: $localeGroups, createdAt: $createdAt, updatedAt: $updatedAt, savedPath: $savedPath)';
}


}

/// @nodoc
abstract mixin class _$AppKitProjectCopyWith<$Res> implements $AppKitProjectCopyWith<$Res> {
  factory _$AppKitProjectCopyWith(_AppKitProject value, $Res Function(_AppKitProject) _then) = __$AppKitProjectCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, List<LocaleSceneGroup> localeGroups, DateTime createdAt, DateTime updatedAt, String? savedPath
});




}
/// @nodoc
class __$AppKitProjectCopyWithImpl<$Res>
    implements _$AppKitProjectCopyWith<$Res> {
  __$AppKitProjectCopyWithImpl(this._self, this._then);

  final _AppKitProject _self;
  final $Res Function(_AppKitProject) _then;

/// Create a copy of AppKitProject
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? localeGroups = null,Object? createdAt = null,Object? updatedAt = null,Object? savedPath = freezed,}) {
  return _then(_AppKitProject(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,localeGroups: null == localeGroups ? _self._localeGroups : localeGroups // ignore: cast_nullable_to_non_nullable
as List<LocaleSceneGroup>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,savedPath: freezed == savedPath ? _self.savedPath : savedPath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
