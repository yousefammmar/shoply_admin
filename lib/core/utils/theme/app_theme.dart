import 'package:flutter/material.dart';
import 'package:shoply_admin/core/utils/fonts/app_fonts.dart';
import 'package:shoply_admin/core/utils/theme/app_colors.dart';

class AppTheme {
  static ThemeData themeLight = _buildTheme(
    ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primaryColor,
      onPrimary: AppColors.onPrimary,
      primaryContainer: AppColors.secondary,
      onPrimaryContainer: AppColors.primaryColor,
      secondary: AppColors.primaryColor,
      onSecondary: AppColors.onPrimary,
      error: AppColors.error,
      onError: AppColors.onError,
      surface: AppColors.backgrround,
      onSurface: Colors.black,
      onSurfaceVariant: AppColors.greyText,
      outlineVariant: AppColors.cardBorder,
      surfaceContainerHighest: AppColors.fieldFill,
    ),
    inputIconColor: Colors.grey.shade800,
    switchOffThumbColor: Colors.white,
    switchOffTrackColor: Colors.grey.shade300,
  );

  static ThemeData themeDark = _buildTheme(
    ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.darkPrimary,
      onPrimary: AppColors.darkOnPrimary,
      primaryContainer: AppColors.darkSecondary,
      onPrimaryContainer: AppColors.darkOnSecondary,
      secondary: AppColors.darkPrimary,
      onSecondary: AppColors.darkOnPrimary,
      error: AppColors.error,
      onError: AppColors.onError,
      surface: AppColors.darkBackground,
      onSurface: AppColors.darkText,
      onSurfaceVariant: AppColors.darkGreyText,
      outlineVariant: AppColors.darkCardBorder,
      surfaceContainerLow: AppColors.darkRaised,
      surfaceContainer: AppColors.darkRaised,
      surfaceContainerHigh: AppColors.darkRaised,
      surfaceContainerHighest: AppColors.darkFieldFill,
    ),
    inputIconColor: Colors.grey.shade400,
    switchOffThumbColor: AppColors.darkGreyText,
    switchOffTrackColor: AppColors.darkFieldFill,
  );

  static ThemeData _buildTheme(
    ColorScheme colorScheme, {
    required Color inputIconColor,
    required Color switchOffThumbColor,
    required Color switchOffTrackColor,
  }) {
    return ThemeData(
      fontFamily: AppFonts.quikSand,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      inputDecorationTheme: InputDecorationTheme(
        prefixIconColor: inputIconColor,
        suffixIconColor: inputIconColor,
      ),
      // snack bars are brand green (or red for errors) in both modes,
      // so the text stays white instead of the dark onInverseSurface
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.primaryColor,
        contentTextStyle: TextStyle(
          fontFamily: AppFonts.quikSand,
          fontSize: 14,
          color: AppColors.onPrimary,
        ),
      ),
      // "on" uses the default primary track with an onPrimary thumb
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? null
              : switchOffThumbColor,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? null
              : switchOffTrackColor,
        ),
      ),
    );
  }
}
