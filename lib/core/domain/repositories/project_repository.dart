import 'package:app_kit/core/domain/entities/app_kit_project.dart';

abstract interface class ProjectRepository {
  /// 加载 .appkit 项目文件
  Future<AppKitProject> loadProject(String path);

  /// 保存项目到文件
  Future<void> saveProject(AppKitProject project, String path);

  /// 获取最近项目路径列表
  Future<List<String>> getRecentProjectPaths();

  /// 添加最近项目路径
  Future<void> addRecentProjectPath(String path);

  /// 删除最近项目路径
  Future<void> removeRecentProjectPath(String path);
}
