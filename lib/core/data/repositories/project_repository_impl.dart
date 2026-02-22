import 'package:app_kit/core/data/datasources/project_local_datasource.dart';
import 'package:app_kit/core/data/datasources/recent_projects_datasource.dart';
import 'package:app_kit/core/domain/entities/app_kit_project.dart';
import 'package:app_kit/core/domain/repositories/project_repository.dart';

final class ProjectRepositoryImpl implements ProjectRepository {
  const ProjectRepositoryImpl({
    required ProjectLocalDataSource localDataSource,
    required RecentProjectsDataSource recentDataSource,
  }) : _local = localDataSource,
       _recent = recentDataSource;

  final ProjectLocalDataSource _local;
  final RecentProjectsDataSource _recent;

  @override
  Future<AppKitProject> loadProject(String path) => _local.readProject(path);

  @override
  Future<void> saveProject(AppKitProject project, String path) =>
      _local.writeProject(project, path);

  @override
  Future<List<String>> getRecentProjectPaths() => _recent.getRecentPaths();

  @override
  Future<void> addRecentProjectPath(String path) => _recent.addPath(path);

  @override
  Future<void> removeRecentProjectPath(String path) => _recent.removePath(path);
}
