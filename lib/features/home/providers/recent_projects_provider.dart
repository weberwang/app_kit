import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:app_kit/core/di/repository_providers.dart';

part 'recent_projects_provider.g.dart';

@riverpod
Future<List<String>> recentProjects(Ref ref) =>
    ref.watch(projectRepositoryProvider).getRecentProjectPaths();
