import 'package:app_kit/core/domain/entities/app_kit_project.dart';
import 'package:app_kit/core/domain/entities/export_config.dart';

abstract interface class ExportRepository {
  /// 导出单一语言的全部截图
  Future<List<String>> exportLocale({
    required AppKitProject project,
    required String locale,
    required ExportConfig config,
  });

  /// 批量导出所有语言
  Future<Map<String, List<String>>> exportAll({
    required AppKitProject project,
    required ExportConfig config,
  });

  /// 将已导出文件打包成 ZIP
  Future<String> packageToZip({
    required List<String> filePaths,
    required String outputPath,
  });
}
