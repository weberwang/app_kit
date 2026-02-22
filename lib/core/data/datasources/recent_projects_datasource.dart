import 'package:shared_preferences/shared_preferences.dart';

abstract interface class RecentProjectsDataSource {
  Future<List<String>> getRecentPaths();
  Future<void> addPath(String path);
  Future<void> removePath(String path);
}

final class RecentProjectsDataSourceImpl implements RecentProjectsDataSource {
  RecentProjectsDataSourceImpl(this._prefs);

  final SharedPreferences _prefs;

  static const _key = 'recent_project_paths';
  static const _maxItems = 10;

  @override
  Future<List<String>> getRecentPaths() async {
    return _prefs.getStringList(_key) ?? [];
  }

  @override
  Future<void> addPath(String path) async {
    final list = await getRecentPaths();
    list
      ..remove(path)
      ..insert(0, path);
    if (list.length > _maxItems) list.removeLast();
    await _prefs.setStringList(_key, list);
  }

  @override
  Future<void> removePath(String path) async {
    final list = await getRecentPaths()
      ..remove(path);
    await _prefs.setStringList(_key, list);
  }
}
