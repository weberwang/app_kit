import 'package:freezed_annotation/freezed_annotation.dart';

part 'export_config.freezed.dart';
part 'export_config.g.dart';

enum ExportFormat { png, jpg, webp }

@freezed
sealed class ExportConfig with _$ExportConfig {
  const factory ExportConfig({
    required String outputDirectory,
    @Default(ExportFormat.png) ExportFormat format,
    @Default(3.0) double pixelRatio,
    @Default(false) bool createZip,
    @Default(true) bool organizeByLocale,
  }) = _ExportConfig;

  factory ExportConfig.fromJson(Map<String, dynamic> json) =>
      _$ExportConfigFromJson(json);
}
