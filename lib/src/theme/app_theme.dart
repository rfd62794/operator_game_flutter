import 'package:flutter/material.dart';

class AppTheme {
  static const Color surfaceLow = Color(0xFF131318);
  static const Color surfaceHigh = Color(0xFF25252C);
  static const Color primaryAccent = Color(0xFF69FEA5);
  static const Color standardText = Color(0xFFF8F5FD);
  static const Color stressAlert = Color(0xFFC83232);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: surfaceLow,
      colorScheme: ColorScheme.dark(
        surface: surfaceLow,
        onSurface: standardText,
        primary: primaryAccent,
        secondary: primaryAccent.withOpacity(0.7),
        error: stressAlert,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: surfaceLow,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: standardText,
          fontSize: 14,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
      ),
      cardTheme: CardThemeData(
        color: surfaceHigh,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      textTheme: const TextTheme(
        labelSmall: TextStyle(letterSpacing: 1.0, fontSize: 10),
      ),
  static Color getLifeStageColor(String stage) {
    switch (stage.toUpperCase()) {
      case 'HATCHLING': return const Color(0xFFA0A0A0);
      case 'JUVENILE':  return const Color(0xFF8CC88C);
      case 'YOUNG':     return const Color(0xFF64C8B4);
      case 'PRIME':     return const Color(0xFFDCB450);
      case 'VETERAN':   return const Color(0xFFC88C3C);
      case 'ELDER':     return const Color(0xFFB478DC);
      default:          return Colors.white24;
    }
  }
}

class SlimeColors {
  static const Map<String, Color> cultureColors = {
    'Ember':   Color(0xFFFF3D00), // Crimson/Red
    'Tide':    Color(0xFF00B0FF), // Azure/Blue
    'Orange':  Color(0xFFFF9100), // Amber/Orange
    'Marsh':   Color(0xFFC6FF00), // Lime/Yellow-Green
    'Teal':    Color(0xFF1DE9B6), // Cyan/Teal
    'Crystal': Color(0xFF3D5AFE), // Indigo/Blue
    'Gale':    Color(0xFF00E676), // Emerald/Green
    'Tundra':  Color(0xFFD500F9), // Purple/Magenta
    'Frost':   Color(0xFF00E5FF), // Ice/Cyan-White
    'Void':    Color(0xFF212121), // Charcoal/Black
  };

  static Color getCultureColor(String culture) {
    return cultureColors[culture] ?? Colors.grey.shade800;
  }
}

class GlassDecoration extends BoxDecoration {
  GlassDecoration({
    Color color = Colors.white,
    double opacity = 0.1,
    double blur = 10.0,
    double borderRadius = 16.0,
  }) : super(
          color: color.withOpacity(opacity),
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: color.withOpacity(0.2)),
        );
}
