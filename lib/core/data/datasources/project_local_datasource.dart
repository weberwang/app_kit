import 'dart:convert';
import 'dart:io';

import 'package:app_kit/core/domain/entities/app_kit_project.dart';

abstract interface class ProjectLocalDataSource {
  Future<AppKitProject> readProject(String path);
  Future<void> writeProject(AppKitProject project, String path);
}

final class ProjectLocalDataSourceImpl implements ProjectLocalDataSource {
  const ProjectLocalDataSourceImpl();

  @override
  Future<AppKitProject> readProject(String path) async {
    final file = File(path);
    final content = await file.readAsString();
    final json = jsonDecode(content) as Map<String, dynamic>;
    return AppKitProject.fromJson(json);
  }

  @override
  Future<void> writeProject(AppKitProject project, String path) async {
    final file = File(path);
    await file.parent.create(recursive: true);
    final content = const JsonEncoder.withIndent(
      '  ',
    ).convert(project.toJson());
    await file.writeAsString(content);
  }
}
