import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Defines the application's visual theme.
///
/// We use a custom [ThemeData] based on Material 3.
/// The color palette is designed to look modern and "SaaS-like",
/// using a primary Blue-600 color and Slate grays for neutrals.
/// Typography is set to Inter via [GoogleFonts] for a clean, professional look.
class AppTheme {
  /// Returns the light theme configuration for the app.
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF2563EB), // Blue-600
        brightness: Brightness.light,
        surface: const Color(0xFFF8FAFC), // Slate-50
        surfaceContainer: Colors.white,
        primary: const Color(0xFF2563EB),
        secondary: const Color(0xFF475569), // Slate-600
        tertiary: const Color(0xFF0F172A), // Slate-900
      ),
      textTheme: GoogleFonts.interTextTheme(),
      // Custom card theme for a flat, bordered look common in modern web apps.
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Color(0xFFE2E8F0)), // Slate-200
        ),
        color: Colors.white,
      ),
      // Styled input fields with distinct borders for focus states.
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF2563EB), width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      // Primary buttons with bold text and rounded corners.
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: const Color(0xFF2563EB),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
