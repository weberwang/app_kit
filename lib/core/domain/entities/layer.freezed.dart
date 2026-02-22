// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'layer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Layer {

 String get id; LayerType get type; double get x; double get y; double get width; double get height; double get rotation; double get opacity; bool get visible; Map<String, dynamic>? get properties;
/// Create a copy of Layer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LayerCopyWith<Layer> get copyWith => _$LayerCopyWithImpl<Layer>(this as Layer, _$identity);

  /// Serializes this Layer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Layer&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.rotation, rotation) || other.rotation == rotation)&&(identical(other.opacity, opacity) || other.opacity == opacity)&&(identical(other.visible, visible) || other.visible == visible)&&const DeepCollectionEquality().equals(other.properties, properties));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,x,y,width,height,rotation,opacity,visible,const DeepCollectionEquality().hash(properties));

@override
String toString() {
  return 'Layer(id: $id, type: $type, x: $x, y: $y, width: $width, height: $height, rotation: $rotation, opacity: $opacity, visible: $visible, properties: $properties)';
}


}

/// @nodoc
abstract mixin class $LayerCopyWith<$Res>  {
  factory $LayerCopyWith(Layer value, $Res Function(Layer) _then) = _$LayerCopyWithImpl;
@useResult
$Res call({
 String id, LayerType type, double x, double y, double width, double height, double rotation, double opacity, bool visible, Map<String, dynamic>? properties
});




}
/// @nodoc
class _$LayerCopyWithImpl<$Res>
    implements $LayerCopyWith<$Res> {
  _$LayerCopyWithImpl(this._self, this._then);

  final Layer _self;
  final $Res Function(Layer) _then;

/// Create a copy of Layer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? x = null,Object? y = null,Object? width = null,Object? height = null,Object? rotation = null,Object? opacity = null,Object? visible = null,Object? properties = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as LayerType,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,rotation: null == rotation ? _self.rotation : rotation // ignore: cast_nullable_to_non_nullable
as double,opacity: null == opacity ? _self.opacity : opacity // ignore: cast_nullable_to_non_nullable
as double,visible: null == visible ? _self.visible : visible // ignore: cast_nullable_to_non_nullable
as bool,properties: freezed == properties ? _self.properties : properties // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [Layer].
extension LayerPatterns on Layer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Layer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Layer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Layer value)  $default,){
final _that = this;
switch (_that) {
case _Layer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Layer value)?  $default,){
final _that = this;
switch (_that) {
case _Layer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  LayerType type,  double x,  double y,  double width,  double height,  double rotation,  double opacity,  bool visible,  Map<String, dynamic>? properties)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Layer() when $default != null:
return $default(_that.id,_that.type,_that.x,_that.y,_that.width,_that.height,_that.rotation,_that.opacity,_that.visible,_that.properties);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  LayerType type,  double x,  double y,  double width,  double height,  double rotation,  double opacity,  bool visible,  Map<String, dynamic>? properties)  $default,) {final _that = this;
switch (_that) {
case _Layer():
return $default(_that.id,_that.type,_that.x,_that.y,_that.width,_that.height,_that.rotation,_that.opacity,_that.visible,_that.properties);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  LayerType type,  double x,  double y,  double width,  double height,  double rotation,  double opacity,  bool visible,  Map<String, dynamic>? properties)?  $default,) {final _that = this;
switch (_that) {
case _Layer() when $default != null:
return $default(_that.id,_that.type,_that.x,_that.y,_that.width,_that.height,_that.rotation,_that.opacity,_that.visible,_that.properties);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Layer implements Layer {
  const _Layer({required this.id, required this.type, required this.x, required this.y, required this.width, required this.height, this.rotation = 0.0, this.opacity = 1.0, this.visible = true, final  Map<String, dynamic>? properties}): _properties = properties;
  factory _Layer.fromJson(Map<String, dynamic> json) => _$LayerFromJson(json);

@override final  String id;
@override final  LayerType type;
@override final  double x;
@override final  double y;
@override final  double width;
@override final  double height;
@override@JsonKey() final  double rotation;
@override@JsonKey() final  double opacity;
@override@JsonKey() final  bool visible;
 final  Map<String, dynamic>? _properties;
@override Map<String, dynamic>? get properties {
  final value = _properties;
  if (value == null) return null;
  if (_properties is EqualUnmodifiableMapView) return _properties;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of Layer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LayerCopyWith<_Layer> get copyWith => __$LayerCopyWithImpl<_Layer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LayerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Layer&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.rotation, rotation) || other.rotation == rotation)&&(identical(other.opacity, opacity) || other.opacity == opacity)&&(identical(other.visible, visible) || other.visible == visible)&&const DeepCollectionEquality().equals(other._properties, _properties));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,x,y,width,height,rotation,opacity,visible,const DeepCollectionEquality().hash(_properties));

@override
String toString() {
  return 'Layer(id: $id, type: $type, x: $x, y: $y, width: $width, height: $height, rotation: $rotation, opacity: $opacity, visible: $visible, properties: $properties)';
}


}

/// @nodoc
abstract mixin class _$LayerCopyWith<$Res> implements $LayerCopyWith<$Res> {
  factory _$LayerCopyWith(_Layer value, $Res Function(_Layer) _then) = __$LayerCopyWithImpl;
@override @useResult
$Res call({
 String id, LayerType type, double x, double y, double width, double height, double rotation, double opacity, bool visible, Map<String, dynamic>? properties
});




}
/// @nodoc
class __$LayerCopyWithImpl<$Res>
    implements _$LayerCopyWith<$Res> {
  __$LayerCopyWithImpl(this._self, this._then);

  final _Layer _self;
  final $Res Function(_Layer) _then;

/// Create a copy of Layer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? x = null,Object? y = null,Object? width = null,Object? height = null,Object? rotation = null,Object? opacity = null,Object? visible = null,Object? properties = freezed,}) {
  return _then(_Layer(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as LayerType,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,rotation: null == rotation ? _self.rotation : rotation // ignore: cast_nullable_to_non_nullable
as double,opacity: null == opacity ? _self.opacity : opacity // ignore: cast_nullable_to_non_nullable
as double,visible: null == visible ? _self.visible : visible // ignore: cast_nullable_to_non_nullable
as bool,properties: freezed == properties ? _self._properties : properties // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
