// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'export_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExportConfig {

 String get outputDirectory; ExportFormat get format; double get pixelRatio; bool get createZip; bool get organizeByLocale;
/// Create a copy of ExportConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExportConfigCopyWith<ExportConfig> get copyWith => _$ExportConfigCopyWithImpl<ExportConfig>(this as ExportConfig, _$identity);

  /// Serializes this ExportConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExportConfig&&(identical(other.outputDirectory, outputDirectory) || other.outputDirectory == outputDirectory)&&(identical(other.format, format) || other.format == format)&&(identical(other.pixelRatio, pixelRatio) || other.pixelRatio == pixelRatio)&&(identical(other.createZip, createZip) || other.createZip == createZip)&&(identical(other.organizeByLocale, organizeByLocale) || other.organizeByLocale == organizeByLocale));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,outputDirectory,format,pixelRatio,createZip,organizeByLocale);

@override
String toString() {
  return 'ExportConfig(outputDirectory: $outputDirectory, format: $format, pixelRatio: $pixelRatio, createZip: $createZip, organizeByLocale: $organizeByLocale)';
}


}

/// @nodoc
abstract mixin class $ExportConfigCopyWith<$Res>  {
  factory $ExportConfigCopyWith(ExportConfig value, $Res Function(ExportConfig) _then) = _$ExportConfigCopyWithImpl;
@useResult
$Res call({
 String outputDirectory, ExportFormat format, double pixelRatio, bool createZip, bool organizeByLocale
});




}
/// @nodoc
class _$ExportConfigCopyWithImpl<$Res>
    implements $ExportConfigCopyWith<$Res> {
  _$ExportConfigCopyWithImpl(this._self, this._then);

  final ExportConfig _self;
  final $Res Function(ExportConfig) _then;

/// Create a copy of ExportConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? outputDirectory = null,Object? format = null,Object? pixelRatio = null,Object? createZip = null,Object? organizeByLocale = null,}) {
  return _then(_self.copyWith(
outputDirectory: null == outputDirectory ? _self.outputDirectory : outputDirectory // ignore: cast_nullable_to_non_nullable
as String,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as ExportFormat,pixelRatio: null == pixelRatio ? _self.pixelRatio : pixelRatio // ignore: cast_nullable_to_non_nullable
as double,createZip: null == createZip ? _self.createZip : createZip // ignore: cast_nullable_to_non_nullable
as bool,organizeByLocale: null == organizeByLocale ? _self.organizeByLocale : organizeByLocale // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ExportConfig].
extension ExportConfigPatterns on ExportConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExportConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExportConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExportConfig value)  $default,){
final _that = this;
switch (_that) {
case _ExportConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExportConfig value)?  $default,){
final _that = this;
switch (_that) {
case _ExportConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String outputDirectory,  ExportFormat format,  double pixelRatio,  bool createZip,  bool organizeByLocale)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExportConfig() when $default != null:
return $default(_that.outputDirectory,_that.format,_that.pixelRatio,_that.createZip,_that.organizeByLocale);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String outputDirectory,  ExportFormat format,  double pixelRatio,  bool createZip,  bool organizeByLocale)  $default,) {final _that = this;
switch (_that) {
case _ExportConfig():
return $default(_that.outputDirectory,_that.format,_that.pixelRatio,_that.createZip,_that.organizeByLocale);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String outputDirectory,  ExportFormat format,  double pixelRatio,  bool createZip,  bool organizeByLocale)?  $default,) {final _that = this;
switch (_that) {
case _ExportConfig() when $default != null:
return $default(_that.outputDirectory,_that.format,_that.pixelRatio,_that.createZip,_that.organizeByLocale);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExportConfig implements ExportConfig {
  const _ExportConfig({required this.outputDirectory, this.format = ExportFormat.png, this.pixelRatio = 3.0, this.createZip = false, this.organizeByLocale = true});
  factory _ExportConfig.fromJson(Map<String, dynamic> json) => _$ExportConfigFromJson(json);

@override final  String outputDirectory;
@override@JsonKey() final  ExportFormat format;
@override@JsonKey() final  double pixelRatio;
@override@JsonKey() final  bool createZip;
@override@JsonKey() final  bool organizeByLocale;

/// Create a copy of ExportConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExportConfigCopyWith<_ExportConfig> get copyWith => __$ExportConfigCopyWithImpl<_ExportConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExportConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExportConfig&&(identical(other.outputDirectory, outputDirectory) || other.outputDirectory == outputDirectory)&&(identical(other.format, format) || other.format == format)&&(identical(other.pixelRatio, pixelRatio) || other.pixelRatio == pixelRatio)&&(identical(other.createZip, createZip) || other.createZip == createZip)&&(identical(other.organizeByLocale, organizeByLocale) || other.organizeByLocale == organizeByLocale));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,outputDirectory,format,pixelRatio,createZip,organizeByLocale);

@override
String toString() {
  return 'ExportConfig(outputDirectory: $outputDirectory, format: $format, pixelRatio: $pixelRatio, createZip: $createZip, organizeByLocale: $organizeByLocale)';
}


}

/// @nodoc
abstract mixin class _$ExportConfigCopyWith<$Res> implements $ExportConfigCopyWith<$Res> {
  factory _$ExportConfigCopyWith(_ExportConfig value, $Res Function(_ExportConfig) _then) = __$ExportConfigCopyWithImpl;
@override @useResult
$Res call({
 String outputDirectory, ExportFormat format, double pixelRatio, bool createZip, bool organizeByLocale
});




}
/// @nodoc
class __$ExportConfigCopyWithImpl<$Res>
    implements _$ExportConfigCopyWith<$Res> {
  __$ExportConfigCopyWithImpl(this._self, this._then);

  final _ExportConfig _self;
  final $Res Function(_ExportConfig) _then;

/// Create a copy of ExportConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? outputDirectory = null,Object? format = null,Object? pixelRatio = null,Object? createZip = null,Object? organizeByLocale = null,}) {
  return _then(_ExportConfig(
outputDirectory: null == outputDirectory ? _self.outputDirectory : outputDirectory // ignore: cast_nullable_to_non_nullable
as String,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as ExportFormat,pixelRatio: null == pixelRatio ? _self.pixelRatio : pixelRatio // ignore: cast_nullable_to_non_nullable
as double,createZip: null == createZip ? _self.createZip : createZip // ignore: cast_nullable_to_non_nullable
as bool,organizeByLocale: null == organizeByLocale ? _self.organizeByLocale : organizeByLocale // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
