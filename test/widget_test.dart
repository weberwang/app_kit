import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:app_kit/app.dart';
import 'package:app_kit/core/di/datasource_providers.dart';

void main() {
  testWidgets('App starts and shows home actions', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [sharedPreferencesProvider.overrideWith((ref) => prefs)],
        child: const AppKitApp(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('新建项目'), findsOneWidget);
    expect(find.text('打开项目'), findsOneWidget);
  });
}
