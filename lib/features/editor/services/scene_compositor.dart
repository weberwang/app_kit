import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:device_frame_plus/device_frame_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' hide Layer;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:app_kit/core/domain/entities/layer.dart';
import 'package:app_kit/core/domain/entities/scene.dart';
import 'package:app_kit/shared/constants/device_catalog.dart';

part 'scene_compositor.g.dart';

@riverpod
SceneCompositor sceneCompositor(Ref ref) => SceneCompositor._();

/// 离屏合成场景画面，捕获为 PNG 字节。
/// 原理：将场景 Widget 挂到 Overlay 的屏幕外位置，等一帧后用
/// RenderRepaintBoundary.toImage() 截图，然后移除 Overlay entry。
class SceneCompositor {
  SceneCompositor._();

  /// 渲染单个 [scene]（使用 [deviceId] 设备型号），返回 PNG 字节。
  /// [context] 必须能访问到 Overlay（editor page 内传入即可）。
  /// [canvasW]/[canvasH] 应与当前画布预设一致，[pixelRatio] 决定输出分辨率。
  Future<List<int>> render(
    BuildContext context,
    Scene scene,
    String deviceId, {
    double canvasW = 440,
    double canvasH = 956,
    double pixelRatio = 3.0,
  }) async {
    // ① 预加载截图到 Flutter 图片缓存，确保离屏渲染时同步可用
    if (scene.screenshotPath != null) {
      try {
        await precacheImage(FileImage(File(scene.screenshotPath!)), context);
      } catch (_) {
        // 图片加载失败则忽略，后续渲染会显示白色占位
      }
    }

    if (!context.mounted) return [];

    final key = GlobalKey();
    final completer = Completer<List<int>>();
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (_) => Positioned(
        left: -(canvasW * pixelRatio * 2), // 屏幕左侧极远处，不可见
        top: 0,
        width: canvasW,
        height: canvasH,
        child: RepaintBoundary(
          key: key,
          child: _OffscreenScene(
            scene: scene,
            deviceId: deviceId,
            canvasW: canvasW,
            canvasH: canvasH,
          ),
        ),
      ),
    );

    // ignore: use_build_context_synchronously
    Overlay.of(context).insert(entry);

    // ② 等 4 帧：DeviceFrame 内部 layout 需要额外帧才能完成 paint
    void waitFrames(int remaining, void Function() done) {
      if (remaining <= 0) {
        done();
        return;
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        waitFrames(remaining - 1, done);
      });
    }

    waitFrames(4, () async {
      try {
        final ro = key.currentContext?.findRenderObject();
        if (ro is RenderRepaintBoundary) {
          final img = await ro.toImage(pixelRatio: pixelRatio);
          final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
          completer.complete(byteData?.buffer.asUint8List().toList() ?? []);
        } else {
          completer.complete([]);
        }
      } catch (e, st) {
        completer.completeError(e, st);
      } finally {
        entry.remove();
      }
    });

    // ③ 10 秒超时保护，防止永久 hang
    return completer.future.timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        entry.remove();
        return [];
      },
    );
  }
}

// ── 离屏场景 Widget（与 canvas_area._SceneCanvas 保持一致）──────────────────
class _OffscreenScene extends StatelessWidget {
  const _OffscreenScene({
    required this.scene,
    required this.deviceId,
    required this.canvasW,
    required this.canvasH,
  });

  final Scene scene;
  final String deviceId;
  final double canvasW;
  final double canvasH;

  @override
  Widget build(BuildContext context) {
    final screen = scene.screenshotPath != null
        ? SizedBox.expand(
            child: Image.file(File(scene.screenshotPath!), fit: BoxFit.fill),
          )
        : const ColoredBox(color: Colors.white);

    final textLayers = scene.layers
        .where((l) => l.type == LayerType.text)
        .toList();

    return SizedBox(
      width: canvasW,
      height: canvasH,
      child: ClipRect(
        child: Stack(
          children: [
            // ── 背景 ──────────────────────────────────────────
            Positioned.fill(child: _BgPainter(scene: scene)),

            // ── 设备框架 ──────────────────────────────────────
            Positioned(
              top: scene.deviceOffsetTop * canvasH,
              left: canvasW * 0.06,
              right: canvasW * 0.06,
              height: canvasH,
              child: DeviceFrame(
                device: DeviceCatalog.frameFor(deviceId),
                screen: screen,
              ),
            ),

            // ── 文字图层 ──────────────────────────────────────
            ...textLayers.map(
              (l) => _TextLayer(layer: l, canvasW: canvasW, canvasH: canvasH),
            ),
          ],
        ),
      ),
    );
  }
}

class _BgPainter extends StatelessWidget {
  const _BgPainter({required this.scene});
  final Scene scene;

  static Color _hex(String h) =>
      Color(int.parse('FF${h.replaceFirst('#', '')}', radix: 16));

  @override
  Widget build(BuildContext context) {
    switch (scene.backgroundType) {
      case BackgroundType.solid:
        return ColoredBox(color: _hex(scene.backgroundColor));

      case BackgroundType.linearGradient:
        final a = scene.gradientAngle * math.pi / 180;
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(
                -math.cos(a).clamp(-1.0, 1.0),
                -math.sin(a).clamp(-1.0, 1.0),
              ),
              end: Alignment(
                math.cos(a).clamp(-1.0, 1.0),
                math.sin(a).clamp(-1.0, 1.0),
              ),
              colors: scene.gradientColors.map(_hex).toList(),
            ),
          ),
        );

      case BackgroundType.radialGradient:
        return Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: scene.gradientColors.map(_hex).toList(),
            ),
          ),
        );
    }
  }
}

class _TextLayer extends StatelessWidget {
  const _TextLayer({
    required this.layer,
    required this.canvasW,
    required this.canvasH,
  });

  final Layer layer;
  final double canvasW;
  final double canvasH;

  @override
  Widget build(BuildContext context) {
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

    return Positioned(
      left: layer.x * canvasW,
      top: layer.y * canvasH,
      width: layer.width * canvasW,
      height: layer.height * canvasH,
      child: Text(
        text,
        textAlign: textAlign,
        softWrap: softWrap,
        maxLines: maxLines,
        overflow: softWrap ? TextOverflow.clip : TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          fontStyle: italic ? FontStyle.italic : FontStyle.normal,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }
}
