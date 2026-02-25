import 'dart:io';
import 'dart:math' as math;

import 'package:desktop_drop/desktop_drop.dart';
import 'package:device_frame_plus/device_frame_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:app_kit/core/domain/entities/layer.dart';
import 'package:app_kit/core/domain/entities/scene.dart';
import 'package:app_kit/features/editor/providers/editor_provider.dart';
import 'package:app_kit/shared/constants/device_catalog.dart';

/// 中央画布区域：显示设备框架 + 截图预览，支持拖入图片
class CanvasArea extends HookConsumerWidget {
  const CanvasArea({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scene = ref.watch(selectedSceneProvider);
    final deviceId = ref.watch(selectedDeviceIdProvider);
    final isDragging = useState(false);

    return DropTarget(
      onDragEntered: (_) => isDragging.value = true,
      onDragExited: (_) => isDragging.value = false,
      onDragDone: (detail) async {
        isDragging.value = false;
        await _onDropDone(context, ref, detail);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        color: isDragging.value
            ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.08)
            : Theme.of(context).colorScheme.surfaceContainerLowest,
        child: Stack(
          children: [
            InteractiveViewer(
              minScale: 0.2,
              maxScale: 4.0,
              child: Center(
                child: scene == null
                    ? const _Placeholder()
                    : _SceneCanvas(scene: scene, deviceId: deviceId),
              ),
            ),
            if (isDragging.value)
              IgnorePointer(
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.85),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.add_photo_alternate,
                          color: Colors.white,
                          size: 22,
                        ),
                        SizedBox(width: 8),
                        Text(
                          '松开以添加截图',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _onDropDone(
    BuildContext context,
    WidgetRef ref,
    DropDoneDetails detail,
  ) async {
    const imageExts = {'.png', '.jpg', '.jpeg', '.webp'};
    final deviceId = ref.read(selectedDeviceIdProvider);
    final project = ref.read(editorProjectProvider);
    if (project == null) return;

    final existingLocales = project.localeGroups.map((g) => g.locale).toList();
    var locale = _resolveDropLocale(ref);

    if (!context.mounted) return;
    final picked = await showDialog<String>(
      context: context,
      builder: (ctx) =>
          _DropLocalePickerDialog(existing: existingLocales, initial: locale),
    );
    if (!context.mounted || picked == null) return;
    locale = picked;

    String? firstSceneId;
    for (final file in detail.files) {
      final lower = file.path.toLowerCase();
      if (!imageExts.any(lower.endsWith)) continue;
      final id = ref
          .read(editorProjectProvider.notifier)
          .addScene(
            locale: locale,
            screenshotPath: file.path,
            deviceId: deviceId,
          );
      firstSceneId ??= id;
    }
    if (firstSceneId != null) {
      ref.read(selectedSceneIdProvider.notifier).select(firstSceneId);
    }
  }

  String _resolveDropLocale(WidgetRef ref) {
    final project = ref.read(editorProjectProvider);
    final selectedSceneId = ref.read(selectedSceneIdProvider);
    if (project == null) return 'default';

    if (selectedSceneId != null) {
      for (final group in project.localeGroups) {
        if (group.scenes.any((s) => s.id == selectedSceneId)) {
          return group.locale;
        }
      }
    }

    if (project.localeGroups.isNotEmpty) {
      return project.localeGroups.first.locale;
    }
    return 'default';
  }
}

class _DropLocalePickerDialog extends StatefulWidget {
  const _DropLocalePickerDialog({
    required this.existing,
    required this.initial,
  });

  final List<String> existing;
  final String initial;

  @override
  State<_DropLocalePickerDialog> createState() =>
      _DropLocalePickerDialogState();
}

class _DropLocalePickerDialogState extends State<_DropLocalePickerDialog> {
  late final TextEditingController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: widget.initial);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('选择语言'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.existing.isNotEmpty) ...[
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: widget.existing
                  .map(
                    (locale) => ActionChip(
                      label: Text(locale),
                      onPressed: () => _ctrl.text = locale,
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 12),
            const Text(
              '或输入新语言代码：',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 4),
          ],
          TextField(
            controller: _ctrl,
            autofocus: widget.existing.isEmpty,
            decoration: const InputDecoration(
              hintText: 'zh, en, ja, ko…',
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('取消'),
        ),
        FilledButton(
          onPressed: () {
            final value = _ctrl.text.trim();
            if (value.isNotEmpty) {
              Navigator.of(context).pop(value);
            }
          },
          child: const Text('确定'),
        ),
      ],
    );
  }
}

// ── 完整场景画布（背景 + 设备框 + 文字图层）─────────────────────────────
class _SceneCanvas extends ConsumerWidget {
  const _SceneCanvas({required this.scene, required this.deviceId});
  final Scene scene;
  final String deviceId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preset = ref.watch(activeCanvasPresetProvider);
    final canvasW = preset.width;
    final canvasH = preset.height;
    final selectedLayerId = ref.watch(selectedLayerIdProvider);
    // 设备型号统一由左侧面板的 selectedDeviceIdProvider 提供
    final effectiveDeviceId = deviceId;

    final Widget screen = scene.screenshotPath != null
        ? SizedBox.expand(
            child: Image.file(File(scene.screenshotPath!), fit: BoxFit.fill),
          )
        : const ColoredBox(
            color: Colors.white,
            child: Center(child: Text('截图预览')),
          );

    final textLayers = scene.layers
        .where((l) => l.type == LayerType.text)
        .toList();

    return Padding(
      padding: const EdgeInsets.all(32),
      child: SizedBox(
        width: canvasW,
        height: canvasH,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Stack(
            children: [
              // ── 背景层 ────────────────────────────────────────
              Positioned.fill(child: _BackgroundPainter(scene: scene)),

              // ── 设备框架层（按 deviceOffsetTop 定位，底部超出画布自动裁切）─────
              Positioned(
                top: scene.deviceOffsetTop * canvasH,
                left: canvasW * 0.06,
                right: canvasW * 0.06,
                height: canvasH,
                child: DeviceFrame(
                  device: DeviceCatalog.frameFor(effectiveDeviceId),
                  screen: screen,
                ),
              ),

              // ── 文字图层 ──────────────────────────────────────
              ...textLayers.map(
                (layer) => _TextLayerWidget(
                  key: ValueKey(layer.id),
                  layer: layer,
                  canvasW: canvasW,
                  canvasH: canvasH,
                  isSelected: layer.id == selectedLayerId,
                  onTap: () => ref
                      .read(selectedLayerIdProvider.notifier)
                      .select(layer.id),
                  onPositionChanged: (x, y) => ref
                      .read(editorProjectProvider.notifier)
                      .updateLayer(scene.id, layer.copyWith(x: x, y: y)),
                  onWidthChanged: (w) => ref
                      .read(editorProjectProvider.notifier)
                      .updateLayer(scene.id, layer.copyWith(width: w)),
                  onHeightChanged: (h) => ref
                      .read(editorProjectProvider.notifier)
                      .updateLayer(scene.id, layer.copyWith(height: h)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── 背景渲染 ──────────────────────────────────────────────────────────────
class _BackgroundPainter extends StatelessWidget {
  const _BackgroundPainter({required this.scene});
  final Scene scene;

  static Color _hexColor(String hex) {
    final c = hex.replaceFirst('#', '');
    return Color(int.parse('FF$c', radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    switch (scene.backgroundType) {
      case BackgroundType.solid:
        return ColoredBox(color: _hexColor(scene.backgroundColor));

      case BackgroundType.linearGradient:
        final angle = scene.gradientAngle * math.pi / 180;
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(
                -math.cos(angle).clamp(-1.0, 1.0),
                -math.sin(angle).clamp(-1.0, 1.0),
              ),
              end: Alignment(
                math.cos(angle).clamp(-1.0, 1.0),
                math.sin(angle).clamp(-1.0, 1.0),
              ),
              colors: scene.gradientColors
                  .map(_hexColor)
                  .toList()
                  .cast<Color>(),
            ),
          ),
        );

      case BackgroundType.radialGradient:
        return Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: scene.gradientColors
                  .map(_hexColor)
                  .toList()
                  .cast<Color>(),
            ),
          ),
        );
    }
  }
}

// ── 文字图层拖拽模式 ──────────────────────────────────────────────────────
enum _TLDragMode { move, resizeRight, resizeBottom, resizeCorner }

// ── 文字图层 Widget ───────────────────────────────────────────────────────
class _TextLayerWidget extends StatefulWidget {
  const _TextLayerWidget({
    super.key,
    required this.layer,
    required this.canvasW,
    required this.canvasH,
    required this.isSelected,
    required this.onTap,
    required this.onPositionChanged,
    required this.onWidthChanged,
    required this.onHeightChanged,
  });

  final Layer layer;
  final double canvasW;
  final double canvasH;
  final bool isSelected;
  final VoidCallback onTap;
  final void Function(double x, double y) onPositionChanged;
  final ValueChanged<double> onWidthChanged;
  final ValueChanged<double> onHeightChanged;

  @override
  State<_TextLayerWidget> createState() => _TextLayerWidgetState();
}

class _TextLayerWidgetState extends State<_TextLayerWidget> {
  static const double _edgeZone = 14.0;
  static const double _handleThick = 4.0;
  static const double _cornerSize = 14.0;

  _TLDragMode _mode = _TLDragMode.move;
  Offset _hoverPos = Offset.zero;
  bool _isDragMoving = false;

  double get _boxW => widget.layer.width * widget.canvasW;
  double get _boxH => widget.layer.height * widget.canvasH;

  // 根据局部坐标判断拖动模式
  _TLDragMode _modeFor(Offset pos) {
    if (!widget.isSelected) return _TLDragMode.move;
    final nearRight = pos.dx >= _boxW - _edgeZone;
    final nearBottom = pos.dy >= _boxH - _edgeZone;
    if (nearRight && nearBottom) return _TLDragMode.resizeCorner;
    if (nearRight) return _TLDragMode.resizeRight;
    if (nearBottom) return _TLDragMode.resizeBottom;
    return _TLDragMode.move;
  }

  // 根据位置选择光标类型
  MouseCursor _cursorFor(Offset pos) {
    if (!widget.isSelected) return SystemMouseCursors.click;
    switch (_modeFor(pos)) {
      case _TLDragMode.resizeCorner:
        return SystemMouseCursors.resizeUpLeftDownRight;
      case _TLDragMode.resizeRight:
        return SystemMouseCursors.resizeLeftRight;
      case _TLDragMode.resizeBottom:
        return SystemMouseCursors.resizeUpDown;
      case _TLDragMode.move:
        return SystemMouseCursors.move;
    }
  }

  @override
  Widget build(BuildContext context) {
    final layer = widget.layer;
    final props = layer.properties ?? {};
    final text = props['text'] as String? ?? '';
    final fontSize = (props['fontSize'] as num?)?.toDouble() ?? 18.0;
    final colorHex = props['color'] as String? ?? '#1A1A2E';
    final bold = props['bold'] as bool? ?? false;
    final italic = props['italic'] as bool? ?? false;
    final align = props['align'] as String? ?? 'center';
    final softWrap = props['softWrap'] as bool? ?? true;
    final maxLines = softWrap ? null : (props['maxLines'] as int? ?? 1);

    final color = Color(
      int.parse('FF${colorHex.replaceFirst('#', '')}', radix: 16),
    );
    final textAlign = switch (align) {
      'left' => TextAlign.left,
      'right' => TextAlign.right,
      _ => TextAlign.center,
    };

    final primary = Theme.of(context).colorScheme.primary;

    return Positioned(
      left: layer.x * widget.canvasW,
      top: layer.y * widget.canvasH,
      width: _boxW,
      height: _boxH,
      child: MouseRegion(
        cursor: _cursorFor(_hoverPos),
        onHover: (e) {
          if (!widget.isSelected) return;
          setState(() => _hoverPos = e.localPosition);
        },
        child: GestureDetector(
          onTap: widget.onTap,
          onPanStart: (d) {
            _mode = _modeFor(d.localPosition);
            if (!widget.isSelected) {
              widget.onTap();
            } else if (_mode == _TLDragMode.move) {
              setState(() => _isDragMoving = true);
            }
          },
          onPanEnd: (_) {
            if (_isDragMoving) setState(() => _isDragMoving = false);
          },
          onPanCancel: () {
            if (_isDragMoving) setState(() => _isDragMoving = false);
          },
          onPanUpdate: (d) {
            if (!widget.isSelected) return;
            final dx = d.delta.dx;
            final dy = d.delta.dy;
            switch (_mode) {
              case _TLDragMode.move:
                final newX = (layer.x + dx / widget.canvasW).clamp(
                  0.0,
                  1.0 - layer.width,
                );
                final newY = (layer.y + dy / widget.canvasH).clamp(
                  0.0,
                  1.0 - layer.height,
                );
                widget.onPositionChanged(newX, newY);
              case _TLDragMode.resizeRight:
                final newW = (layer.width + dx / widget.canvasW).clamp(
                  0.05,
                  1.0 - layer.x,
                );
                widget.onWidthChanged(newW);
              case _TLDragMode.resizeBottom:
                final newH = (layer.height + dy / widget.canvasH).clamp(
                  0.02,
                  1.0 - layer.y,
                );
                widget.onHeightChanged(newH);
              case _TLDragMode.resizeCorner:
                final newW = (layer.width + dx / widget.canvasW).clamp(
                  0.05,
                  1.0 - layer.x,
                );
                final newH = (layer.height + dy / widget.canvasH).clamp(
                  0.02,
                  1.0 - layer.y,
                );
                widget.onWidthChanged(newW);
                widget.onHeightChanged(newH);
            }
          },
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // ── 距离参考线（移动时显示）──────────────────────
              if (_isDragMoving)
                Positioned(
                  left: -(layer.x * widget.canvasW),
                  top: -(layer.y * widget.canvasH),
                  width: widget.canvasW,
                  height: widget.canvasH,
                  child: IgnorePointer(
                    child: CustomPaint(
                      painter: _DistanceGuidePainter(
                        layer: layer,
                        canvasW: widget.canvasW,
                        canvasH: widget.canvasH,
                        color: primary,
                      ),
                    ),
                  ),
                ),

              // ── 文字内容 + 选中边框 ──────────────────────────
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: widget.isSelected ? primary : Colors.transparent,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    text,
                    textAlign: textAlign,
                    softWrap: softWrap,
                    maxLines: maxLines,
                    overflow: softWrap
                        ? TextOverflow.clip
                        : TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: fontSize,
                      color: color,
                      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                      fontStyle: italic ? FontStyle.italic : FontStyle.normal,
                    ),
                  ),
                ),
              ),

              // ── 右边缘缩放指示条 ──────────────────────────────
              if (widget.isSelected)
                Positioned(
                  right: 0,
                  top: _boxH * 0.25,
                  height: _boxH * 0.5,
                  width: _handleThick,
                  child: Container(
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),

              // ── 底边缘缩放指示条 ──────────────────────────────
              if (widget.isSelected)
                Positioned(
                  bottom: 0,
                  left: _boxW * 0.25,
                  width: _boxW * 0.5,
                  height: _handleThick,
                  child: Container(
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),

              // ── 右下角缩放手柄（方块）────────────────────────
              if (widget.isSelected)
                Positioned(
                  right: 0,
                  bottom: 0,
                  width: _cornerSize,
                  height: _cornerSize,
                  child: Container(
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: const Icon(
                      Icons.open_in_full,
                      size: 9,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── 距离参考线 Painter ──────────────────────────────────────────────────
class _DistanceGuidePainter extends CustomPainter {
  const _DistanceGuidePainter({
    required this.layer,
    required this.canvasW,
    required this.canvasH,
    required this.color,
  });

  final Layer layer;
  final double canvasW;
  final double canvasH;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = color.withValues(alpha: 0.75)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final lx = layer.x * canvasW;
    final ty = layer.y * canvasH;
    final rx = lx + layer.width * canvasW;
    final by = ty + layer.height * canvasH;
    final midX = (lx + rx) / 2;
    final midY = (ty + by) / 2;

    // 左
    if (lx > 2) {
      _dashed(canvas, linePaint, Offset(0, midY), Offset(lx, midY));
      _label(
        canvas,
        '${(layer.x * 100).toStringAsFixed(1)}%',
        Offset(lx / 2, midY),
      );
    }
    // 右
    if (rx < canvasW - 2) {
      _dashed(canvas, linePaint, Offset(rx, midY), Offset(canvasW, midY));
      _label(
        canvas,
        '${((1 - layer.x - layer.width) * 100).toStringAsFixed(1)}%',
        Offset((rx + canvasW) / 2, midY),
      );
    }
    // 上
    if (ty > 2) {
      _dashed(canvas, linePaint, Offset(midX, 0), Offset(midX, ty));
      _label(
        canvas,
        '${(layer.y * 100).toStringAsFixed(1)}%',
        Offset(midX, ty / 2),
      );
    }
    // 下
    if (by < canvasH - 2) {
      _dashed(canvas, linePaint, Offset(midX, by), Offset(midX, canvasH));
      _label(
        canvas,
        '${((1 - layer.y - layer.height) * 100).toStringAsFixed(1)}%',
        Offset(midX, (by + canvasH) / 2),
      );
    }
  }

  void _dashed(Canvas canvas, Paint paint, Offset a, Offset b) {
    const dash = 4.0, gap = 3.0;
    final dx = b.dx - a.dx, dy = b.dy - a.dy;
    final len = math.sqrt(dx * dx + dy * dy);
    if (len == 0) return;
    final ux = dx / len, uy = dy / len;
    var pos = 0.0;
    var drawing = true;
    while (pos < len) {
      final seg = math.min(pos + (drawing ? dash : gap), len);
      if (drawing) {
        canvas.drawLine(
          Offset(a.dx + ux * pos, a.dy + uy * pos),
          Offset(a.dx + ux * seg, a.dy + uy * seg),
          paint,
        );
      }
      pos = seg;
      drawing = !drawing;
    }
  }

  void _label(Canvas canvas, String text, Offset center) {
    final bgPaint = Paint()..color = const Color(0xCCFFFFFF);
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w600,
          height: 1.2,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    const pad = 3.0;
    final rect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: center,
        width: tp.width + pad * 2,
        height: tp.height + pad * 2,
      ),
      const Radius.circular(3),
    );
    canvas.drawRRect(rect, bgPaint);
    tp.paint(canvas, center - Offset(tp.width / 2, tp.height / 2));
  }

  @override
  bool shouldRepaint(_DistanceGuidePainter old) =>
      old.layer.x != layer.x ||
      old.layer.y != layer.y ||
      old.layer.width != layer.width ||
      old.layer.height != layer.height ||
      old.color != color;
}

// ── 空状态占位 ────────────────────────────────────────────────────────────
class _Placeholder extends StatelessWidget {
  const _Placeholder();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.touch_app_outlined,
          size: 64,
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
        const SizedBox(height: 12),
        Text(
          '从左侧选择场景',
          style: TextStyle(color: Theme.of(context).colorScheme.outlineVariant),
        ),
      ],
    );
  }
}
