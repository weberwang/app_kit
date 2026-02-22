import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:app_kit/core/di/repository_providers.dart';
import 'package:app_kit/core/domain/usecases/batch_export_usecase.dart';
import 'package:app_kit/core/domain/usecases/import_from_directory_usecase.dart';
import 'package:app_kit/core/domain/usecases/load_project_usecase.dart';
import 'package:app_kit/core/domain/usecases/save_project_usecase.dart';

part 'usecase_providers.g.dart';

@riverpod
LoadProjectUseCase loadProjectUseCase(Ref ref) =>
    LoadProjectUseCase(ref.watch(projectRepositoryProvider));

@riverpod
SaveProjectUseCase saveProjectUseCase(Ref ref) =>
    SaveProjectUseCase(ref.watch(projectRepositoryProvider));

@riverpod
BatchExportUseCase batchExportUseCase(Ref ref) =>
    BatchExportUseCase(ref.watch(exportRepositoryProvider));

@riverpod
ImportFromDirectoryUseCase importFromDirectoryUseCase(Ref ref) =>
    ImportFromDirectoryUseCase(ref.watch(localeImportRepositoryProvider));
