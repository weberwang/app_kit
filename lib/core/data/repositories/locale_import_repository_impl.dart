import 'package:app_kit/core/data/datasources/locale_import_datasource.dart';
import 'package:app_kit/core/domain/entities/app_kit_project.dart';
import 'package:app_kit/core/domain/repositories/locale_import_repository.dart';

final class LocaleImportRepositoryImpl implements LocaleImportRepository {
  const LocaleImportRepositoryImpl(this._dataSource);

  final LocaleImportDataSource _dataSource;

  @override
  Future<List<String>> detectLocalesFromDirectory(String directoryPath) =>
      _dataSource.detectLocales(directoryPath);

  @override
  Future<AppKitProject> importFromDirectory({
    required AppKitProject project,
    required String directoryPath,
    required List<String> selectedLocales,
  }) async {
    final groups = await _dataSource.importLocaleGroups(
      directoryPath,
      selectedLocales,
    );
    return project.copyWith(localeGroups: groups, updatedAt: DateTime.now());
  }
}
