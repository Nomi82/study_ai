import 'package:flutter/material.dart';

/// Paleta de colores de StudyAI.
///
/// Inspirada en colores que promueven la concentración,
/// el aprendizaje y la motivación:
/// - Azul índigo: enfoque e inteligencia
/// - Verde azulado (teal): frescura y crecimiento
/// - Ámbar cálido: energía y motivación
abstract class AppColors {
  // ── Primarios ──────────────────────────────────────────
  static const Color primary = Color(0xFF4361EE);
  static const Color primaryLight = Color(0xFF7B93FF);
  static const Color primaryDark = Color(0xFF2B47C8);

  // ── Secundarios ────────────────────────────────────────
  static const Color secondary = Color(0xFF2EC4B6);
  static const Color secondaryLight = Color(0xFF6FDDCF);
  static const Color secondaryDark = Color(0xFF1A9E91);

  // ── Acento ─────────────────────────────────────────────
  static const Color accent = Color(0xFFFF9F1C);
  static const Color accentLight = Color(0xFFFFBF60);
  static const Color accentDark = Color(0xFFE08600);

  // ── Semánticos ─────────────────────────────────────────
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // ── Neutros (Light) ────────────────────────────────────
  static const Color backgroundLight = Color(0xFFF8F9FE);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color onSurfaceLight = Color(0xFF1A1D26);
  static const Color onSurfaceVariantLight = Color(0xFF6B7280);
  static const Color outlineLight = Color(0xFFE2E5F1);

  // ── Neutros (Dark) ─────────────────────────────────────
  static const Color backgroundDark = Color(0xFF0F1628);
  static const Color surfaceDark = Color(0xFF1C2333);
  static const Color surfaceDarkVariant = Color(0xFF252D44);
  static const Color onSurfaceDark = Color(0xFFF0F2FF);
  static const Color onSurfaceVariantDark = Color(0xFF9CA3AF);
  static const Color outlineDark = Color(0xFF2D3650);

  // ── Gradientes ─────────────────────────────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, Color(0xFF6C63FF)],
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFEEF0FF), backgroundLight],
  );

  static const LinearGradient backgroundGradientDark = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF141B30), backgroundDark],
  );
}
