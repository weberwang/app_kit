import 'package:app_kit/core/domain/entities/app_kit_project.dart';
import 'package:app_kit/core/domain/repositories/locale_import_repository.dart';
import 'package:app_kit/core/domain/usecases/usecase.dart';

final class ImportFromDirectoryParams {
  const ImportFromDirectoryParams({
    required this.project,
    required this.directoryPath,
    required this.selectedLocales,
  });
  final AppKitProject project;
  final String directoryPath;
  final List<String> selectedLocales;
}

final class ImportFromDirectoryUseCase
    implements UseCase<AppKitProject, ImportFromDirectoryParams> {
  const ImportFromDirectoryUseCase(this._repository);

  final LocaleImportRepository _repository;

  @override
  Future<AppKitProject> call(ImportFromDirectoryParams params) =>
      _repository.importFromDirectory(
        project: params.project,
        directoryPath: params.directoryPath,
        selectedLocales: params.selectedLocales,
      );
}
