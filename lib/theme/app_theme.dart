import 'package:flutter/material.dart';

/// Centralized design tokens for HydroSense AI.
/// Mirrors the web design system: forest-green accents, soft white cards,
/// rounded corners, and a calm agricultural palette.
class AppColors {
  AppColors._();

  static const Color ink900 = Color(0xFF0F172A);
  static const Color ink700 = Color(0xFF334155);
  static const Color ink500 = Color(0xFF64748B);
  static const Color ink300 = Color(0xFF94A3B8);

  static const Color green = Color(0xFF22C55E);
  static const Color greenDark = Color(0xFF16A34A);
  static const Color greenDeep = Color(0xFF0E7A3A);
  static const Color greenLight = Color(0xFFEAFAF1);
  static const Color greenTint = Color(0xFFF2FBF6);

  static const Color blue = Color(0xFF3B82F6);
  static const Color blueTint = Color(0xFFEAF2FF);

  static const Color purple = Color(0xFF8B5CF6);
  static const Color purpleTint = Color(0xFFF4EEFF);

  static const Color amber = Color(0xFFF59E0B);
  static const Color amberTint = Color(0xFFFFF6E6);

  static const Color red = Color(0xFFEF4444);
  static const Color redTint = Color(0xFFFDECEB);

  static const Color teal = Color(0xFF14B8A6);
  static const Color tealTint = Color(0xFFE8FAF7);

  static const Color surface = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF6F9F7);
  static const Color line = Color(0xFFEEF1EE);

  static const Color canvasDark = Color(0xFF0B1E14);
}

class AppRadius {
  AppRadius._();
  static const double lg = 26;
  static const double md = 18;
  static const double sm = 12;
}

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.greenDark,
        brightness: Brightness.light,
        primary: AppColors.greenDark,
        secondary: AppColors.green,
        surface: AppColors.surface,
        error: AppColors.red,
      ),
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: 'Roboto',
    );

    return base.copyWith(
      textTheme: base.textTheme.copyWith(
        headlineSmall: const TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 22,
          color: AppColors.ink900,
          letterSpacing: -0.3,
        ),
        titleMedium: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 15,
          color: AppColors.ink900,
        ),
        bodyMedium: const TextStyle(
          fontSize: 13,
          color: AppColors.ink700,
        ),
        bodySmall: const TextStyle(
          fontSize: 11.5,
          color: AppColors.ink500,
          fontWeight: FontWeight.w600,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        foregroundColor: AppColors.ink900,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 20,
          color: AppColors.ink900,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          side: const BorderSide(color: AppColors.line),
        ),
        margin: EdgeInsets.zero,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.greenDark,
        unselectedItemColor: AppColors.ink300,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700),
        unselectedLabelStyle: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700),
        elevation: 8,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF5F7F5),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.line, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.line, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.greenDark, width: 1.5),
        ),
        hintStyle: const TextStyle(color: AppColors.ink300, fontSize: 13.5),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.greenDark,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
        ),
      ),
      dividerTheme: const DividerThemeData(color: AppColors.line, thickness: 1, space: 1),
    );
  }
}
