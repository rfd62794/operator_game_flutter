import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple,
        brightness: Brightness.dark,
        surface: const Color(0xFF121212),
      ),
      scaffoldBackgroundColor: const Color(0xFF0A0A0A),
      cardTheme: CardThemeData(
        color: Colors.white.withOpacity(0.05),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
      ),
    );
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
