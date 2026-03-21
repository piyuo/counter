// TOC:
// - app theme: shared Material theme defaults for the app shell
// - glass theme: liquid glass styling for light and dark variants

import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

class AppTheme extends StatelessWidget {
  const AppTheme({required this.child, super.key});

  final Widget child;

  static const brightness = Brightness.dark;
  static final primaryColor = Colors.blue.shade700;
  static final themeData = ThemeData(
    textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: Colors.white)),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(backgroundColor: primaryColor, foregroundColor: Colors.white),
    ),
    appBarTheme: const AppBarTheme(),
    colorScheme: ColorScheme.fromSeed(brightness: brightness, seedColor: primaryColor),
    brightness: brightness,
    useMaterial3: true,
  );

  @override
  Widget build(BuildContext context) {
    return GlassTheme(
      data: GlassThemeData(
        light: GlassThemeVariant(settings: const GlassThemeSettings(), quality: GlassQuality.standard),
        dark: GlassThemeVariant(
          settings: const GlassThemeSettings(
            glassColor: Color.fromARGB(128, 0, 0, 0),
            thickness: 28, // thicker rim makes the dark glass edge more dramatic
            blur: 8, // heavy frost — dark glass feels denser
            chromaticAberration: 0.015, // subtle rainbow edge on the rim
            lightIntensity: 0.28, // dim — dark glass absorbs light, doesn't reflect much
            ambientStrength: 0.18, // reveals the glass body depth in dark tone
            refractiveIndex: 1.38, // more bending through dense dark glass
          ),
          quality: GlassQuality.standard,
        ),
      ),
      child: child,
    );
  }
}
