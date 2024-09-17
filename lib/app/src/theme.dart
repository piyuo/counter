import 'package:flutter/material.dart';

get themeLight {
  return ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF005CBB),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFFD7E2FF),
      onPrimaryContainer: Color(0xFF001B3F),
      secondary: Color(0xFF006491),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFFC9E6FF),
      onSecondaryContainer: Color(0xFF001E2F),
      tertiary: Color(0xFF006877),
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFFA3EEFF),
      onTertiaryContainer: Color(0xFF001F25),
      error: Color(0xFFBA1A1A),
      errorContainer: Color(0xFFFFDAD6),
      onError: Color(0xFFFFFFFF),
      onErrorContainer: Color(0xFF410002),
      surface: Color(0xFFF5F5F7),
      onSurface: Color(0xFF515151),
      onSurfaceVariant: Color(0xFF44474E),
      outline: Color(0xFF74777F),
      onInverseSurface: Color(0xFFF2F0F4),
      inverseSurface: Color(0xFF2F3033),
      inversePrimary: Color(0xFFABC7FF),
      shadow: Color(0xFF000000),
      surfaceTint: Color(0xFF005CBB),
      outlineVariant: Color(0xFFC4C6D0),
      scrim: Color(0xFF000000),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Color(0xFFF5F5F7),
      toolbarTextStyle: TextStyle(
        fontSize: 14,
        color: Color(0xFF1E1E1E),
        fontWeight: FontWeight.bold,
      ),
      titleTextStyle: TextStyle(
        fontSize: 12,
        color: Color(0xFF515151),
      ),
      surfaceTintColor: Color(0xFF1A1B1F),
      
    ),
  );
}

get themeDark {
  return ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFFABC7FF),
      onPrimary: Color(0xFF002F66),
      primaryContainer: Color(0xFF00458F),
      onPrimaryContainer: Color(0xFFD7E2FF),
      secondary: Color(0xFF8ACEFF),
      onSecondary: Color(0xFF00344E),
      secondaryContainer: Color(0xFF004C6E),
      onSecondaryContainer: Color(0xFFC9E6FF),
      tertiary: Color(0xFF52D7F0),
      onTertiary: Color(0xFF00363E),
      tertiaryContainer: Color(0xFF004E5A),
      onTertiaryContainer: Color(0xFFA3EEFF),
      error: Color(0xFFFFB4AB),
      errorContainer: Color(0xFF93000A),
      onError: Color(0xFF690005),
      onErrorContainer: Color(0xFFFFDAD6),
      surface: Color(0xFF1A1B1F),
      onSurface: Color(0xFFE3E2E6),
      onSurfaceVariant: Color(0xFFC4C6D0),
      outline: Color(0xFF8E9099),
      onInverseSurface: Color(0xFF1A1B1F),
      inverseSurface: Color(0xFFE3E2E6),
      inversePrimary: Color(0xFF005CBB),
      shadow: Color(0xFF000000),
      surfaceTint: Color(0xFFABC7FF),
      outlineVariant: Color(0xFF44474E),
      scrim: Color(0xFF000000),
    ),
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(fontSize: 24),
      elevation: 0,
    ),
  );
}
