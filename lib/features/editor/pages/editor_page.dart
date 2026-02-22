import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart' as p;

import 'package:app_kit/core/di/repository_providers.dart';
import 'package:app_kit/core/di/usecase_providers.dart';
import 'package:app_kit/core/domain/usecases/save_project_usecase.dart';
import 'package:app_kit/features/editor/canvas/canvas_area.dart';
import 'package:app_kit/features/editor/left_panel/left_panel.dart';
import 'package:app_kit/features/editor/providers/editor_provider.dart';
import 'package:app_kit/features/editor/right_panel/right_panel.dart';
import 'package:app_kit/features/editor/widgets/editor_toolbar.dart';
import 'package:app_kit/features/home/providers/recent_projects_provider.dart';
import 'package:app_kit/shared/constants/app_constants.dart';

class EditorPage extends HookConsumerWidget {
  const EditorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.keyS, control: true): () =>
            _quickSave(context, ref),
      },
      child: Focus(
        autofocus: true,
        child: Scaffold(
          body: Column(
            children: [
              const EditorToolbar(),
              const Divider(height: 1),
              Expanded(
                child: Row(
                  children: [
                    // ── Left panel: device list / scene list ─────────
                    SizedBox(
                      width: AppConstants.leftPanelWidth,
                      child: const LeftPanel(),
                    ),
                    const VerticalDivider(width: 1),

                    // ── Center: canvas area ───────────────────────────
                    const Expanded(child: CanvasArea()),

                    const VerticalDivider(width: 1),

                    // ── Right panel: properties ───────────────────────
                    SizedBox(
                      width: AppConstants.rightPanelWidth,
                      child: const RightPanel(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Ctrl+S：已有保存路径则直接覆盖，否则提示用工具栏保存按钮
  Future<void> _quickSave(BuildContext context, WidgetRef ref) async {
    final project = ref.read(editorProjectProvider);
    if (project == null) return;
    final path = project.savedPath;
    if (path == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('请先点击工具栏保存按钮指定保存路径')));
      return;
    }
    try {
      await ref.read(saveProjectUseCaseProvider)(
        SaveProjectParams(project: project, path: path),
      );
      await ref.read(projectRepositoryProvider).addRecentProjectPath(path);
      ref.invalidate(recentProjectsProvider);
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('已保存：${p.basename(path)}')));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('保存失败：$e'), backgroundColor: Colors.red),
        );
      }
    }
  }
}
