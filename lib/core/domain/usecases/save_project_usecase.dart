import 'package:app_kit/core/domain/entities/app_kit_project.dart';
import 'package:app_kit/core/domain/repositories/project_repository.dart';
import 'package:app_kit/core/domain/usecases/usecase.dart';

final class SaveProjectParams {
  const SaveProjectParams({required this.project, required this.path});
  final AppKitProject project;
  final String path;
}

final class SaveProjectUseCase implements UseCase<void, SaveProjectParams> {
  const SaveProjectUseCase(this._repository);

  final ProjectRepository _repository;

  @override
  Future<void> call(SaveProjectParams params) =>
      _repository.saveProject(params.project, params.path);
}
