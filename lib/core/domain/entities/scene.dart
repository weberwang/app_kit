import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:app_kit/core/domain/entities/layer.dart';

part 'scene.freezed.dart';
part 'scene.g.dart';

enum BackgroundType { solid, linearGradient, radialGradient }

@freezed
sealed class Scene with _$Scene {
  const factory Scene({
    required String id,
    required String name,
    required String deviceId,
    @Default([]) List<Layer> layers,
    String? screenshotPath,
    // 背景配置
    @Default(BackgroundType.solid) BackgroundType backgroundType,
    @Default('#FFFFFF') String backgroundColor,
    @Default(['#4A90D9', '#1A3C6E']) List<String> gradientColors,
    @Default(135.0) double gradientAngle,
    // 设备框架距顶部偏移（0.0-1.0，相对画布高度），默认 0.10
    @Default(0.10) double deviceOffsetTop,
  }) = _Scene;

  factory Scene.fromJson(Map<String, dynamic> json) => _$SceneFromJson(json);
}
