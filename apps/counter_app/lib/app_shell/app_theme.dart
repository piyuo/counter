import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static const brightness = Brightness.dark;
  static const primaryColor = CupertinoColors.activeBlue;

  static final cupertinoTheme = CupertinoThemeData(brightness: brightness);

  static final materialTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(brightness: brightness, seedColor: primaryColor),
    brightness: brightness,
    cupertinoOverrideTheme: cupertinoTheme,
    useMaterial3: true,
  );
}
