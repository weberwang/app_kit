import 'dart:io';

import 'package:app_kit/core/domain/entities/locale_scene_group.dart';
import 'package:app_kit/core/domain/entities/scene.dart';
import 'package:uuid/uuid.dart';

abstract interface class LocaleImportDataSource {
  Future<List<String>> detectLocales(String directoryPath);
  Future<List<LocaleSceneGroup>> importLocaleGroups(
    String directoryPath,
    List<String> locales,
  );
}

final class LocaleImportDataSourceImpl implements LocaleImportDataSource {
  const LocaleImportDataSourceImpl();

  static const _uuid = Uuid();

  @override
  Future<List<String>> detectLocales(String directoryPath) async {
    final dir = Directory(directoryPath);
    final locales = <String>[];
    await for (final entity in dir.list()) {
      if (entity is Directory) {
        final name = entity.path.split(Platform.pathSeparator).last;
        // 简单的 locale 格式判断: en, zh-CN, pt-BR 等
        if (RegExp(r'^[a-z]{2}(-[A-Z]{2})?$').hasMatch(name)) {
          locales.add(name);
        }
      }
    }
    return locales..sort();
  }

  @override
  Future<List<LocaleSceneGroup>> importLocaleGroups(
    String directoryPath,
    List<String> locales,
  ) async {
    final groups = <LocaleSceneGroup>[];
    for (final locale in locales) {
      final screenshotsDir = Directory(
        '$directoryPath${Platform.pathSeparator}$locale${Platform.pathSeparator}screenshots',
      );
      if (!screenshotsDir.existsSync()) continue;

      final scenes = <Scene>[];
      int index = 0;
      // .where() 链式调用（非级联 ..），拿到过滤后的 Stream
      await for (final entity in screenshotsDir.list().where(
        (e) => e is File && _isImage(e.path),
      )) {
        final file = entity as File;
        scenes.add(
          Scene(
            id: _uuid.v4(),
            name: 'Screen ${index + 1}',
            deviceId: 'default',
            screenshotPath: file.path,
          ),
        );
        index++;
      }
      groups.add(LocaleSceneGroup(locale: locale, scenes: scenes));
    }
    return groups;
  }

  bool _isImage(String path) {
    final lower = path.toLowerCase();
    return lower.endsWith('.png') ||
        lower.endsWith('.jpg') ||
        lower.endsWith('.jpeg') ||
        lower.endsWith('.webp');
  }
}
