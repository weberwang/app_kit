// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'editor_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 当前打开的项目（null = 未加载）

@ProviderFor(EditorProject)
const editorProjectProvider = EditorProjectProvider._();

/// 当前打开的项目（null = 未加载）
final class EditorProjectProvider
    extends $NotifierProvider<EditorProject, AppKitProject?> {
  /// 当前打开的项目（null = 未加载）
  const EditorProjectProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'editorProjectProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$editorProjectHash();

  @$internal
  @override
  EditorProject create() => EditorProject();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppKitProject? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppKitProject?>(value),
    );
  }
}

String _$editorProjectHash() => r'819db6ae7af7260a58d781891dd7573d0d7237d1';

/// 当前打开的项目（null = 未加载）

abstract class _$EditorProject extends $Notifier<AppKitProject?> {
  AppKitProject? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AppKitProject?, AppKitProject?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AppKitProject?, AppKitProject?>,
              AppKitProject?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// 当前选中的设备 ID

@ProviderFor(SelectedDeviceId)
const selectedDeviceIdProvider = SelectedDeviceIdProvider._();

/// 当前选中的设备 ID
final class SelectedDeviceIdProvider
    extends $NotifierProvider<SelectedDeviceId, String> {
  /// 当前选中的设备 ID
  const SelectedDeviceIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedDeviceIdProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedDeviceIdHash();

  @$internal
  @override
  SelectedDeviceId create() => SelectedDeviceId();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$selectedDeviceIdHash() => r'299e406015a37cc845a606f3fcb53f20f0c79e1e';

/// 当前选中的设备 ID

abstract class _$SelectedDeviceId extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// 当前选中的场景 ID

@ProviderFor(SelectedSceneId)
const selectedSceneIdProvider = SelectedSceneIdProvider._();

/// 当前选中的场景 ID
final class SelectedSceneIdProvider
    extends $NotifierProvider<SelectedSceneId, String?> {
  /// 当前选中的场景 ID
  const SelectedSceneIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedSceneIdProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedSceneIdHash();

  @$internal
  @override
  SelectedSceneId create() => SelectedSceneId();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$selectedSceneIdHash() => r'abc1baa7b52e54b9a5249e6557955d765533dc90';

/// 当前选中的场景 ID

abstract class _$SelectedSceneId extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// 当前选中的图层 ID

@ProviderFor(SelectedLayerId)
const selectedLayerIdProvider = SelectedLayerIdProvider._();

/// 当前选中的图层 ID
final class SelectedLayerIdProvider
    extends $NotifierProvider<SelectedLayerId, String?> {
  /// 当前选中的图层 ID
  const SelectedLayerIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedLayerIdProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedLayerIdHash();

  @$internal
  @override
  SelectedLayerId create() => SelectedLayerId();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$selectedLayerIdHash() => r'd2e12dd09fff2f5ff3763a45b01765fb190fe317';

/// 当前选中的图层 ID

abstract class _$SelectedLayerId extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// 当前选中场景的便利 getter

@ProviderFor(selectedScene)
const selectedSceneProvider = SelectedSceneProvider._();

/// 当前选中场景的便利 getter

final class SelectedSceneProvider
    extends $FunctionalProvider<Scene?, Scene?, Scene?>
    with $Provider<Scene?> {
  /// 当前选中场景的便利 getter
  const SelectedSceneProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedSceneProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedSceneHash();

  @$internal
  @override
  $ProviderElement<Scene?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Scene? create(Ref ref) {
    return selectedScene(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Scene? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Scene?>(value),
    );
  }
}

String _$selectedSceneHash() => r'0f6d4ac3f457034dfeb1774cba3c7a528ef20e22';

/// 当前画布尺寸预设（影响编辑器画布 + 导出分辨率）

@ProviderFor(ActiveCanvasPreset)
const activeCanvasPresetProvider = ActiveCanvasPresetProvider._();

/// 当前画布尺寸预设（影响编辑器画布 + 导出分辨率）
final class ActiveCanvasPresetProvider
    extends $NotifierProvider<ActiveCanvasPreset, CanvasSizePreset> {
  /// 当前画布尺寸预设（影响编辑器画布 + 导出分辨率）
  const ActiveCanvasPresetProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeCanvasPresetProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeCanvasPresetHash();

  @$internal
  @override
  ActiveCanvasPreset create() => ActiveCanvasPreset();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CanvasSizePreset value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CanvasSizePreset>(value),
    );
  }
}

String _$activeCanvasPresetHash() =>
    r'15a90016483ce4d387590460f09cdf8c72cf72c7';

/// 当前画布尺寸预设（影响编辑器画布 + 导出分辨率）

abstract class _$ActiveCanvasPreset extends $Notifier<CanvasSizePreset> {
  CanvasSizePreset build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<CanvasSizePreset, CanvasSizePreset>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CanvasSizePreset, CanvasSizePreset>,
              CanvasSizePreset,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
