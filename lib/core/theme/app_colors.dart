import 'package:flutter/material.dart';

/// Paleta de colores de StudyAI.
///
/// **Modo claro (Opción 1 - Minimalista Azul-Neutro):**
/// - Azul profundo suave: mejora la concentración
/// - Verde salvia: reduce el estrés visual en sesiones largas
/// - Amarillo mostaza: alertas y acentos
///
/// **Modo oscuro (Opción 2 - Modo Oscuro Cálido):**
/// - Lavanda suave: elegancia y calma
/// - Verde menta: frescura y contraste
/// - Coral: acentos cálidos
abstract class AppColors {
  // ── Primarios (Light: azul profundo / Dark: lavanda) ───
  static const Color primary = Color(0xFF4A90E2);
  static const Color primaryLight = Color(0xFF6BA3E8);
  static const Color primaryDark = Color(0xFF357ABD);
  static const Color primaryDarkTheme = Color(0xFFA78BFA);
  static const Color primaryDarkThemeLight = Color(0xFFC4B0FF);
  static const Color primaryDarkThemeDark = Color(0xFF8B6FD9);

  // ── Secundarios (Light: verde salvia / Dark: verde menta) ─
  static const Color secondary = Color(0xFF6B9080);
  static const Color secondaryLight = Color(0xFF8BA99D);
  static const Color secondaryDark = Color(0xFF4F6E61);
  static const Color secondaryDarkTheme = Color(0xFF81E6D9);
  static const Color secondaryDarkThemeLight = Color(0xFFA5EDE4);
  static const Color secondaryDarkThemeDark = Color(0xFF5BCFC1);

  // ── Acento (Light: amarillo mostaza / Dark: coral) ───────
  static const Color accent = Color(0xFFE8B44F);
  static const Color accentLight = Color(0xFFEEC670);
  static const Color accentDark = Color(0xFFC99630);
  static const Color accentDarkTheme = Color(0xFFFF8B94);
  static const Color accentDarkThemeLight = Color(0xFFFFA5AC);
  static const Color accentDarkThemeDark = Color(0xFFE66B76);

  // ── Semánticos ─────────────────────────────────────────
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFE8B44F); // Amarillo mostaza
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF4A90E2);

  // ── Neutros (Light - Opción 1) ──────────────────────────
  static const Color backgroundLight = Color(0xFFF5F5F7);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color onSurfaceLight = Color(0xFF2C3E50); // Gris carbón
  static const Color onSurfaceVariantLight = Color(0xFF5D6D7E);
  static const Color outlineLight = Color(0xFFE0E2E5);

  // ── Neutros (Dark - Opción 2) ───────────────────────────
  static const Color backgroundDark = Color(0xFF1E1E1E);
  static const Color surfaceDark = Color(0xFF2D2D30);
  static const Color surfaceDarkVariant = Color(0xFF3D3D42);
  static const Color onSurfaceDark = Color(0xFFE8E8E8);
  static const Color onSurfaceVariantDark = Color(0xFFB0B0B0);
  static const Color outlineDark = Color(0xFF404040);

  // ── Gradientes ─────────────────────────────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, Color(0xFF5B8DC6)],
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFFAFAFC), backgroundLight],
  );

  static const LinearGradient primaryGradientDark = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryDarkTheme, Color(0xFF9F7AEA)],
  );

  static const LinearGradient backgroundGradientDark = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF252528), backgroundDark],
  );
}
