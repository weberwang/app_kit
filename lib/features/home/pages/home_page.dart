import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:app_kit/core/di/usecase_providers.dart';
import 'package:app_kit/features/editor/providers/editor_provider.dart';
import 'package:app_kit/features/home/providers/recent_projects_provider.dart';
import 'package:app_kit/shared/constants/app_constants.dart';
import 'package:app_kit/shared/router/app_router.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentAsync = ref.watch(recentProjectsProvider);

    return Scaffold(
      body: Row(
        children: [
          // ── Left sidebar ──────────────────────────────────────
          SizedBox(
            width: AppConstants.leftPanelWidth,
            child: _LeftSidebar(
              onNewProject: () => _onNewProject(context, ref),
              onOpenProject: () => _onOpenProject(context, ref),
            ),
          ),

          const VerticalDivider(width: 1),

          // ── Main content ──────────────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _HomeToolbar(),
                Expanded(
                  child: recentAsync.when(
                    data: (paths) => paths.isEmpty
                        ? const _EmptyState()
                        : _RecentProjectsGrid(paths: paths),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (e, _) => Center(child: Text('$e')),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onNewProject(BuildContext context, WidgetRef ref) {
    showDialog<String>(
      context: context,
      builder: (ctx) {
        final controller = TextEditingController(text: '未命名项目');
        return AlertDialog(
          title: const Text('新建项目'),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(labelText: '项目名称'),
            onSubmitted: (_) => Navigator.of(ctx).pop(controller.text),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('取消'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(ctx).pop(controller.text),
              child: const Text('创建'),
            ),
          ],
        );
      },
    ).then((name) {
      if (name == null || name.trim().isEmpty) return;
      ref.read(editorProjectProvider.notifier).createNew(name.trim());
      if (context.mounted) context.go(AppRouter.editorRoute);
    });
  }

  Future<void> _onOpenProject(BuildContext context, WidgetRef ref) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['appkit'],
      dialogTitle: '打开 App Kit 项目',
    );
    if (result == null || result.files.isEmpty) return;
    final path = result.files.first.path;
    if (path == null) return;

    try {
      final usecase = ref.read(loadProjectUseCaseProvider);
      final project = await usecase(path);
      ref.read(editorProjectProvider.notifier).load(project);
      if (context.mounted) context.go(AppRouter.editorRoute);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('打开失败：$e'), backgroundColor: Colors.red),
        );
      }
    }
  }
}

class _LeftSidebar extends StatelessWidget {
  const _LeftSidebar({required this.onNewProject, required this.onOpenProject});

  final VoidCallback onNewProject;
  final VoidCallback onOpenProject;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ColoredBox(
      color: cs.surfaceContainerLow,
      child: Column(
        children: [
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                FilledButton.icon(
                  onPressed: onNewProject,
                  icon: const Icon(Icons.add),
                  label: const Text('新建项目'),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(44),
                  ),
                ),
                const SizedBox(height: 8),
                OutlinedButton.icon(
                  onPressed: onOpenProject,
                  icon: const Icon(Icons.folder_open),
                  label: const Text('打开项目'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(44),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeToolbar extends StatelessWidget {
  const _HomeToolbar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConstants.toolbarHeight,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text('最近项目', style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.photo_library_outlined, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text('暂无最近项目', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}

class _RecentProjectsGrid extends StatelessWidget {
  const _RecentProjectsGrid({required this.paths});

  final List<String> paths;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 240,
        mainAxisExtent: 180,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: paths.length,
      itemBuilder: (context, i) => _ProjectCard(path: paths[i]),
    );
  }
}

class _ProjectCard extends ConsumerWidget {
  const _ProjectCard({required this.path});

  final String path;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = path.split(RegExp(r'[/\\]')).last.replaceAll('.appkit', '');
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () async {
          try {
            final usecase = ref.read(loadProjectUseCaseProvider);
            final project = await usecase(path);
            ref.read(editorProjectProvider.notifier).load(project);
            if (context.mounted) context.go(AppRouter.editorRoute);
          } catch (e) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('打开失败：$e'), backgroundColor: Colors.red),
              );
            }
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: const Icon(Icons.photo_library_outlined, size: 40),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
