import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';

import 'package:app_kit/app.dart';
import 'package:app_kit/core/di/datasource_providers.dart';
import 'package:app_kit/shared/constants/app_constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ── Desktop window constraints ────────────────────────────────
  if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
    await windowManager.ensureInitialized();
    await windowManager.waitUntilReadyToShow(
      const WindowOptions(
        minimumSize: Size(
          AppConstants.minWindowWidth,
          AppConstants.minWindowHeight,
        ),
        size: Size(1280, 800),
        center: true,
        title: AppConstants.appName,
      ),
      () async {
        await windowManager.show();
        await windowManager.focus();
      },
    );
  }

  // ── Shared preferences ────────────────────────────────────────
  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        // Riverpod 3.x code-gen provider 使用 overrideWith
        sharedPreferencesProvider.overrideWith((ref) => prefs),
      ],
      child: const AppKitApp(),
    ),
  );
}
