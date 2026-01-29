import 'package:flutter/material.dart';


class AppColors {
  AppColors._(); // prevents instantiation

  // 🔷 BRAND COLORS
  static const Color primary = Color(0xFF2563EB); // Blue
  static const Color secondary = Color(0xFF1F2A37); // Dark blue (top bar)
  static const Color accent = Color(0xFFEF4444); // Red (logo / alerts)

  // 🔷 BACKGROUND COLORS
  static const Color scaffoldBackground = Color(0xFFF1F3F6);
  static const Color pageBackground = Color(0xFFFAFBFC);
  static const Color cardBackground = Color(0xFFFFFFFF);

  // 🔷 TEXT COLORS
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textDisabled = Color(0xFF9CA3AF);
  static const Color textWhite = Colors.white;

  // 🔷 BORDER & DIVIDER COLORS
  static const Color border = Color(0xFFE5E7EB);
  static const Color divider = Color(0xFFD1D5DB);

  // 🔷 STATUS COLORS
  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFDC2626);
  static const Color info = Color(0xFF0EA5E9);

  // 🔷 FORM COLORS
  static const Color inputFill = Color(0xFFE5E7EB);
  static const Color inputHint = Color(0xFF9CA3AF);

  // 🔷 STEPPER COLORS
  static const Color stepActive = primary;
  static const Color stepInactive = Color(0xFFD1D5DB);
  static const Color stepLine = Color(0xFFE5E7EB);

  // 🔷 BUTTON COLORS
  static const Color buttonPrimary = primary;
  static const Color buttonDisabled = Color(0xFF9CA3AF);

  // 🔷 SHADOW
  static const Color shadow = Color(0x1A000000); // 10% black

}

