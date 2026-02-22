import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:app_kit/core/data/datasources/locale_import_datasource.dart';
import 'package:app_kit/core/data/datasources/project_local_datasource.dart';
import 'package:app_kit/core/data/datasources/recent_projects_datasource.dart';

part 'datasource_providers.g.dart';

/// SharedPreferences — 在 main.dart 用 ProviderScope.overrides 注入
/// Riverpod 3.x: 不再支持函数式 Provider，改用 @riverpod code-gen
@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref ref) {
  throw UnimplementedError('Must override in ProviderScope');
}

@riverpod
ProjectLocalDataSource projectLocalDataSource(Ref ref) =>
    const ProjectLocalDataSourceImpl();

@riverpod
RecentProjectsDataSource recentProjectsDataSource(Ref ref) =>
    RecentProjectsDataSourceImpl(ref.watch(sharedPreferencesProvider));

@riverpod
LocaleImportDataSource localeImportDataSource(Ref ref) =>
    const LocaleImportDataSourceImpl();
