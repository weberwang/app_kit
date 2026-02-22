// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locale_scene_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LocaleSceneGroup _$LocaleSceneGroupFromJson(Map<String, dynamic> json) =>
    _LocaleSceneGroup(
      locale: json['locale'] as String,
      scenes:
          (json['scenes'] as List<dynamic>?)
              ?.map((e) => Scene.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$LocaleSceneGroupToJson(_LocaleSceneGroup instance) =>
    <String, dynamic>{'locale': instance.locale, 'scenes': instance.scenes};
