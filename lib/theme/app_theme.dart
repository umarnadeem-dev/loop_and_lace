import 'package:flutter/material.dart';

class AppColors {
  // Brand Primary: Rich burgundy / berry / plum
  static const Color primary = Color(0xFF8C254C);
  static const Color primaryLight = Color(0xFFA63964);
  static const Color primaryDark = Color(0xFF6B1A38);

  // Soft accents & secondary
  static const Color sage = Color(0xFF5E8D75);
  static const Color sageLight = Color(0xFFE2ECE7);
  static const Color sageDark = Color(0xFF436B56);

  static const Color peach = Color(0xFFF9D8CE);
  static const Color blush = Color(0xFFF5E4E8);

  // Backgrounds
  static const Color background = Color(0xFFFAF7F2);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceWarm = Color(0xFFF6F1EA);
  static const Color inputBackground = Color(0xFFFBF8F5);

  // Borders & Dividers
  static const Color border = Color(0xFFEAE2DC);
  static const Color borderLight = Color(0xFFF2ECE6);

  // Text
  static const Color textPrimary = Color(0xFF2A2024);
  static const Color textSecondary = Color(0xFF756A70);
  static const Color textMuted = Color(0xFFA1979D);

  // Badges & Statuses
  static const Color statusPending = Color(0xFFFEE8EE);
  static const Color statusPendingText = Color(0xFFC43864);
  static const Color statusMaking = Color(0xFFFFF0E0);
  static const Color statusMakingText = Color(0xFFD47A22);
  static const Color statusShipped = Color(0xFFE4F3EC);
  static const Color statusShippedText = Color(0xFF337D57);
  static const Color statusActive = Color(0xFFE8F4EE);
  static const Color statusActiveText = Color(0xFF2E7B54);
}

class AppTypography {
  static const String serifFamily = 'Georgia';
  static const String sansFamily = 'Segoe UI';

  static TextStyle serif({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
    double? height,
    FontStyle? fontStyle,
  }) {
    return TextStyle(
      fontFamily: serifFamily,
      fontFamilyFallback: const ['Palatino', 'Times New Roman', 'serif'],
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      fontStyle: fontStyle,
    );
  }

  static TextStyle sans({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
    double? height,
    FontStyle? fontStyle,
  }) {
    return TextStyle(
      fontFamily: sansFamily,
      fontFamilyFallback: const ['Outfit', 'Poppins', 'Helvetica', 'Arial', 'sans-serif'],
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      fontStyle: fontStyle,
    );
  }
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.sage,
        surface: AppColors.surface,
        brightness: Brightness.light,
      ),
      fontFamily: AppTypography.sansFamily,
      fontFamilyFallback: const ['Outfit', 'Segoe UI', 'Arial', 'sans-serif'],
      textTheme: TextTheme(
        displayLarge: AppTypography.serif(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
        displayMedium: AppTypography.serif(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
        headlineLarge: AppTypography.serif(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
        headlineMedium: AppTypography.sans(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
        titleLarge: AppTypography.sans(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        titleMedium: AppTypography.sans(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        bodyLarge: AppTypography.sans(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: AppColors.textPrimary,
        ),
        bodyMedium: AppTypography.sans(
          fontSize: 13,
          fontWeight: FontWeight.normal,
          color: AppColors.textSecondary,
        ),
        labelSmall: AppTypography.sans(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: AppColors.textMuted,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: AppTypography.sans(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          side: const BorderSide(color: AppColors.border, width: 1.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: AppTypography.sans(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputBackground,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        hintStyle: AppTypography.sans(
          color: AppColors.textMuted,
          fontSize: 14,
        ),
      ),
    );
  }
}
