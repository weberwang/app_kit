// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_projects_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(recentProjects)
const recentProjectsProvider = RecentProjectsProvider._();

final class RecentProjectsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<String>>,
          List<String>,
          FutureOr<List<String>>
        >
    with $FutureModifier<List<String>>, $FutureProvider<List<String>> {
  const RecentProjectsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recentProjectsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recentProjectsHash();

  @$internal
  @override
  $FutureProviderElement<List<String>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<String>> create(Ref ref) {
    return recentProjects(ref);
  }
}

String _$recentProjectsHash() => r'85a2284a70e1f13d93723d5c357ae502d41da72b';
