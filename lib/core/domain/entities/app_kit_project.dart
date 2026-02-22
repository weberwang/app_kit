import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:app_kit/core/domain/entities/locale_scene_group.dart';

part 'app_kit_project.freezed.dart';
part 'app_kit_project.g.dart';

@freezed
sealed class AppKitProject with _$AppKitProject {
  const factory AppKitProject({
    required String id,
    required String name,
    @Default([]) List<LocaleSceneGroup> localeGroups,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? savedPath,
  }) = _AppKitProject;

  factory AppKitProject.fromJson(Map<String, dynamic> json) =>
      _$AppKitProjectFromJson(json);
}
