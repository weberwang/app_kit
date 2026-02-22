// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(projectRepository)
const projectRepositoryProvider = ProjectRepositoryProvider._();

final class ProjectRepositoryProvider
    extends
        $FunctionalProvider<
          ProjectRepository,
          ProjectRepository,
          ProjectRepository
        >
    with $Provider<ProjectRepository> {
  const ProjectRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'projectRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$projectRepositoryHash();

  @$internal
  @override
  $ProviderElement<ProjectRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProjectRepository create(Ref ref) {
    return projectRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProjectRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProjectRepository>(value),
    );
  }
}

String _$projectRepositoryHash() => r'cea8bdc6c9ce69c84149c5eda651b6598529ae26';

@ProviderFor(exportRepository)
const exportRepositoryProvider = ExportRepositoryProvider._();

final class ExportRepositoryProvider
    extends
        $FunctionalProvider<
          ExportRepository,
          ExportRepository,
          ExportRepository
        >
    with $Provider<ExportRepository> {
  const ExportRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exportRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$exportRepositoryHash();

  @$internal
  @override
  $ProviderElement<ExportRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ExportRepository create(Ref ref) {
    return exportRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExportRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExportRepository>(value),
    );
  }
}

String _$exportRepositoryHash() => r'8d2566a95fac7cc22a4a8629aa6ea7762b2572b2';

@ProviderFor(localeImportRepository)
const localeImportRepositoryProvider = LocaleImportRepositoryProvider._();

final class LocaleImportRepositoryProvider
    extends
        $FunctionalProvider<
          LocaleImportRepository,
          LocaleImportRepository,
          LocaleImportRepository
        >
    with $Provider<LocaleImportRepository> {
  const LocaleImportRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localeImportRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localeImportRepositoryHash();

  @$internal
  @override
  $ProviderElement<LocaleImportRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocaleImportRepository create(Ref ref) {
    return localeImportRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocaleImportRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocaleImportRepository>(value),
    );
  }
}

String _$localeImportRepositoryHash() =>
    r'cbf1f34b78081dc6f085b243e7b449bde9db49f2';
