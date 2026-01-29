// lib/theme/typography.dart
import 'package:flutter/material.dart';

class AppTypography {
  // Heading styles
  static const TextStyle h1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    height: 1.2,
  );

  static const TextStyle h2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    height: 1.3,
  );

  static const TextStyle h3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    height: 1.4,
  );

  static const TextStyle h4 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    height: 1.4,
  );

  // Body text styles
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Colors.black,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: Colors.black,
    height: 1.4,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Colors.black87,
    height: 1.4,
  );

  // Label styles
  static TextStyle label = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: Colors.grey[600],
    letterSpacing: 0.5,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: Colors.grey,
    height: 1.3,
  );

  // Button text styles
  static const TextStyle button = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );

  static const TextStyle buttonLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );

  // Private constructor to prevent instantiation
  AppTypography._();
}
