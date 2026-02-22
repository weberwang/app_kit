// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datasource_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// SharedPreferences — 在 main.dart 用 ProviderScope.overrides 注入
/// Riverpod 3.x: 不再支持函数式 Provider，改用 @riverpod code-gen

@ProviderFor(sharedPreferences)
const sharedPreferencesProvider = SharedPreferencesProvider._();

/// SharedPreferences — 在 main.dart 用 ProviderScope.overrides 注入
/// Riverpod 3.x: 不再支持函数式 Provider，改用 @riverpod code-gen

final class SharedPreferencesProvider
    extends
        $FunctionalProvider<
          SharedPreferences,
          SharedPreferences,
          SharedPreferences
        >
    with $Provider<SharedPreferences> {
  /// SharedPreferences — 在 main.dart 用 ProviderScope.overrides 注入
  /// Riverpod 3.x: 不再支持函数式 Provider，改用 @riverpod code-gen
  const SharedPreferencesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sharedPreferencesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sharedPreferencesHash();

  @$internal
  @override
  $ProviderElement<SharedPreferences> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SharedPreferences create(Ref ref) {
    return sharedPreferences(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SharedPreferences value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SharedPreferences>(value),
    );
  }
}

String _$sharedPreferencesHash() => r'9a657b86b8a25c3eec3fdff5607aacf921335e3d';

@ProviderFor(projectLocalDataSource)
const projectLocalDataSourceProvider = ProjectLocalDataSourceProvider._();

final class ProjectLocalDataSourceProvider
    extends
        $FunctionalProvider<
          ProjectLocalDataSource,
          ProjectLocalDataSource,
          ProjectLocalDataSource
        >
    with $Provider<ProjectLocalDataSource> {
  const ProjectLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'projectLocalDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$projectLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<ProjectLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProjectLocalDataSource create(Ref ref) {
    return projectLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProjectLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProjectLocalDataSource>(value),
    );
  }
}

String _$projectLocalDataSourceHash() =>
    r'd31916e3ce6bc10a4a28ff21ae7c229052e05e4c';

@ProviderFor(recentProjectsDataSource)
const recentProjectsDataSourceProvider = RecentProjectsDataSourceProvider._();

final class RecentProjectsDataSourceProvider
    extends
        $FunctionalProvider<
          RecentProjectsDataSource,
          RecentProjectsDataSource,
          RecentProjectsDataSource
        >
    with $Provider<RecentProjectsDataSource> {
  const RecentProjectsDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recentProjectsDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recentProjectsDataSourceHash();

  @$internal
  @override
  $ProviderElement<RecentProjectsDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RecentProjectsDataSource create(Ref ref) {
    return recentProjectsDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RecentProjectsDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RecentProjectsDataSource>(value),
    );
  }
}

String _$recentProjectsDataSourceHash() =>
    r'f0be1cbd141c4fb7e80fc85e67e694956a081b07';

@ProviderFor(localeImportDataSource)
const localeImportDataSourceProvider = LocaleImportDataSourceProvider._();

final class LocaleImportDataSourceProvider
    extends
        $FunctionalProvider<
          LocaleImportDataSource,
          LocaleImportDataSource,
          LocaleImportDataSource
        >
    with $Provider<LocaleImportDataSource> {
  const LocaleImportDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localeImportDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localeImportDataSourceHash();

  @$internal
  @override
  $ProviderElement<LocaleImportDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocaleImportDataSource create(Ref ref) {
    return localeImportDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocaleImportDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocaleImportDataSource>(value),
    );
  }
}

String _$localeImportDataSourceHash() =>
    r'afbab201fefbb02e48d3fb6f12e454b33134d8b5';
