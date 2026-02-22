import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'package:app_kit/core/di/repository_providers.dart';
import 'package:app_kit/core/di/usecase_providers.dart';
import 'package:app_kit/core/domain/entities/export_config.dart';
import 'package:app_kit/core/domain/usecases/import_from_directory_usecase.dart';
import 'package:app_kit/core/domain/usecases/save_project_usecase.dart';
import 'package:app_kit/features/editor/providers/editor_provider.dart';
import 'package:app_kit/features/editor/services/scene_compositor.dart';
import 'package:app_kit/features/home/providers/recent_projects_provider.dart';
import 'package:app_kit/shared/constants/app_constants.dart';
import 'package:app_kit/shared/constants/canvas_presets.dart';
import 'package:app_kit/shared/router/app_router.dart';

/// 编辑器顶部工具栏
class EditorToolbar extends HookConsumerWidget {
  const EditorToolbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final project = ref.watch(editorProjectProvider);
    final projectName = project?.name ?? '未命名项目';

    return Container(
      height: AppConstants.toolbarHeight,
      color: cs.surfaceContainerLow,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          // 返回主页（go_router）
          IconButton(
            icon: const Icon(Icons.arrow_back),
            tooltip: '返回',
            onPressed: () => context.go(AppRouter.homeRoute),
          ),
          const SizedBox(width: 8),
          // 项目名称（可点击重命名）
          GestureDetector(
            onTap: () => _renameDialog(context, ref, projectName),
            child: Text(
              projectName,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          const Spacer(),
          // 撤销 / 重做
          IconButton(
            icon: const Icon(Icons.undo),
            tooltip: '撤销 (Ctrl+Z)',
            onPressed: null, // TODO: undo stack
          ),
          IconButton(
            icon: const Icon(Icons.redo),
            tooltip: '重做 (Ctrl+Y)',
            onPressed: null, // TODO: undo stack
          ),
          const SizedBox(width: 4),
          // 批量目录导入
          IconButton(
            icon: const Icon(Icons.folder_open_outlined),
            tooltip: '从目录导入截图',
            onPressed: project == null ? null : () => _import(context, ref),
          ),
          const SizedBox(width: 4),
          // 画布尺寸预设
          Consumer(
            builder: (ctx, r, _) {
              final preset = r.watch(activeCanvasPresetProvider);
              return OutlinedButton.icon(
                icon: const Icon(Icons.photo_size_select_large, size: 16),
                label: Text(preset.name, style: const TextStyle(fontSize: 12)),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  visualDensity: VisualDensity.compact,
                ),
                onPressed: () => _showPresetPicker(ctx, r),
              );
            },
          ),
          const SizedBox(width: 8),
          // 保存
          IconButton(
            icon: const Icon(Icons.save_outlined),
            tooltip: '保存 (Ctrl+S)',
            onPressed: project == null ? null : () => _save(context, ref),
          ),
          const SizedBox(width: 4),
          // 导出
          FilledButton.icon(
            icon: const Icon(Icons.download, size: 18),
            label: const Text('导出'),
            onPressed: project == null ? null : () => _export(context, ref),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Future<void> _showPresetPicker(BuildContext context, WidgetRef ref) async {
    final current = ref.read(activeCanvasPresetProvider);
    final selected = await showDialog<CanvasSizePreset>(
      context: context,
      builder: (ctx) => _CanvasPresetDialog(current: current),
    );
    if (selected != null) {
      ref.read(activeCanvasPresetProvider.notifier).select(selected);
    }
  }

  Future<void> _renameDialog(
    BuildContext context,
    WidgetRef ref,
    String current,
  ) async {
    final controller = TextEditingController(text: current);
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('重命名项目'),
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
            child: const Text('确认'),
          ),
        ],
      ),
    );
    if (result != null && result.trim().isNotEmpty) {
      ref.read(editorProjectProvider.notifier).updateName(result.trim());
    }
  }

  Future<void> _save(BuildContext context, WidgetRef ref) async {
    final project = ref.read(editorProjectProvider);
    if (project == null) return;

    // 如果已有保存路径则直接覆盖，否则弹出另存为对话框
    String? path = project.savedPath;
    if (path == null) {
      final docs = await getApplicationDocumentsDirectory();
      final result = await FilePicker.platform.saveFile(
        dialogTitle: '保存项目',
        fileName: '${project.name}${AppConstants.projectExtension}',
        initialDirectory: docs.path,
        type: FileType.custom,
        allowedExtensions: ['appkit'],
      );
      if (result == null) return;
      path = result.endsWith(AppConstants.projectExtension)
          ? result
          : '$result${AppConstants.projectExtension}';
    }

    try {
      await ref.read(saveProjectUseCaseProvider)(
        SaveProjectParams(project: project, path: path),
      );
      // 更新 savedPath 并记入最近列表
      ref.read(editorProjectProvider.notifier).setSavedPath(path);
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

  Future<void> _export(BuildContext context, WidgetRef ref) async {
    final project = ref.read(editorProjectProvider);
    if (project == null) return;

    final config = await showDialog<ExportConfig>(
      context: context,
      builder: (ctx) => const _ExportDialog(),
    );
    if (config == null || !context.mounted) return;

    final deviceId = ref.read(selectedDeviceIdProvider);
    final compositor = ref.read(sceneCompositorProvider);
    final messenger = ScaffoldMessenger.of(context);

    // 计算总数以显示进度
    final totalScenes = project.localeGroups.fold(
      0,
      (s, g) => s + g.scenes.length,
    );
    var done = 0;

    messenger.showSnackBar(
      SnackBar(
        content: StatefulBuilder(
          builder: (_, setState) => Row(
            children: [
              const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              const SizedBox(width: 12),
              Text('正在导出 0 / $totalScenes…'),
            ],
          ),
        ),
        duration: const Duration(seconds: 120),
      ),
    );

    try {
      final allFiles = <String>[];

      for (final group in project.localeGroups) {
        final outputDir = config.organizeByLocale
            ? '${config.outputDirectory}${p.separator}${group.locale}'
            : config.outputDirectory;
        await Directory(outputDir).create(recursive: true);

        for (var i = 0; i < group.scenes.length; i++) {
          final scene = group.scenes[i];
          if (!context.mounted) break;

          // 离屏合成，借用预设的 pixelRatio + 画布尺寸
          final preset = ref.read(activeCanvasPresetProvider);
          final bytes = await compositor.render(
            context,
            scene,
            deviceId,
            canvasW: preset.width,
            canvasH: preset.height,
            pixelRatio: preset.exportPixelRatio,
          );

          final ext = config.format.name; // 'png' | 'jpg'
          final dest = '$outputDir${p.separator}screenshot_${i + 1}.$ext';
          await File(dest).writeAsBytes(bytes);
          allFiles.add(dest);
          done++;

          // 最后一张不刷新进度（后续直接显示完成）
          if (done < totalScenes) {
            messenger.hideCurrentSnackBar();
            messenger.showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    const SizedBox(width: 12),
                    Text('正在导出 $done / $totalScenes…'),
                  ],
                ),
                duration: const Duration(seconds: 120),
              ),
            );
          }
        }
      }

      // 打包 ZIP
      if (config.createZip) {
        final zipPath =
            '${config.outputDirectory}${p.separator}${project.name}_export.zip';
        await ref
            .read(exportRepositoryProvider)
            .packageToZip(filePaths: allFiles, outputPath: zipPath);
      }

      messenger.clearSnackBars();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('导出完成：$done 张图片'),
            action: SnackBarAction(
              label: '打开文件夹',
              onPressed: () => OpenFilex.open(config.outputDirectory),
            ),
            duration: const Duration(seconds: 8),
          ),
        );
      }
    } catch (e) {
      messenger.clearSnackBars();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('导出失败：$e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> _import(BuildContext context, WidgetRef ref) async {
    final project = ref.read(editorProjectProvider);
    if (project == null) return;

    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => _ImportDialog(project: project, ref: ref),
    );

    if (result == true && context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('截图已导入')));
    }
  }
}

// ── Export config dialog ───────────────────────────────────────────────────

class _ExportDialog extends StatefulWidget {
  const _ExportDialog();
  @override
  State<_ExportDialog> createState() => _ExportDialogState();
}

class _ExportDialogState extends State<_ExportDialog> {
  // static 字段跨对话框实例保留上次设置
  static ExportFormat _lastFormat = ExportFormat.png;
  static double _lastPixelRatio = 3.0;
  static bool _lastCreateZip = false;
  static bool _lastOrganizeByLocale = true;
  static String? _lastOutputDir;

  late ExportFormat _format;
  late double _pixelRatio;
  late bool _createZip;
  late bool _organizeByLocale;
  String? _outputDir;

  @override
  void initState() {
    super.initState();
    _format = _lastFormat;
    _pixelRatio = _lastPixelRatio;
    _createZip = _lastCreateZip;
    _organizeByLocale = _lastOrganizeByLocale;
    _outputDir = _lastOutputDir;
  }

  Future<void> _pickDir() async {
    final dir = await FilePicker.platform.getDirectoryPath(
      dialogTitle: '选择导出目录',
    );
    if (dir != null)
      setState(() {
        _outputDir = dir;
        _lastOutputDir = dir;
      });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('导出设置'),
      content: SizedBox(
        width: 360,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 输出目录
            Row(
              children: [
                Expanded(
                  child: Text(
                    _outputDir ?? '请选择目录',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: _outputDir == null
                          ? Theme.of(context).colorScheme.error
                          : null,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                OutlinedButton(onPressed: _pickDir, child: const Text('选择')),
              ],
            ),
            const SizedBox(height: 16),
            // 格式
            DropdownButtonFormField<ExportFormat>(
              value: _format,
              decoration: const InputDecoration(
                labelText: '图片格式',
                border: OutlineInputBorder(),
                isDense: true,
              ),
              items: ExportFormat.values
                  .map(
                    (f) => DropdownMenuItem(
                      value: f,
                      child: Text(f.name.toUpperCase()),
                    ),
                  )
                  .toList(),
              onChanged: (v) => setState(() {
                _format = v!;
                _lastFormat = v;
              }),
            ),
            const SizedBox(height: 12),
            // 分辨率
            Row(
              children: [
                const Text('分辨率倍率：'),
                Expanded(
                  child: Slider(
                    value: _pixelRatio,
                    min: 1,
                    max: 4,
                    divisions: 3,
                    label: '${_pixelRatio.toInt()}x',
                    onChanged: (v) => setState(() {
                      _pixelRatio = v;
                      _lastPixelRatio = v;
                    }),
                  ),
                ),
                Text('${_pixelRatio.toInt()}x'),
              ],
            ),
            // 选项
            CheckboxListTile(
              dense: true,
              title: const Text('按语言分文件夹'),
              value: _organizeByLocale,
              onChanged: (v) => setState(() {
                _organizeByLocale = v!;
                _lastOrganizeByLocale = v;
              }),
            ),
            CheckboxListTile(
              dense: true,
              title: const Text('打包为 ZIP'),
              value: _createZip,
              onChanged: (v) => setState(() {
                _createZip = v!;
                _lastCreateZip = v;
              }),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('取消'),
        ),
        FilledButton(
          onPressed: _outputDir == null
              ? null
              : () => Navigator.of(context).pop(
                  ExportConfig(
                    outputDirectory: _outputDir!,
                    format: _format,
                    pixelRatio: _pixelRatio,
                    createZip: _createZip,
                    organizeByLocale: _organizeByLocale,
                  ),
                ),
          child: const Text('开始导出'),
        ),
      ],
    );
  }
}
// ── Locale import dialog ───────────────────────────────────────────────────

class _ImportDialog extends ConsumerStatefulWidget {
  const _ImportDialog({required this.project, required this.ref});
  final dynamic project; // AppKitProject
  final WidgetRef ref;

  @override
  ConsumerState<_ImportDialog> createState() => _ImportDialogState();
}

class _ImportDialogState extends ConsumerState<_ImportDialog> {
  String? _directoryPath;
  List<String> _detectedLocales = [];
  final Set<String> _selected = {};
  bool _detecting = false;
  bool _importing = false;

  Future<void> _pickDirectory() async {
    final path = await FilePicker.platform.getDirectoryPath(
      dialogTitle: '选择截图根目录',
    );
    if (path == null) return;
    setState(() {
      _directoryPath = path;
      _detectedLocales = [];
      _selected.clear();
      _detecting = true;
    });
    try {
      final locales = await ref
          .read(localeImportRepositoryProvider)
          .detectLocalesFromDirectory(path);
      setState(() {
        _detectedLocales = locales;
        _selected.addAll(locales);
        _detecting = false;
      });
    } catch (_) {
      setState(() => _detecting = false);
    }
  }

  Future<void> _doImport() async {
    if (_directoryPath == null || _selected.isEmpty) return;
    setState(() => _importing = true);
    try {
      final usecase = ref.read(importFromDirectoryUseCaseProvider);
      final updated = await usecase(
        ImportFromDirectoryParams(
          project: widget.project,
          directoryPath: _directoryPath!,
          selectedLocales: _selected.toList(),
        ),
      );
      ref.read(editorProjectProvider.notifier).load(updated);
      if (mounted) Navigator.of(context).pop(true);
    } catch (e) {
      setState(() => _importing = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('导入失败：$e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('从目录导入截图'),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('请选择包含 locale 子目录的根目录（如 en/、zh-CN/）'),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _directoryPath ?? '未选择目录',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  icon: const Icon(Icons.folder_open, size: 16),
                  label: const Text('选择'),
                  onPressed: _importing ? null : _pickDirectory,
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (_detecting)
              const Center(child: CircularProgressIndicator())
            else if (_directoryPath != null && _detectedLocales.isEmpty)
              const Text('未检测到 locale 子目录', style: TextStyle(color: Colors.red))
            else if (_detectedLocales.isNotEmpty) ...[
              const Text('检测到以下 Locale，选择要导入的：'),
              const SizedBox(height: 4),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 200),
                child: SingleChildScrollView(
                  child: Column(
                    children: _detectedLocales
                        .map(
                          (l) => CheckboxListTile(
                            dense: true,
                            title: Text(l),
                            value: _selected.contains(l),
                            onChanged: _importing
                                ? null
                                : (v) => setState(
                                    () => v!
                                        ? _selected.add(l)
                                        : _selected.remove(l),
                                  ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _importing ? null : () => Navigator.of(context).pop(false),
          child: const Text('取消'),
        ),
        FilledButton(
          onPressed: _importing || _selected.isEmpty ? null : _doImport,
          child: _importing
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('导入'),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 画布尺寸预设选择对话框
// ─────────────────────────────────────────────────────────────────────────────
class _CanvasPresetDialog extends StatelessWidget {
  const _CanvasPresetDialog({required this.current});
  final CanvasSizePreset current;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('选择画布尺寸'),
      contentPadding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
      content: SizedBox(
        width: 420,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGroup(
                context,
                '🍎  App Store 必需尺寸',
                CanvasPresets.appStorePresets,
              ),
              const SizedBox(height: 12),
              _buildGroup(
                context,
                '▶  Google Play 常用尺寸',
                CanvasPresets.googlePlayPresets,
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('取消'),
        ),
      ],
    );
  }

  Widget _buildGroup(
    BuildContext context,
    String title,
    List<CanvasSizePreset> presets,
  ) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(
            title,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: cs.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...presets.map((preset) {
          final selected = preset == current;
          return ListTile(
            dense: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            selected: selected,
            selectedTileColor: cs.primaryContainer.withValues(alpha: 0.4),
            leading: selected
                ? Icon(Icons.check_circle, color: cs.primary, size: 20)
                : const Icon(Icons.radio_button_unchecked, size: 20),
            title: Text(preset.name),
            subtitle: Text(
              '${preset.displaySize}  →  导出 ${preset.exportSizeLabel}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            onTap: () => Navigator.of(context).pop(preset),
          );
        }),
      ],
    );
  }
}
