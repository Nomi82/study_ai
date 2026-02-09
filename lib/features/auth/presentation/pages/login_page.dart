import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_ai/core/di/injection_container.dart';
import 'package:study_ai/core/theme/app_colors.dart';
import 'package:study_ai/features/auth/presentation/cubit/login_cubit.dart';
import 'package:study_ai/features/auth/presentation/cubit/login_state.dart';
import 'package:study_ai/features/auth/presentation/pages/register_page.dart';
import 'package:study_ai/features/auth/presentation/widgets/social_sign_in_button.dart';

/// Pantalla de inicio de sesión.
///
/// Provee el [LoginCubit] desde GetIt y delega la vista a [_LoginView].
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LoginCubit>(),
      child: const _LoginView(),
    );
  }
}

// ═══════════════════════════════════════════════════════════
//  VISTA (StatefulWidget solo por los TextEditingControllers)
// ═══════════════════════════════════════════════════════════

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<LoginCubit>().loginWithEmail(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;

    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status == AuthFormStatus.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Error al iniciar sesión'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          context.read<LoginCubit>().resetStatus();
        }
        if (state.status == AuthFormStatus.success) {
          // TODO: Navegar a la pantalla principal
        }
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: isLight
                ? AppColors.backgroundGradient
                : AppColors.backgroundGradientDark,
          ),
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 16),

                    // ── Logo ──────────────────────────────
                    _Logo(colorScheme: cs),
                    const SizedBox(height: 12),

                    // ── Título ────────────────────────────
                    Text(
                      'StudyAI',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: cs.primary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Tu asistente de estudio con IA',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: cs.onSurfaceVariant,
                      ),
                    ),

                    const SizedBox(height: 40),

                    // ── Formulario ────────────────────────
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Email
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            autocorrect: false,
                            decoration: const InputDecoration(
                              hintText: 'Correo electrónico',
                              prefixIcon: Icon(Icons.mail_outline_rounded),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Introduce tu correo';
                              }
                              if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$')
                                  .hasMatch(value.trim())) {
                                return 'Correo no válido';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 16),

                          // Contraseña — reacciona al cubit para el toggle
                          BlocBuilder<LoginCubit, LoginState>(
                            buildWhen: (prev, curr) =>
                                prev.obscurePassword != curr.obscurePassword,
                            builder: (context, state) {
                              return TextFormField(
                                controller: _passwordController,
                                obscureText: state.obscurePassword,
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (_) => _onSubmit(),
                                decoration: InputDecoration(
                                  hintText: 'Contraseña',
                                  prefixIcon: const Icon(
                                      Icons.lock_outline_rounded),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      state.obscurePassword
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                    ),
                                    onPressed: () => context
                                        .read<LoginCubit>()
                                        .togglePasswordVisibility(),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Introduce tu contraseña';
                                  }
                                  if (value.length < 6) {
                                    return 'Mínimo 6 caracteres';
                                  }
                                  return null;
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    // ── Olvidé contraseña ─────────────────
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // TODO: Navegar a recuperar contraseña
                        },
                        child: const Text('¿Olvidaste tu contraseña?'),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // ── Botón login ───────────────────────
                    BlocBuilder<LoginCubit, LoginState>(
                      buildWhen: (prev, curr) =>
                          prev.status != curr.status,
                      builder: (context, state) {
                        return FilledButton(
                          onPressed: state.isLoading ? null : _onSubmit,
                          child: state.isLoading
                              ? const SizedBox(
                                  height: 22,
                                  width: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text('Iniciar sesión'),
                        );
                      },
                    ),

                    const SizedBox(height: 28),

                    // ── Divider ───────────────────────────
                    _OrDivider(color: cs.onSurfaceVariant),

                    const SizedBox(height: 28),

                    // ── Botones sociales ──────────────────
                    BlocBuilder<LoginCubit, LoginState>(
                      buildWhen: (prev, curr) =>
                          prev.status != curr.status,
                      builder: (context, state) {
                        return Row(
                          children: [
                            SocialSignInButton.google(
                              onPressed: state.isLoading
                                  ? null
                                  : () => context
                                      .read<LoginCubit>()
                                      .loginWithGoogle(),
                            ),
                            const SizedBox(width: 14),
                            SocialSignInButton.apple(
                              onPressed: state.isLoading
                                  ? null
                                  : () => context
                                      .read<LoginCubit>()
                                      .loginWithApple(),
                            ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 32),

                    // ── Link a registro ───────────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '¿No tienes cuenta? ',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const RegisterPage(),
                            ),
                          ),
                          child: Text(
                            'Regístrate',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: cs.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Logo circular con icono de libro ─────────────────────
class _Logo extends StatelessWidget {
  const _Logo({required this.colorScheme});
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: const Icon(
        Icons.auto_stories_rounded,
        color: Colors.white,
        size: 40,
      ),
    );
  }
}

// ─── Divider "o continúa con" ─────────────────────────────
class _OrDivider extends StatelessWidget {
  const _OrDivider({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: color.withValues(alpha: 0.25))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'o continúa con',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: color,
                ),
          ),
        ),
        Expanded(child: Divider(color: color.withValues(alpha: 0.25))),
      ],
    );
  }
}
