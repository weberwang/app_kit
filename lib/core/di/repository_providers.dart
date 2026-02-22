import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:app_kit/core/data/repositories/export_repository_impl.dart';
import 'package:app_kit/core/data/repositories/locale_import_repository_impl.dart';
import 'package:app_kit/core/data/repositories/project_repository_impl.dart';
import 'package:app_kit/core/di/datasource_providers.dart';
import 'package:app_kit/core/domain/repositories/export_repository.dart';
import 'package:app_kit/core/domain/repositories/locale_import_repository.dart';
import 'package:app_kit/core/domain/repositories/project_repository.dart';

part 'repository_providers.g.dart';

@riverpod
ProjectRepository projectRepository(Ref ref) => ProjectRepositoryImpl(
  localDataSource: ref.watch(projectLocalDataSourceProvider),
  recentDataSource: ref.watch(recentProjectsDataSourceProvider),
);

@riverpod
ExportRepository exportRepository(Ref ref) => const ExportRepositoryImpl();

@riverpod
LocaleImportRepository localeImportRepository(Ref ref) =>
    LocaleImportRepositoryImpl(ref.watch(localeImportDataSourceProvider));
