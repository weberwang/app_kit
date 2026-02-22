import 'package:device_frame_plus/device_frame_plus.dart';

/// 预定义支持的设备列表（26 台）
final class DeviceCatalog {
  DeviceCatalog._();

  static const List<DeviceEntry> devices = [
    // ── iPhone ──────────────────────────────────────
    DeviceEntry('iphone_14_pro', 'iPhone 14/15 Pro', DeviceType.phone),
    DeviceEntry('iphone_13_pro_max', 'iPhone 13 Pro Max', DeviceType.phone),
    DeviceEntry('iphone_13', 'iPhone 13', DeviceType.phone),
    DeviceEntry('iphone_13_mini', 'iPhone 13 Mini', DeviceType.phone),
    DeviceEntry('iphone_12_pro_max', 'iPhone 12 Pro Max', DeviceType.phone),
    DeviceEntry('iphone_12', 'iPhone 12', DeviceType.phone),
    DeviceEntry('iphone_12_mini', 'iPhone 12 Mini', DeviceType.phone),
    DeviceEntry('iphone_se_3', 'iPhone SE', DeviceType.phone),
    // ── iPad ────────────────────────────────────────
    DeviceEntry('ipad_pro_129_gen4', 'iPad Pro 12.9" Gen4', DeviceType.tablet),
    DeviceEntry('ipad_pro_129_gen2', 'iPad Pro 12.9" Gen2', DeviceType.tablet),
    DeviceEntry('ipad_pro_11', 'iPad Pro 11"', DeviceType.tablet),
    DeviceEntry('ipad_air_4', 'iPad Air 4', DeviceType.tablet),
    DeviceEntry('ipad', 'iPad (standard)', DeviceType.tablet),
    // ── Samsung ─────────────────────────────────────
    DeviceEntry('samsung_s20', 'Samsung Galaxy S20', DeviceType.phone),
    DeviceEntry('samsung_note20', 'Samsung Note 20', DeviceType.phone),
    DeviceEntry(
      'samsung_note20_ultra',
      'Samsung Note 20 Ultra',
      DeviceType.phone,
    ),
    DeviceEntry('samsung_a50', 'Samsung Galaxy A50', DeviceType.phone),
    // ── Pixel / Generic Android ──────────────────────
    DeviceEntry('pixel_4', 'Google Pixel 4', DeviceType.phone),
    DeviceEntry('android_small', 'Android Small (360dp)', DeviceType.phone),
    DeviceEntry('android_medium', 'Android Medium (411dp)', DeviceType.phone),
    DeviceEntry('android_large', 'Android Large (480dp)', DeviceType.phone),
    // ── 其他 Android ─────────────────────────────────
    DeviceEntry('oneplus_8_pro', 'OnePlus 8 Pro', DeviceType.phone),
    DeviceEntry('sony_xperia_1', 'Sony Xperia 1 II', DeviceType.phone),
    // ── Generic Tablet ───────────────────────────────
    DeviceEntry('tablet_small', 'Tablet Small (600dp)', DeviceType.tablet),
    DeviceEntry('tablet_medium', 'Tablet Medium (800dp)', DeviceType.tablet),
    DeviceEntry('tablet_large', 'Tablet Large (1024dp)', DeviceType.tablet),
  ];

  static DeviceInfo frameFor(String deviceId) {
    return switch (deviceId) {
      'iphone_14_pro' => Devices.ios.iPhone14Pro,
      'iphone_13_pro_max' => Devices.ios.iPhone13ProMax,
      'iphone_13' => Devices.ios.iPhone13,
      'iphone_13_mini' => Devices.ios.iPhone13Mini,
      'iphone_12_pro_max' => Devices.ios.iPhone12ProMax,
      'iphone_12' => Devices.ios.iPhone12,
      'iphone_12_mini' => Devices.ios.iPhone12Mini,
      'iphone_se_3' => Devices.ios.iPhoneSE,
      'ipad_pro_129_gen4' => Devices.ios.iPad12InchesGen4,
      'ipad_pro_129_gen2' => Devices.ios.iPad12InchesGen2,
      'ipad_pro_11' => Devices.ios.iPadPro11Inches,
      'ipad_air_4' => Devices.ios.iPadAir4,
      'ipad' => Devices.ios.iPad,
      'samsung_s20' => Devices.android.samsungGalaxyS20,
      'samsung_note20' => Devices.android.samsungGalaxyNote20,
      'samsung_note20_ultra' => Devices.android.samsungGalaxyNote20Ultra,
      'samsung_a50' => Devices.android.samsungGalaxyA50,
      'pixel_4' => Devices.android.pixel4,
      'android_small' => Devices.android.smallPhone,
      'android_medium' => Devices.android.mediumPhone,
      'android_large' => Devices.android.bigPhone,
      'oneplus_8_pro' => Devices.android.onePlus8Pro,
      'sony_xperia_1' => Devices.android.sonyXperia1II,
      'tablet_small' => Devices.android.smallTablet,
      'tablet_medium' => Devices.android.mediumTablet,
      'tablet_large' => Devices.android.largeTablet,
      _ => Devices.ios.iPhone13,
    };
  }

  static String defaultDeviceId = 'iphone_14_pro';
}

/// 设备条目：ID、显示名称、设备类型
final class DeviceEntry {
  const DeviceEntry(this.id, this.label, this.type);
  final String id;
  final String label;
  final DeviceType type;
}

enum DeviceType { phone, tablet }
