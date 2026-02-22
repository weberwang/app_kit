import 'package:app_kit/core/domain/entities/app_kit_project.dart';

abstract interface class LocaleImportRepository {
  /// 扫描目录，自动识别语言目录结构
  Future<List<String>> detectLocalesFromDirectory(String directoryPath);

  /// 从目录结构导入为项目的 LocaleSceneGroups
  Future<AppKitProject> importFromDirectory({
    required AppKitProject project,
    required String directoryPath,
    required List<String> selectedLocales,
  });
}
