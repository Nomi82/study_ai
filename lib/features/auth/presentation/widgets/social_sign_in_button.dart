import 'package:flutter/material.dart';

/// Botón estilizado para inicio de sesión social (Google / Apple).
class SocialSignInButton extends StatelessWidget {
  const SocialSignInButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final Widget icon;
  final VoidCallback? onPressed;

  /// Botón predefinido para Google.
  factory SocialSignInButton.google({
    Key? key,
    required VoidCallback? onPressed,
  }) {
    return SocialSignInButton(
      key: key,
      label: 'Google',
      icon: const _GoogleIcon(),
      onPressed: onPressed,
    );
  }

  /// Botón predefinido para Apple.
  factory SocialSignInButton.apple({
    Key? key,
    required VoidCallback? onPressed,
  }) {
    return SocialSignInButton(
      key: key,
      label: 'Apple',
      icon: const _AppleIcon(),
      onPressed: onPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;

    return Expanded(
      child: Material(
        color: isLight
            ? cs.onSurface.withValues(alpha: 0.04)
            : cs.onSurface.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(width: 10),
                Text(
                  label,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: cs.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Google "G" icon pintado a mano ───────────────────────
class _GoogleIcon extends StatelessWidget {
  const _GoogleIcon();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 22,
      height: 22,
      child: CustomPaint(painter: _GoogleLogoPainter()),
    );
  }
}

class _GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    // Blue
    final bluePaint = Paint()..color = const Color(0xFF4285F4);
    // Red
    final redPaint = Paint()..color = const Color(0xFFEA4335);
    // Yellow
    final yellowPaint = Paint()..color = const Color(0xFFFBBC05);
    // Green
    final greenPaint = Paint()..color = const Color(0xFF34A853);

    final center = Offset(w / 2, h / 2);
    final radius = w / 2;

    // Background circle (blue)
    canvas.drawCircle(center, radius, bluePaint);

    // White overlay to create the "G" shape
    final whitePaint = Paint()..color = Colors.white;

    // Inner circle
    canvas.drawCircle(center, radius * 0.58, whitePaint);

    // Right bar
    canvas.drawRect(
      Rect.fromLTRB(w * 0.48, h * 0.38, w, h * 0.62),
      bluePaint,
    );

    // White gap on right
    canvas.drawRect(
      Rect.fromLTRB(w * 0.48, h * 0.42, w * 0.92, h * 0.58),
      whitePaint,
    );

    // Draw the colored arcs — simplified approach
    // Top (red)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -2.4,
      1.2,
      true,
      redPaint,
    );
    canvas.drawCircle(center, radius * 0.58, whitePaint);

    // Left (yellow)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -1.2,
      1.3,
      true,
      yellowPaint,
    );
    canvas.drawCircle(center, radius * 0.58, whitePaint);

    // Bottom (green)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0.1,
      1.5,
      true,
      greenPaint,
    );
    canvas.drawCircle(center, radius * 0.58, whitePaint);

    // Top-right (blue + bar)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -0.5,
      -1.9,
      true,
      bluePaint,
    );
    canvas.drawCircle(center, radius * 0.58, whitePaint);

    // Crossbar
    canvas.drawRect(
      Rect.fromLTRB(w * 0.48, h * 0.38, w, h * 0.62),
      bluePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─── Apple icon ──────────────────────────────────────────
class _AppleIcon extends StatelessWidget {
  const _AppleIcon();

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Icon(
      Icons.apple,
      size: 24,
      color: isLight ? Colors.black : Colors.white,
    );
  }
}
