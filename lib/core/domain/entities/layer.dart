import 'package:freezed_annotation/freezed_annotation.dart';

part 'layer.freezed.dart';
part 'layer.g.dart';

enum LayerType { screenshot, text, shape, decoration }

@freezed
sealed class Layer with _$Layer {
  const factory Layer({
    required String id,
    required LayerType type,
    required double x,
    required double y,
    required double width,
    required double height,
    @Default(0.0) double rotation,
    @Default(1.0) double opacity,
    @Default(true) bool visible,
    Map<String, dynamic>? properties,
  }) = _Layer;

  factory Layer.fromJson(Map<String, dynamic> json) => _$LayerFromJson(json);
}
