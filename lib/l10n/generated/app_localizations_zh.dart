// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'App Kit';

  @override
  String get newProject => '新建项目';

  @override
  String get openProject => '打开项目';

  @override
  String get recentProjects => '最近项目';

  @override
  String get save => '保存';

  @override
  String get export => '导出';

  @override
  String get batchExport => '批量导出';

  @override
  String get importDirectory => '导入目录';

  @override
  String get undo => '撤销';

  @override
  String get redo => '重做';

  @override
  String get cancel => '取消';

  @override
  String get confirm => '确认';

  @override
  String get devices => '设备';

  @override
  String get layers => '图层';

  @override
  String get background => '背景';

  @override
  String get text => '文字';

  @override
  String get exportSuccess => '导出成功';

  @override
  String get exportFailed => '导出失败';

  @override
  String get openFolder => '打开文件夹';

  @override
  String get selectExportDirectory => '选择导出目录';

  @override
  String get exportFormat => '导出格式';

  @override
  String get pixelRatio => '分辨率倍率';

  @override
  String get noRecentProjects => '暂无最近项目';

  @override
  String get unsavedChanges => '有未保存的修改';

  @override
  String get localeImportPreview => '导入预览';

  @override
  String get selectLanguages => '选择要导入的语言';

  @override
  String screenshotCount(int count) {
    return '$count 张截图';
  }
}
