import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colors => Theme.of(this).colorScheme;
  TextTheme get textStyles => Theme.of(this).textTheme;
  Size get screenSize => MediaQuery.sizeOf(this);
  bool get isDesktop => screenSize.width >= 1024;
}

extension StringX on String {
  String get pluralize => endsWith('s') ? this : '${this}s';
  bool get isNotBlankString => trim().isNotEmpty;
}
