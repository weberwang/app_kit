// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'layer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Layer _$LayerFromJson(Map<String, dynamic> json) => _Layer(
  id: json['id'] as String,
  type: $enumDecode(_$LayerTypeEnumMap, json['type']),
  x: (json['x'] as num).toDouble(),
  y: (json['y'] as num).toDouble(),
  width: (json['width'] as num).toDouble(),
  height: (json['height'] as num).toDouble(),
  rotation: (json['rotation'] as num?)?.toDouble() ?? 0.0,
  opacity: (json['opacity'] as num?)?.toDouble() ?? 1.0,
  visible: json['visible'] as bool? ?? true,
  properties: json['properties'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$LayerToJson(_Layer instance) => <String, dynamic>{
  'id': instance.id,
  'type': _$LayerTypeEnumMap[instance.type]!,
  'x': instance.x,
  'y': instance.y,
  'width': instance.width,
  'height': instance.height,
  'rotation': instance.rotation,
  'opacity': instance.opacity,
  'visible': instance.visible,
  'properties': instance.properties,
};

const _$LayerTypeEnumMap = {
  LayerType.screenshot: 'screenshot',
  LayerType.text: 'text',
  LayerType.shape: 'shape',
  LayerType.decoration: 'decoration',
};
