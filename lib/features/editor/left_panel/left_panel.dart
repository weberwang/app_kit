import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:app_kit/core/domain/entities/app_kit_project.dart';
import 'package:app_kit/features/editor/providers/editor_provider.dart';
import 'package:app_kit/shared/constants/device_catalog.dart';

/// 左侧面板：设备选择 + 场景列表
class LeftPanel extends HookConsumerWidget {
  const LeftPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final project = ref.watch(editorProjectProvider);
    final selectedDeviceId = ref.watch(selectedDeviceIdProvider);

    return ColoredBox(
      color: cs.surfaceContainerLow,
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.phone_iphone), text: '设备'),
                Tab(icon: Icon(Icons.photo_library), text: '场景'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // ── Tab 1: 设备列表 ──────────────────────────
                  ListView(
                    padding: const EdgeInsets.all(8),
                    children: DeviceCatalog.devices
                        .map(
                          (d) => _DeviceTile(
                            id: d.id,
                            label: d.label,
                            selected: d.id == selectedDeviceId,
                            onTap: () => ref
                                .read(selectedDeviceIdProvider.notifier)
                                .select(d.id),
                          ),
                        )
                        .toList(),
                  ),
                  // ── Tab 2: 场景列表 ──────────────────────────
                  Column(
                    children: [
                      // 添加截图按钮
                      Padding(
                        padding: const EdgeInsets.all(6),
                        child: SizedBox(
                          width: double.infinity,
                          child: FilledButton.tonalIcon(
                            icon: const Icon(
                              Icons.add_photo_alternate,
                              size: 16,
                            ),
                            label: const Text('添加截图'),
                            style: FilledButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              textStyle: const TextStyle(fontSize: 12),
                            ),
                            onPressed: project == null
                                ? null
                                : () => _addScene(
                                    context,
                                    ref,
                                    project.localeGroups
                                        .map((g) => g.locale)
                                        .toList(),
                                    ref.read(selectedDeviceIdProvider),
                                  ),
                          ),
                        ),
                      ),
                      const Divider(height: 1),
                      Expanded(
                        child: project == null
                            ? const Center(
                                child: Text(
                                  '暂无场景',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              )
                            : _SceneList(ref: ref, project: project),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addScene(
    BuildContext context,
    WidgetRef ref,
    List<String> existingLocales,
    String currentDeviceId,
  ) async {
    // 选择图片文件
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
      dialogTitle: '选择截图',
    );
    if (result == null || result.files.isEmpty) return;

    // 选择/输入语言代码
    String locale = existingLocales.isNotEmpty ? existingLocales.first : 'zh';
    if (context.mounted) {
      final picked = await showDialog<String>(
        context: context,
        builder: (ctx) =>
            _LocalePickerDialog(existing: existingLocales, initial: locale),
      );
      if (picked == null || !context.mounted) return;
      locale = picked;
    }

    String? firstSceneId;
    for (final file in result.files) {
      if (file.path != null) {
        final sceneId = ref
            .read(editorProjectProvider.notifier)
            .addScene(
              locale: locale,
              screenshotPath: file.path!,
              deviceId: currentDeviceId,
            );
        firstSceneId ??= sceneId;
      }
    }
    if (firstSceneId != null) {
      ref.read(selectedSceneIdProvider.notifier).select(firstSceneId);
    }
  }
}

class _DeviceTile extends StatelessWidget {
  const _DeviceTile({
    required this.id,
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final String id;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListTile(
      dense: true,
      selected: selected,
      selectedTileColor: cs.primaryContainer,
      leading: Icon(
        Icons.phone_iphone,
        size: 18,
        color: selected ? cs.primary : null,
      ),
      title: Text(label, style: const TextStyle(fontSize: 13)),
      onTap: onTap,
    );
  }
}

class _SceneList extends StatelessWidget {
  const _SceneList({required this.ref, required this.project});
  final WidgetRef ref;
  final AppKitProject project;

  @override
  Widget build(BuildContext context) {
    final selectedId = ref.watch(selectedSceneIdProvider);
    final allScenes = [
      for (final group in project.localeGroups)
        for (final scene in group.scenes) (locale: group.locale, scene: scene),
    ];

    if (allScenes.isEmpty) {
      return const Center(
        child: Text('暂无场景', style: TextStyle(color: Colors.grey)),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(4),
      itemCount: allScenes.length,
      itemBuilder: (context, i) {
        final item = allScenes[i];
        final isSelected = item.scene.id == selectedId;
        return ListTile(
          dense: true,
          selected: isSelected,
          selectedTileColor: Theme.of(context).colorScheme.primaryContainer,
          leading: const Icon(Icons.image_outlined, size: 18),
          title: Text(item.scene.name, style: const TextStyle(fontSize: 13)),
          subtitle: Text(item.locale, style: const TextStyle(fontSize: 11)),
          trailing: IconButton(
            icon: const Icon(Icons.delete_outline, size: 16),
            tooltip: '删除',
            onPressed: () {
              ref
                  .read(editorProjectProvider.notifier)
                  .removeScene(item.scene.id);
              if (item.scene.id == selectedId) {
                ref.read(selectedSceneIdProvider.notifier).clear();
              }
            },
          ),
          onTap: () =>
              ref.read(selectedSceneIdProvider.notifier).select(item.scene.id),
        );
      },
    );
  }
}

/// 语言选择对话框
class _LocalePickerDialog extends StatefulWidget {
  const _LocalePickerDialog({required this.existing, required this.initial});
  final List<String> existing;
  final String initial;

  @override
  State<_LocalePickerDialog> createState() => _LocalePickerDialogState();
}

class _LocalePickerDialogState extends State<_LocalePickerDialog> {
  late final TextEditingController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: widget.initial);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('选择语言'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.existing.isNotEmpty) ...[
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: widget.existing
                  .map(
                    (l) => ActionChip(
                      label: Text(l),
                      onPressed: () => _ctrl.text = l,
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 12),
            const Text(
              '或输入新语言代码：',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 4),
          ],
          TextField(
            controller: _ctrl,
            autofocus: widget.existing.isEmpty,
            decoration: const InputDecoration(
              hintText: 'zh, en, ja, ko…',
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('取消'),
        ),
        FilledButton(
          onPressed: () {
            final v = _ctrl.text.trim();
            if (v.isNotEmpty) Navigator.of(context).pop(v);
          },
          child: const Text('确定'),
        ),
      ],
    );
  }
}
