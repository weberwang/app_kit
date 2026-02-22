// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scene_compositor.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(sceneCompositor)
const sceneCompositorProvider = SceneCompositorProvider._();

final class SceneCompositorProvider
    extends
        $FunctionalProvider<SceneCompositor, SceneCompositor, SceneCompositor>
    with $Provider<SceneCompositor> {
  const SceneCompositorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sceneCompositorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sceneCompositorHash();

  @$internal
  @override
  $ProviderElement<SceneCompositor> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SceneCompositor create(Ref ref) {
    return sceneCompositor(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SceneCompositor value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SceneCompositor>(value),
    );
  }
}

String _$sceneCompositorHash() => r'ea994829a8dc1f3dca33658249295705b0bcbafd';
