// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'export_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExportConfig _$ExportConfigFromJson(Map<String, dynamic> json) =>
    _ExportConfig(
      outputDirectory: json['outputDirectory'] as String,
      format:
          $enumDecodeNullable(_$ExportFormatEnumMap, json['format']) ??
          ExportFormat.png,
      pixelRatio: (json['pixelRatio'] as num?)?.toDouble() ?? 3.0,
      createZip: json['createZip'] as bool? ?? false,
      organizeByLocale: json['organizeByLocale'] as bool? ?? true,
    );

Map<String, dynamic> _$ExportConfigToJson(_ExportConfig instance) =>
    <String, dynamic>{
      'outputDirectory': instance.outputDirectory,
      'format': _$ExportFormatEnumMap[instance.format]!,
      'pixelRatio': instance.pixelRatio,
      'createZip': instance.createZip,
      'organizeByLocale': instance.organizeByLocale,
    };

const _$ExportFormatEnumMap = {
  ExportFormat.png: 'png',
  ExportFormat.jpg: 'jpg',
  ExportFormat.webp: 'webp',
};
