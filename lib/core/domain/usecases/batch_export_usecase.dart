import 'package:app_kit/core/domain/entities/app_kit_project.dart';
import 'package:app_kit/core/domain/entities/export_config.dart';
import 'package:app_kit/core/domain/repositories/export_repository.dart';
import 'package:app_kit/core/domain/usecases/usecase.dart';

final class BatchExportParams {
  const BatchExportParams({required this.project, required this.config});
  final AppKitProject project;
  final ExportConfig config;
}

final class BatchExportUseCase
    implements UseCase<Map<String, List<String>>, BatchExportParams> {
  const BatchExportUseCase(this._repository);

  final ExportRepository _repository;

  @override
  Future<Map<String, List<String>>> call(BatchExportParams params) =>
      _repository.exportAll(project: params.project, config: params.config);
}
