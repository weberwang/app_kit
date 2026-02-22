// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_kit_project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppKitProject _$AppKitProjectFromJson(Map<String, dynamic> json) =>
    _AppKitProject(
      id: json['id'] as String,
      name: json['name'] as String,
      localeGroups:
          (json['localeGroups'] as List<dynamic>?)
              ?.map((e) => LocaleSceneGroup.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      savedPath: json['savedPath'] as String?,
    );

Map<String, dynamic> _$AppKitProjectToJson(_AppKitProject instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'localeGroups': instance.localeGroups,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'savedPath': instance.savedPath,
    };
