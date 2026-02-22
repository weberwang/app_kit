import 'package:app_kit/core/domain/entities/app_kit_project.dart';
import 'package:app_kit/core/domain/repositories/project_repository.dart';
import 'package:app_kit/core/domain/usecases/usecase.dart';

final class LoadProjectUseCase implements UseCase<AppKitProject, String> {
  const LoadProjectUseCase(this._repository);

  final ProjectRepository _repository;

  @override
  Future<AppKitProject> call(String path) => _repository.loadProject(path);
}
