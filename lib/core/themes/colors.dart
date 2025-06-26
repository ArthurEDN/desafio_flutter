import 'package:flutter/material.dart';

abstract final class AppColors {
  static const primary = Color(0xFF368278);
  static const primaryLight = Color(0xFFAFB774);
  static const accent = Color(0xFF4FC7B0);

  static const buttonGradientStart = Color(0xFF368278);
  static const buttonGradientEnd = Color(0xFFAFB774);

  static const topGradientStart = Color(0xFF32A38D);
  static const topGradientEnd = Color(0xFFE5DA7E);

  static const background = Color(0xFF23202D);
  static const cardBackground = Color(0xFF292938);
  static const drawerBackground = Color(0xFF23202D);
  static const surfaceElevated = Color(0xFF292938);

  static const textPrimary = Colors.white;
  static const textSecondary = Color(0xFFA4A4A4);
  static const textTertiary = Color(0xFF6B6B7B);
  static const textLink = primary;
  static const textOnPrimary = Colors.white;
  static const textOnAccent = Color(0xFF1E1E2E);

  static const error = Color(0xFFE74C3C);
  static const warning = Color(0xFFF39C12);
  static const success = Color(0xFF4FC7B0);

  static const info = Color(0xFF3498DB);
  static const forgotPassword = Color(0xFF3B7D77);
  static const buttonSelected = Color(0xFF3C7875);

  static const border = Color(0xFF4A4A6A);
  static const borderFocused = Color(0xFF4FC7B0);
  static const divider = Color(0xFF2C2C3E);
  static const shadow = Color(0x1A000000);

  static const iconPrimary = Colors.white;
  static const iconSecondary = Color(0xFFA4A4A4);
  static const iconOnPrimary = Colors.white;
  static const iconDrawer = Color(0xFF4A8681);

  static const socialButtonBackground = Color(0xFFF2F3FB);
  static const socialButtonText = Color(0xFF23202D);
  static const inputBackground = Color(0xFF292938);
  static const menuItemHover = Color(0xFF2C2C3E);

  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: textOnPrimary,
    secondary: accent,
    onSecondary: textOnAccent,
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF1E1E2E),
    error: error,
    onError: Colors.white,
    outline: Color(0xFFE0E0E0),
    shadow: shadow,
  );

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF368278),
    onPrimary: textOnPrimary,
    secondary: Color(0xFF4FC7B0),
    onSecondary: textOnAccent,
    surface: Color(0xFF292938),
    onSurface: textPrimary,
    error: error,
    onError: Colors.white,
    outline: border,
    shadow: shadow,
  );

  static const backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [topGradientStart, topGradientEnd],
  );

  static const buttonGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [buttonGradientStart, buttonGradientEnd],
  );

  static const topSectionGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [topGradientStart, topGradientEnd],
  );

  static const headerGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [topGradientStart, topGradientEnd],
  );
}
