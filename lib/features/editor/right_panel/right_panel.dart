import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart' as p;

import 'package:app_kit/core/domain/entities/layer.dart';
import 'package:app_kit/core/domain/entities/scene.dart';
import 'package:app_kit/features/editor/providers/editor_provider.dart';

/// 右侧面板：图层列表 + 属性（合并为单一滚动区域，无需切换 Tab）
class RightPanel extends HookConsumerWidget {
  const RightPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final scene = ref.watch(selectedSceneProvider);
    final selectedLayerId = ref.watch(selectedLayerIdProvider);

    if (scene == null) {
      return ColoredBox(
        color: cs.surfaceContainerLow,
        child: const Center(
          child: Text('选择场景', style: TextStyle(color: Colors.grey)),
        ),
      );
    }

    final layers = scene.layers.reversed.toList();
    final selectedLayer = selectedLayerId != null
        ? scene.layers.where((l) => l.id == selectedLayerId).firstOrNull
        : null;

    return ColoredBox(
      color: cs.surfaceContainerLow,
      child: CustomScrollView(
        slivers: [
          // ── 图层区 heading + 添加按钮 ─────────────────────────
          SliverToBoxAdapter(
            child: _SectionHeader(
              title: '图层',
              action: FilledButton.tonalIcon(
                icon: const Icon(Icons.text_fields, size: 14),
                label: const Text('添加文字'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  textStyle: const TextStyle(fontSize: 11),
                  visualDensity: VisualDensity.compact,
                ),
                onPressed: () {
                  final id = ref
                      .read(editorProjectProvider.notifier)
                      .addTextLayer(scene.id);
                  ref.read(selectedLayerIdProvider.notifier).select(id);
                },
              ),
            ),
          ),

          // ── 图层列表 ─────────────────────────────────────────
          if (layers.isEmpty)
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Center(
                  child: Text(
                    '暂无图层',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
              ),
            )
          else
            SliverReorderableList(
              itemCount: layers.length,
              proxyDecorator: (child, index, animation) {
                final cs = Theme.of(context).colorScheme;
                return AnimatedBuilder(
                  animation: animation,
                  builder: (context, _) {
                    final t = Curves.easeOut.transform(animation.value);
                    return Material(
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: cs.shadow.withValues(alpha: 0.18 * t),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: child,
                      ),
                    );
                  },
                );
              },
              onReorder: (oldIdx, newIdx) {
                final len = layers.length;
                final realOld = len - 1 - oldIdx;
                final rawNew =
                    len - 1 - (newIdx > oldIdx ? newIdx - 1 : newIdx);
                ref
                    .read(editorProjectProvider.notifier)
                    .reorderLayers(scene.id, realOld, rawNew);
              },
              itemBuilder: (ctx, i) {
                final layer = layers[i];
                return ReorderableDragStartListener(
                  key: ValueKey(layer.id),
                  index: i,
                  child: _LayerTile(
                    layer: layer,
                    isSelected: layer.id == selectedLayerId,
                    onTap: () {
                      if (layer.id == selectedLayerId) {
                        ref.read(selectedLayerIdProvider.notifier).clear();
                      } else {
                        ref
                            .read(selectedLayerIdProvider.notifier)
                            .select(layer.id);
                      }
                    },
                    onDelete: () {
                      ref
                          .read(editorProjectProvider.notifier)
                          .removeLayer(scene.id, layer.id);
                      if (layer.id == selectedLayerId) {
                        ref.read(selectedLayerIdProvider.notifier).clear();
                      }
                    },
                  ),
                );
              },
            ),

          // ── 文字图层属性（选中图层时内联展开）─────────────────
          if (selectedLayer != null &&
              selectedLayer.type == LayerType.text) ...[
            SliverToBoxAdapter(child: _SectionHeader(title: '文字属性')),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: _TextLayerEditor(scene: scene, layer: selectedLayer),
              ),
            ),
          ],

          // ── 分隔线 ────────────────────────────────────────────
          const SliverToBoxAdapter(child: Divider(height: 16)),

          // ── 场景设置 ──────────────────────────────────────────
          SliverToBoxAdapter(child: _SectionHeader(title: '场景')),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _PropRow('名称', scene.name),
                  if (scene.screenshotPath != null)
                    _PropRow(
                      '截图',
                      p.basename(scene.screenshotPath!),
                      tooltip: scene.screenshotPath,
                    ),
                ],
              ),
            ),
          ),

          // ── 背景设置 ──────────────────────────────────────────
          SliverToBoxAdapter(child: _SectionHeader(title: '背景')),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: _BackgroundSection(scene: scene),
            ),
          ),

          // ── 设备框架位置 ───────────────────────────────────────
          SliverToBoxAdapter(child: _SectionHeader(title: '设备框架位置')),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: _OffsetSlider(
                label: '距顶部',
                value: scene.deviceOffsetTop,
                min: 0.0,
                max: 0.75,
                onChanged: (v) => ref
                    .read(editorProjectProvider.notifier)
                    .updateDeviceOffsetTop(scene.id, v),
              ),
            ),
          ),

          // 底部留白
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 1: 图层列表
// ─────────────────────────────────────────────────────────────────────────────
class _LayerTile extends StatelessWidget {
  const _LayerTile({
    super.key,
    required this.layer,
    required this.isSelected,
    required this.onTap,
    required this.onDelete,
  });
  final Layer layer;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final icon = switch (layer.type) {
      LayerType.text => Icons.text_fields,
      LayerType.screenshot => Icons.image_outlined,
      LayerType.shape => Icons.shape_line_outlined,
      LayerType.decoration => Icons.star_outline,
    };
    final label = layer.type == LayerType.text
        ? (layer.properties?['text'] as String? ?? '文字')
        : layer.type.name;

    return Material(
      color: Colors.transparent,
      child: ListTile(
        dense: true,
        selected: isSelected,
        selectedTileColor: cs.primaryContainer,
        leading: Icon(icon, size: 18, color: isSelected ? cs.primary : null),
        title: Text(
          label,
          style: const TextStyle(fontSize: 12),
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, size: 16),
          onPressed: onDelete,
        ),
        onTap: onTap,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 2: 属性编辑
// ─────────────────────────────────────────────────────────────────────────────
// ─────────────────────────────────────────────────────────────────────────────
// 背景设置
// ─────────────────────────────────────────────────────────────────────────────
class _BackgroundSection extends ConsumerWidget {
  const _BackgroundSection({required this.scene});
  final Scene scene;

  static Color _hexToColor(String hex) {
    final c = hex.replaceFirst('#', '');
    return Color(int.parse('FF$c', radix: 16));
  }

  static String _colorToHex(Color color) =>
      '#${color.toARGB32().toRadixString(16).substring(2).toUpperCase()}';

  // 工具类 App 渐变配色预设
  static const _gradientPresets = [
    ['#4A90D9', '#1A3C6E'], // 蓝靖专业
    ['#1A73E8', '#0D47A1'], // 深蓝科技
    ['#00B4D8', '#0077B6'], // 天青源流
    ['#43B89C', '#1A5C5E'], // 砂滩翠
    ['#667EEA', '#764BA2'], // 薄紫薰衣草
    ['#2C3E50', '#4CA1AF'], // 石板灰蓝
    ['#F7971E', '#FF6B35'], // 暗橙科技
    ['#1A1A2E', '#16213E'], // 深空深层
  ];

  // 纯色快捷色板
  static const _solidPresets = [
    '#FFFFFF',
    '#F5F7FA',
    '#EEF2FF',
    '#1A1A2E',
    '#1E293B',
    '#0F172A',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bgType = scene.backgroundType;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── 快捷配色色板 ──────────────────────────────────────
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '渐变',
                style: TextStyle(fontSize: 11, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: _gradientPresets.map((colors) {
                  return GestureDetector(
                    onTap: () => ref
                        .read(editorProjectProvider.notifier)
                        .updateSceneBackground(
                          scene.id,
                          backgroundType: BackgroundType.linearGradient,
                          gradientColors: List<String>.from(colors),
                        ),
                    child: Container(
                      width: 32,
                      height: 22,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: colors.map(_hexToColor).toList(),
                        ),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: Colors.grey.shade400,
                          width: 0.5,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 8),
              const Text(
                '纯色',
                style: TextStyle(fontSize: 11, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: _solidPresets.map((hex) {
                  return GestureDetector(
                    onTap: () => ref
                        .read(editorProjectProvider.notifier)
                        .updateSceneBackground(
                          scene.id,
                          backgroundType: BackgroundType.solid,
                          backgroundColor: hex,
                        ),
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: _hexToColor(hex),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: Colors.grey.shade400,
                          width: 0.5,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        const Divider(height: 12),
        SegmentedButton<BackgroundType>(
          segments: const [
            ButtonSegment(
              value: BackgroundType.solid,
              label: Text('纯色', style: TextStyle(fontSize: 11)),
            ),
            ButtonSegment(
              value: BackgroundType.linearGradient,
              label: Text('线性渐变', style: TextStyle(fontSize: 11)),
            ),
            ButtonSegment(
              value: BackgroundType.radialGradient,
              label: Text('径向渐变', style: TextStyle(fontSize: 11)),
            ),
          ],
          selected: {bgType},
          showSelectedIcon: false,
          style: const ButtonStyle(visualDensity: VisualDensity.compact),
          onSelectionChanged: (s) => ref
              .read(editorProjectProvider.notifier)
              .updateSceneBackground(scene.id, backgroundType: s.first),
        ),
        const SizedBox(height: 8),
        if (bgType == BackgroundType.solid) ...[
          _ColorRow(
            label: '背景色',
            color: _hexToColor(scene.backgroundColor),
            onChanged: (c) => ref
                .read(editorProjectProvider.notifier)
                .updateSceneBackground(
                  scene.id,
                  backgroundColor: _colorToHex(c),
                ),
          ),
        ] else ...[
          ...scene.gradientColors.asMap().entries.map(
            (e) => _ColorRow(
              label: '颜色 ${e.key + 1}',
              color: _hexToColor(e.value),
              onChanged: (c) {
                final colors = List<String>.from(scene.gradientColors);
                colors[e.key] = _colorToHex(c);
                ref
                    .read(editorProjectProvider.notifier)
                    .updateSceneBackground(scene.id, gradientColors: colors);
              },
            ),
          ),
          if (bgType == BackgroundType.linearGradient) ...[
            const SizedBox(height: 6),
            Row(
              children: [
                const Text('角度', style: TextStyle(fontSize: 12)),
                Expanded(
                  child: Slider(
                    value: scene.gradientAngle,
                    min: 0,
                    max: 360,
                    divisions: 72,
                    label: '${scene.gradientAngle.round()}°',
                    onChanged: (v) => ref
                        .read(editorProjectProvider.notifier)
                        .updateSceneBackground(scene.id, gradientAngle: v),
                  ),
                ),
                Text(
                  '${scene.gradientAngle.round()}°',
                  style: const TextStyle(fontSize: 11),
                ),
              ],
            ),
          ],
        ],
      ],
    );
  }
}

class _ColorRow extends StatelessWidget {
  const _ColorRow({
    required this.label,
    required this.color,
    required this.onChanged,
  });
  final String label;
  final Color color;
  final ValueChanged<Color> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontSize: 12)),
          const Spacer(),
          GestureDetector(
            onTap: () => _showPicker(context),
            child: Container(
              width: 36,
              height: 22,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.grey.shade400),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showPicker(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('选择颜色'),
        content: SingleChildScrollView(
          child: ColorPicker(
            color: color,
            onColorChanged: onChanged,
            pickersEnabled: const {
              ColorPickerType.both: false,
              ColorPickerType.primary: true,
              ColorPickerType.accent: false,
              ColorPickerType.wheel: true,
            },
            enableShadesSelection: false,
          ),
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 文字图层属性编辑
// ─────────────────────────────────────────────────────────────────────────────
class _TextLayerEditor extends ConsumerStatefulWidget {
  const _TextLayerEditor({required this.scene, required this.layer});
  final Scene scene;
  final Layer layer;

  @override
  ConsumerState<_TextLayerEditor> createState() => _TextLayerEditorState();
}

class _TextLayerEditorState extends ConsumerState<_TextLayerEditor> {
  late TextEditingController _textCtrl;

  @override
  void initState() {
    super.initState();
    _textCtrl = TextEditingController(
      text: widget.layer.properties?['text'] as String? ?? '',
    );
  }

  @override
  void didUpdateWidget(_TextLayerEditor old) {
    super.didUpdateWidget(old);
    if (old.layer.id != widget.layer.id) {
      _textCtrl.text = widget.layer.properties?['text'] as String? ?? '';
    }
  }

  @override
  void dispose() {
    _textCtrl.dispose();
    super.dispose();
  }

  void _update(Map<String, dynamic> patch) {
    final newProps = Map<String, dynamic>.from(widget.layer.properties ?? {})
      ..addAll(patch);
    ref
        .read(editorProjectProvider.notifier)
        .updateLayer(
          widget.scene.id,
          widget.layer.copyWith(properties: newProps),
        );
  }

  static Color _hexToColor(String hex) {
    final c = hex.replaceFirst('#', '');
    return Color(int.parse('FF$c', radix: 16));
  }

  static String _colorToHex(Color color) =>
      '#${color.toARGB32().toRadixString(16).substring(2).toUpperCase()}';

  @override
  Widget build(BuildContext context) {
    final props = widget.layer.properties ?? {};
    final fontSize = (props['fontSize'] as num?)?.toDouble() ?? 18.0;
    final colorHex = props['color'] as String? ?? '#1A1A2E';
    final bold = props['bold'] as bool? ?? false;
    final italic = props['italic'] as bool? ?? false;
    final align = props['align'] as String? ?? 'center';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _textCtrl,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: '文字内容',
            border: OutlineInputBorder(),
            isDense: true,
          ),
          onChanged: (v) => _update({'text': v}),
        ),
        const SizedBox(height: 8),
        // 文字距顶部偏移
        _OffsetSlider(
          label: '距顶部',
          value: widget.layer.y.clamp(0.0, 0.9),
          min: 0.0,
          max: 0.9,
          onChanged: (v) {
            ref
                .read(editorProjectProvider.notifier)
                .updateLayer(widget.scene.id, widget.layer.copyWith(y: v));
          },
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Text('字号', style: TextStyle(fontSize: 12)),
            Expanded(
              child: Slider(
                value: fontSize.clamp(8.0, 120.0),
                min: 8,
                max: 120,
                divisions: 56,
                label: fontSize.round().toString(),
                onChanged: (v) => _update({'fontSize': v}),
              ),
            ),
            Text('${fontSize.round()}px', style: const TextStyle(fontSize: 11)),
          ],
        ),
        Row(
          children: [
            const Text('颜色', style: TextStyle(fontSize: 12)),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () => showDialog<void>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('文字颜色'),
                  content: SingleChildScrollView(
                    child: ColorPicker(
                      color: _hexToColor(colorHex),
                      onColorChanged: (c) => _update({'color': _colorToHex(c)}),
                      pickersEnabled: const {
                        ColorPickerType.both: false,
                        ColorPickerType.primary: true,
                        ColorPickerType.accent: false,
                        ColorPickerType.wheel: true,
                      },
                      enableShadesSelection: false,
                    ),
                  ),
                  actions: [
                    FilledButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: const Text('确定'),
                    ),
                  ],
                ),
              ),
              child: Container(
                width: 28,
                height: 18,
                decoration: BoxDecoration(
                  color: _hexToColor(colorHex),
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(color: Colors.grey.shade400),
                ),
              ),
            ),
            const Spacer(),
            IconButton(
              icon: Icon(
                Icons.format_bold,
                color: bold ? Theme.of(context).colorScheme.primary : null,
              ),
              iconSize: 18,
              tooltip: '粗体',
              onPressed: () => _update({'bold': !bold}),
            ),
            IconButton(
              icon: Icon(
                Icons.format_italic,
                color: italic ? Theme.of(context).colorScheme.primary : null,
              ),
              iconSize: 18,
              tooltip: '斜体',
              onPressed: () => _update({'italic': !italic}),
            ),
          ],
        ),
        const SizedBox(height: 4),
        SegmentedButton<String>(
          segments: const [
            ButtonSegment(
              value: 'left',
              icon: Icon(Icons.format_align_left, size: 16),
            ),
            ButtonSegment(
              value: 'center',
              icon: Icon(Icons.format_align_center, size: 16),
            ),
            ButtonSegment(
              value: 'right',
              icon: Icon(Icons.format_align_right, size: 16),
            ),
          ],
          selected: {align},
          showSelectedIcon: false,
          style: const ButtonStyle(visualDensity: VisualDensity.compact),
          onSelectionChanged: (s) => _update({'align': s.first}),
        ),
        const SizedBox(height: 8),
        // 文字框宽度
        _OffsetSlider(
          label: '宽度',
          value: widget.layer.width.clamp(0.05, 1.0),
          min: 0.05,
          max: 1.0,
          onChanged: (v) {
            ref
                .read(editorProjectProvider.notifier)
                .updateLayer(widget.scene.id, widget.layer.copyWith(width: v));
          },
        ),
        // 快捷位置对齐
        Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: Row(
            children: [
              const Text('对齐', style: TextStyle(fontSize: 12)),
              const SizedBox(width: 8),
              Expanded(
                child: Wrap(
                  spacing: 4,
                  children: [
                    _AlignChip(
                      icon: Icons.align_horizontal_center,
                      label: '水平居中',
                      onTap: () {
                        final cx = ((1.0 - widget.layer.width) / 2).clamp(
                          0.0,
                          1.0,
                        );
                        ref
                            .read(editorProjectProvider.notifier)
                            .updateLayer(
                              widget.scene.id,
                              widget.layer.copyWith(x: cx),
                            );
                      },
                    ),
                    _AlignChip(
                      icon: Icons.align_vertical_center,
                      label: '垂直居中',
                      onTap: () {
                        final cy = ((1.0 - widget.layer.height) / 2).clamp(
                          0.0,
                          1.0,
                        );
                        ref
                            .read(editorProjectProvider.notifier)
                            .updateLayer(
                              widget.scene.id,
                              widget.layer.copyWith(y: cy),
                            );
                      },
                    ),
                    _AlignChip(
                      icon: Icons.filter_center_focus,
                      label: '完全居中',
                      onTap: () {
                        final cx = ((1.0 - widget.layer.width) / 2).clamp(
                          0.0,
                          1.0,
                        );
                        final cy = ((1.0 - widget.layer.height) / 2).clamp(
                          0.0,
                          1.0,
                        );
                        ref
                            .read(editorProjectProvider.notifier)
                            .updateLayer(
                              widget.scene.id,
                              widget.layer.copyWith(x: cx, y: cy),
                            );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // 文字框高度
        _OffsetSlider(
          label: '高度',
          value: widget.layer.height.clamp(0.02, 0.8),
          min: 0.02,
          max: 0.8,
          onChanged: (v) {
            ref
                .read(editorProjectProvider.notifier)
                .updateLayer(widget.scene.id, widget.layer.copyWith(height: v));
          },
        ),
        // 自动换行开关
        SwitchListTile.adaptive(
          dense: true,
          contentPadding: EdgeInsets.zero,
          title: const Text('自动换行', style: TextStyle(fontSize: 12)),
          value: props['softWrap'] as bool? ?? true,
          onChanged: (v) => _update({'softWrap': v}),
        ),
        // 最大行数（仅关闭自动换行时显示）
        if (!(props['softWrap'] as bool? ?? true))
          Row(
            children: [
              const Text('最大行数', style: TextStyle(fontSize: 12)),
              Expanded(
                child: Slider(
                  value: ((props['maxLines'] as num?)?.toDouble() ?? 1.0).clamp(
                    1.0,
                    10.0,
                  ),
                  min: 1,
                  max: 10,
                  divisions: 9,
                  label: '${(props['maxLines'] as num?)?.toInt() ?? 1}行',
                  onChanged: (v) => _update({'maxLines': v.toInt()}),
                ),
              ),
              Text(
                '${(props['maxLines'] as num?)?.toInt() ?? 1}行',
                style: const TextStyle(fontSize: 11),
              ),
            ],
          ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 通用小组件
// ─────────────────────────────────────────────────────────────────────────────

/// Section header，可选配右侧 action 按钮
class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, this.action});
  final String title;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 8, 4),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          const Spacer(),
          if (action != null) action!,
        ],
      ),
    );
  }
}

class _PropRow extends StatelessWidget {
  const _PropRow(this.label, this.value, {this.tooltip});
  final String label;
  final String value;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 48,
            child: Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
          ),
          Expanded(
            child: Tooltip(
              message: tooltip ?? '',
              child: Text(
                value,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AlignChip extends StatelessWidget {
  const _AlignChip({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, size: 15),
        ),
      ),
    );
  }
}

class _OffsetSlider extends StatelessWidget {
  const _OffsetSlider({
    required this.label,
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
  });
  final String label;
  final double value;
  final ValueChanged<double> onChanged;
  final double min;
  final double max;

  @override
  Widget build(BuildContext context) {
    final pct = ((value - min) / (max - min) * 100).round();
    return Row(
      children: [
        SizedBox(
          width: 42,
          child: Text(label, style: const TextStyle(fontSize: 12)),
        ),
        Expanded(
          child: Slider(
            value: value.clamp(min, max),
            min: min,
            max: max,
            divisions: 100,
            label: '$pct%',
            onChanged: onChanged,
          ),
        ),
        SizedBox(
          width: 32,
          child: Text('$pct%', style: const TextStyle(fontSize: 11)),
        ),
      ],
    );
  }
}
