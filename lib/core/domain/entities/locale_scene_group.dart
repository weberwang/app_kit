import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:app_kit/core/domain/entities/scene.dart';

part 'locale_scene_group.freezed.dart';
part 'locale_scene_group.g.dart';

@freezed
sealed class LocaleSceneGroup with _$LocaleSceneGroup {
  const factory LocaleSceneGroup({
    required String locale,
    @Default([]) List<Scene> scenes,
  }) = _LocaleSceneGroup;

  factory LocaleSceneGroup.fromJson(Map<String, dynamic> json) =>
      _$LocaleSceneGroupFromJson(json);
}
