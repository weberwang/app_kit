import 'package:go_router/go_router.dart';

import 'package:app_kit/features/editor/pages/editor_page.dart';
import 'package:app_kit/features/home/pages/home_page.dart';

final class AppRouter {
  AppRouter._();

  static const homeRoute = '/';
  static const editorRoute = '/editor';

  static final GoRouter router = GoRouter(
    initialLocation: homeRoute,
    routes: [
      GoRoute(
        path: homeRoute,
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: editorRoute,
        name: 'editor',
        builder: (context, state) => const EditorPage(),
      ),
    ],
  );
}
