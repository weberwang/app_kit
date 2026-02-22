import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:app_kit/core/domain/entities/app_kit_project.dart';
import 'package:app_kit/core/domain/entities/export_config.dart';
import 'package:app_kit/core/domain/repositories/export_repository.dart';

final class ExportRepositoryImpl implements ExportRepository {
  const ExportRepositoryImpl();

  @override
  Future<List<String>> exportLocale({
    required AppKitProject project,
    required String locale,
    required ExportConfig config,
  }) async {
    final group = project.localeGroups
        .where((g) => g.locale == locale)
        .firstOrNull;
    if (group == null) return [];

    final outputDir = config.organizeByLocale
        ? '${config.outputDirectory}${Platform.pathSeparator}$locale'
        : config.outputDirectory;
    await Directory(outputDir).create(recursive: true);

    // TODO(export): 渲染 Canvas 并保存图片
    // 现阶段：直接复制原始截图作为占位
    final exported = <String>[];
    for (var i = 0; i < group.scenes.length; i++) {
      final scene = group.scenes[i];
      if (scene.screenshotPath == null) continue;
      final ext = config.format.name;
      final dest =
          '$outputDir${Platform.pathSeparator}screenshot_${i + 1}.$ext';
      await File(scene.screenshotPath!).copy(dest);
      exported.add(dest);
    }
    return exported;
  }

  @override
  Future<Map<String, List<String>>> exportAll({
    required AppKitProject project,
    required ExportConfig config,
  }) async {
    final result = <String, List<String>>{};
    for (final group in project.localeGroups) {
      result[group.locale] = await exportLocale(
        project: project,
        locale: group.locale,
        config: config,
      );
    }
    return result;
  }

  @override
  Future<String> packageToZip({
    required List<String> filePaths,
    required String outputPath,
  }) async {
    final encoder = ZipFileEncoder();
    encoder.create(outputPath);
    for (final path in filePaths) {
      encoder.addFile(File(path));
    }
    encoder.close();
    return outputPath;
  }
}
