// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scene.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Scene _$SceneFromJson(Map<String, dynamic> json) => _Scene(
  id: json['id'] as String,
  name: json['name'] as String,
  deviceId: json['deviceId'] as String,
  layers:
      (json['layers'] as List<dynamic>?)
          ?.map((e) => Layer.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  screenshotPath: json['screenshotPath'] as String?,
  backgroundType:
      $enumDecodeNullable(_$BackgroundTypeEnumMap, json['backgroundType']) ??
      BackgroundType.solid,
  backgroundColor: json['backgroundColor'] as String? ?? '#FFFFFF',
  gradientColors:
      (json['gradientColors'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const ['#4A90D9', '#1A3C6E'],
  gradientAngle: (json['gradientAngle'] as num?)?.toDouble() ?? 135.0,
  deviceOffsetTop: (json['deviceOffsetTop'] as num?)?.toDouble() ?? 0.10,
);

Map<String, dynamic> _$SceneToJson(_Scene instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'deviceId': instance.deviceId,
  'layers': instance.layers,
  'screenshotPath': instance.screenshotPath,
  'backgroundType': _$BackgroundTypeEnumMap[instance.backgroundType]!,
  'backgroundColor': instance.backgroundColor,
  'gradientColors': instance.gradientColors,
  'gradientAngle': instance.gradientAngle,
  'deviceOffsetTop': instance.deviceOffsetTop,
};

const _$BackgroundTypeEnumMap = {
  BackgroundType.solid: 'solid',
  BackgroundType.linearGradient: 'linearGradient',
  BackgroundType.radialGradient: 'radialGradient',
};
