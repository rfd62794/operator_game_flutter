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
      cardTheme: const CardThemeData(
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
    'Tide': Color(0xFF2196F3),     // Blue
    'Spark': Color(0xFFFFEB3B),    // Yellow
    'Flora': Color(0xFF4CAF50),    // Green
    'Eber': Color(0xFFFF5722),     // Orange
    'Gloom': Color(0xFF9C27B0),    // Purple
    'Frost': Color(0xFF00BCD4),    // Cyan
    'Stone': Color(0xFF795548),    // Brown
    'Void': Color(0xFF212121),     // Black
    'Light': Color(0xFFFAFAFA),    // White
  };

  static Color getCultureColor(String culture) {
    return cultureColors[culture] ?? Colors.grey;
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
