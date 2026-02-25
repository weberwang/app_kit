import 'package:app_kit/core/domain/entities/app_kit_project.dart';
import 'package:app_kit/core/domain/entities/layer.dart';
import 'package:app_kit/core/domain/entities/locale_scene_group.dart';
import 'package:app_kit/core/domain/entities/scene.dart';
import 'package:app_kit/shared/constants/canvas_presets.dart';
import 'package:app_kit/shared/constants/device_catalog.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'editor_provider.g.dart';

/// 当前打开的项目（null = 未加载）
@Riverpod(keepAlive: true)
class EditorProject extends _$EditorProject {
  static const _uuid = Uuid();

  @override
  AppKitProject? build() => null;

  void createNew(String name) {
    final now = DateTime.now();
    state = AppKitProject(
      id: _uuid.v4(),
      name: name,
      createdAt: now,
      updatedAt: now,
    );
  }

  void load(AppKitProject project) => state = project;

  void updateName(String name) {
    final p = state;
    if (p == null) return;
    state = p.copyWith(name: name, updatedAt: DateTime.now());
  }

  void markDirty() {
    final p = state;
    if (p == null) return;
    state = p.copyWith(updatedAt: DateTime.now());
  }

  void setSavedPath(String path) {
    final p = state;
    if (p == null) return;
    state = p.copyWith(savedPath: path);
  }

  /// 向指定 locale 添加一个新场景（自动带标题和副标题图层），返回新场景 ID
  String addScene({
    required String locale,
    required String screenshotPath,
    String? deviceId,
  }) {
    final p = state;
    if (p == null) return '';
    final titleLayer = Layer(
      id: _uuid.v4(),
      type: LayerType.text,
      x: 0.05,
      y: 0.01, // 距顶部 4%
      width: 0.90,
      height: 0.10,
      properties: {
        'text': '标题',
        'fontSize': 32.0,
        'fontFamily': 'Noto Sans SC',
        'color': '#1A1A2E',
        'bold': true,
        'italic': false,
        'align': 'center',
      },
    );
    final subtitleLayer = Layer(
      id: _uuid.v4(),
      type: LayerType.text,
      x: 0.05,
      y: 0.1, // 距顶部 15%
      width: 0.90,
      height: 0.08,
      properties: {
        'text': '副标题描述文字',
        'fontSize': 16.0,
        'fontFamily': 'Noto Sans SC',
        'color': '#4A4A6A',
        'bold': false,
        'italic': false,
        'align': 'center',
      },
    );
    final newScene = Scene(
      id: _uuid.v4(),
      name: 'Screen ${_nextSceneIndex(p)}',
      deviceId: deviceId ?? DeviceCatalog.defaultDeviceId,
      screenshotPath: screenshotPath,
      layers: [titleLayer, subtitleLayer],
    );

    final groups = p.localeGroups.map((g) {
      if (g.locale != locale) return g;
      return g.copyWith(scenes: [...g.scenes, newScene]);
    }).toList();

    // 若该 locale 不存在则创建
    if (!p.localeGroups.any((g) => g.locale == locale)) {
      groups.add(LocaleSceneGroup(locale: locale, scenes: [newScene]));
    }

    state = p.copyWith(localeGroups: groups, updatedAt: DateTime.now());
    return newScene.id;
  }

  int _nextSceneIndex(AppKitProject p) =>
      p.localeGroups.fold(0, (s, g) => s + g.scenes.length) + 1;

  /// 更新指定场景的设备 ID
  void updateSceneDevice(String sceneId, String deviceId) {
    _mutateScene(sceneId, (s) => s.copyWith(deviceId: deviceId));
  }

  /// 更新场景背景
  void updateSceneBackground(
    String sceneId, {
    String? backgroundColor,
    BackgroundType? backgroundType,
    List<String>? gradientColors,
    double? gradientAngle,
  }) {
    _mutateScene(
      sceneId,
      (s) => s.copyWith(
        backgroundColor: backgroundColor ?? s.backgroundColor,
        backgroundType: backgroundType ?? s.backgroundType,
        gradientColors: gradientColors ?? s.gradientColors,
        gradientAngle: gradientAngle ?? s.gradientAngle,
      ),
    );
  }

  /// 更新设备框架到顶部的偏移（0.0–1.0，相对画布高度）
  void updateDeviceOffsetTop(String sceneId, double offsetTop) {
    _mutateScene(sceneId, (s) => s.copyWith(deviceOffsetTop: offsetTop));
  }

  /// 向场景添加文字图层，返回新图层 ID
  String addTextLayer(String sceneId, {String text = '添加文字'}) {
    final newLayer = Layer(
      id: _uuid.v4(),
      type: LayerType.text,
      x: 0.1,
      y: 0.05,
      width: 0.8,
      height: 0.12,
      properties: {
        'text': text,
        'fontSize': 24.0,
        'fontFamily': 'Noto Sans SC',
        'color': '#1A1A2E',
        'bold': false,
        'italic': false,
        'align': 'center',
      },
    );
    _mutateScene(sceneId, (s) => s.copyWith(layers: [...s.layers, newLayer]));
    return newLayer.id;
  }

  /// 更新图层属性
  void updateLayer(String sceneId, Layer updated) {
    _mutateScene(
      sceneId,
      (s) => s.copyWith(
        layers: s.layers.map((l) => l.id == updated.id ? updated : l).toList(),
      ),
    );
  }

  /// 删除图层
  void removeLayer(String sceneId, String layerId) {
    _mutateScene(
      sceneId,
      (s) =>
          s.copyWith(layers: s.layers.where((l) => l.id != layerId).toList()),
    );
  }

  /// 图层重排序
  void reorderLayers(String sceneId, int oldIndex, int newIndex) {
    _mutateScene(sceneId, (s) {
      final layers = List<Layer>.from(s.layers);
      final item = layers.removeAt(oldIndex);
      layers.insert(newIndex, item);
      return s.copyWith(layers: layers);
    });
  }

  /// 删除场景
  void removeScene(String sceneId) {
    final p = state;
    if (p == null) return;
    final groups = p.localeGroups
        .map(
          (g) => g.copyWith(
            scenes: g.scenes.where((s) => s.id != sceneId).toList(),
          ),
        )
        .toList();
    state = p.copyWith(localeGroups: groups, updatedAt: DateTime.now());
  }

  // ── 内部工具 ─────────────────────────────────────────────────────────
  void _mutateScene(String sceneId, Scene Function(Scene) mutate) {
    final p = state;
    if (p == null) return;
    final groups = p.localeGroups
        .map(
          (g) => g.copyWith(
            scenes: g.scenes
                .map((s) => s.id == sceneId ? mutate(s) : s)
                .toList(),
          ),
        )
        .toList();
    state = p.copyWith(localeGroups: groups, updatedAt: DateTime.now());
  }

  /// 按比例缩放所有文字图层的字体大小（画布尺寸变化时调用）
  void scaleFontSizes(double scaleRatio) {
    final p = state;
    if (p == null) return;
    final groups = p.localeGroups
        .map(
          (g) => g.copyWith(
            scenes: g.scenes.map((s) {
              final scaledLayers = s.layers.map((layer) {
                if (layer.type != LayerType.text) return layer;
                final props = Map<String, dynamic>.from(layer.properties ?? {});
                final oldSize = (props['fontSize'] as num?)?.toDouble() ?? 18.0;
                props['fontSize'] = (oldSize * scaleRatio).clamp(8.0, 200.0);
                return layer.copyWith(properties: props);
              }).toList();
              return s.copyWith(layers: scaledLayers);
            }).toList(),
          ),
        )
        .toList();
    state = p.copyWith(localeGroups: groups, updatedAt: DateTime.now());
  }
}

/// 当前选中的设备 ID
@Riverpod(keepAlive: true)
class SelectedDeviceId extends _$SelectedDeviceId {
  @override
  String build() => DeviceCatalog.defaultDeviceId;
  void select(String id) => state = id;
}

/// 当前选中的场景 ID
@Riverpod(keepAlive: true)
class SelectedSceneId extends _$SelectedSceneId {
  @override
  String? build() => null;
  void select(String id) => state = id;
  void clear() => state = null;
}

/// 当前选中的图层 ID
@Riverpod(keepAlive: true)
class SelectedLayerId extends _$SelectedLayerId {
  @override
  String? build() => null;
  void select(String id) => state = id;
  void clear() => state = null;
}

/// 当前选中场景的便利 getter
@riverpod
Scene? selectedScene(Ref ref) {
  final project = ref.watch(editorProjectProvider);
  final id = ref.watch(selectedSceneIdProvider);
  if (project == null || id == null) return null;
  for (final group in project.localeGroups) {
    for (final scene in group.scenes) {
      if (scene.id == id) return scene;
    }
  }
  return null;
}

/// 当前画布尺寸预设（影响编辑器画布 + 导出分辨率）
@Riverpod(keepAlive: true)
class ActiveCanvasPreset extends _$ActiveCanvasPreset {
  @override
  CanvasSizePreset build() => CanvasPresets.defaultPreset;

  void select(CanvasSizePreset preset) {
    final old = state;
    if (old.id == preset.id) return;
    // 计算缩放比例（基于宽度，因为文字通常横向排列）
    final scaleRatio = preset.width / old.width;
    state = preset;
    // 按比例缩放所有文字图层的字体大小
    ref.read(editorProjectProvider.notifier).scaleFontSizes(scaleRatio);
  }
}
