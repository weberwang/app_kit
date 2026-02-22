/// App Store / Google Play 必需截图尺寸预设。
///
/// [width] / [height] 为画布逻辑点（logical pts），在编辑器中渲染。
/// 导出时使用 [exportPixelRatio] 倍率，输出像素 = width*ratio × height*ratio，
/// 与应用商店要求完全一致。
class CanvasSizePreset {
  const CanvasSizePreset({
    required this.id,
    required this.name,
    required this.store,
    required this.width,
    required this.height,
    required this.exportPixelRatio,
    required this.exportSizeLabel,
  });

  final String id;
  final String name;
  final String store; // 'App Store' | 'Google Play'
  final double width; // logical pts
  final double height; // logical pts
  final double exportPixelRatio;
  final String exportSizeLabel; // 仅用于 UI 展示

  String get displaySize => '${width.toInt()} × ${height.toInt()} pt';

  @override
  bool operator ==(Object other) => other is CanvasSizePreset && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

class CanvasPresets {
  CanvasPresets._();

  // ── App Store 必需尺寸 ──────────────────────────────────────────────────
  /// iPhone 6.9"（iPhone 16 Pro Max / 15 Plus 等）—— 2024 年起强制要求
  static const CanvasSizePreset iphone69 = CanvasSizePreset(
    id: 'iphone_69',
    name: 'iPhone 6.9"',
    store: 'App Store',
    width: 440,
    height: 956,
    exportPixelRatio: 3.0,
    exportSizeLabel: '1320 × 2868 px',
  );

  /// iPhone 6.7"（iPhone 14 Plus / 16 Plus）
  static const CanvasSizePreset iphone67 = CanvasSizePreset(
    id: 'iphone_67',
    name: 'iPhone 6.7"',
    store: 'App Store',
    width: 430,
    height: 932,
    exportPixelRatio: 3.0,
    exportSizeLabel: '1290 × 2796 px',
  );

  /// iPhone 6.5"（iPhone 11 Pro Max / XS Max）
  static const CanvasSizePreset iphone65 = CanvasSizePreset(
    id: 'iphone_65',
    name: 'iPhone 6.5"',
    store: 'App Store',
    width: 414,
    height: 896,
    exportPixelRatio: 3.0,
    exportSizeLabel: '1242 × 2688 px',
  );

  /// iPhone 5.5"（iPhone 8 Plus / 7 Plus —— 旧版要求）
  static const CanvasSizePreset iphone55 = CanvasSizePreset(
    id: 'iphone_55',
    name: 'iPhone 5.5"',
    store: 'App Store',
    width: 414,
    height: 736,
    exportPixelRatio: 3.0,
    exportSizeLabel: '1242 × 2208 px',
  );

  /// iPad Pro 12.9"（2nd / 6th Gen）
  static const CanvasSizePreset ipadPro129 = CanvasSizePreset(
    id: 'ipad_pro_129',
    name: 'iPad Pro 12.9"',
    store: 'App Store',
    width: 1024,
    height: 1366,
    exportPixelRatio: 2.0,
    exportSizeLabel: '2048 × 2732 px',
  );

  // ── Google Play 常用尺寸 ────────────────────────────────────────────────
  /// 手机（最主流标准尺寸）
  static const CanvasSizePreset gpPhone = CanvasSizePreset(
    id: 'gp_phone',
    name: '手机',
    store: 'Google Play',
    width: 360,
    height: 640,
    exportPixelRatio: 3.0,
    exportSizeLabel: '1080 × 1920 px',
  );

  /// 7 英寸平板
  static const CanvasSizePreset gpTablet7 = CanvasSizePreset(
    id: 'gp_tablet7',
    name: '7" 平板',
    store: 'Google Play',
    width: 600,
    height: 960,
    exportPixelRatio: 2.0,
    exportSizeLabel: '1200 × 1920 px',
  );

  /// 10 英寸平板
  static const CanvasSizePreset gpTablet10 = CanvasSizePreset(
    id: 'gp_tablet10',
    name: '10" 平板',
    store: 'Google Play',
    width: 800,
    height: 1280,
    exportPixelRatio: 2.0,
    exportSizeLabel: '1600 × 2560 px',
  );

  // ─────────────────────────────────────────────────────────────────────────

  static const CanvasSizePreset defaultPreset = iphone69;

  static const List<CanvasSizePreset> appStorePresets = [
    iphone69,
    iphone67,
    iphone65,
    iphone55,
    ipadPro129,
  ];

  static const List<CanvasSizePreset> googlePlayPresets = [
    gpPhone,
    gpTablet7,
    gpTablet10,
  ];

  static const List<CanvasSizePreset> all = [
    ...appStorePresets,
    ...googlePlayPresets,
  ];

  static CanvasSizePreset? findById(String id) {
    try {
      return all.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }
}
