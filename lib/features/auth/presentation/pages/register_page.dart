import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_ai/core/di/injection_container.dart';
import 'package:study_ai/core/theme/app_colors.dart';
import 'package:study_ai/features/auth/presentation/cubit/login_state.dart'
    show AuthFormStatus;
import 'package:study_ai/features/auth/presentation/cubit/register_cubit.dart';
import 'package:study_ai/features/auth/presentation/cubit/register_state.dart';
import 'package:study_ai/features/auth/presentation/widgets/social_sign_in_button.dart';

/// Pantalla de registro de usuario.
///
/// Provee el [RegisterCubit] desde GetIt y delega la vista a [_RegisterView].
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RegisterCubit>(),
      child: const _RegisterView(),
    );
  }
}

// ═══════════════════════════════════════════════════════════
//  VISTA
// ═══════════════════════════════════════════════════════════

class _RegisterView extends StatefulWidget {
  const _RegisterView();

  @override
  State<_RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<_RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<RegisterCubit>().registerWithEmail(
            name: _nameController.text.trim(),
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

    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state.status == AuthFormStatus.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content:
                    Text(state.errorMessage ?? 'Error al crear la cuenta'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          context.read<RegisterCubit>().resetStatus();
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
                    const SizedBox(height: 8),

                    // ── Cabecera ─────────────────────────
                    _Header(colorScheme: cs, theme: theme),

                    const SizedBox(height: 36),

                    // ── Formulario ───────────────────────
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Nombre
                          TextFormField(
                            controller: _nameController,
                            textInputAction: TextInputAction.next,
                            textCapitalization: TextCapitalization.words,
                            decoration: const InputDecoration(
                              hintText: 'Nombre completo',
                              prefixIcon:
                                  Icon(Icons.person_outline_rounded),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Introduce tu nombre';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 16),

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

                          // Contraseña
                          BlocBuilder<RegisterCubit, RegisterState>(
                            buildWhen: (prev, curr) =>
                                prev.obscurePassword != curr.obscurePassword,
                            builder: (context, state) {
                              return TextFormField(
                                controller: _passwordController,
                                obscureText: state.obscurePassword,
                                textInputAction: TextInputAction.next,
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
                                        .read<RegisterCubit>()
                                        .togglePasswordVisibility(),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Introduce una contraseña';
                                  }
                                  if (value.length < 6) {
                                    return 'Mínimo 6 caracteres';
                                  }
                                  return null;
                                },
                              );
                            },
                          ),

                          const SizedBox(height: 16),

                          // Confirmar contraseña
                          BlocBuilder<RegisterCubit, RegisterState>(
                            buildWhen: (prev, curr) =>
                                prev.obscureConfirmPassword !=
                                curr.obscureConfirmPassword,
                            builder: (context, state) {
                              return TextFormField(
                                controller: _confirmPasswordController,
                                obscureText: state.obscureConfirmPassword,
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (_) => _onSubmit(),
                                decoration: InputDecoration(
                                  hintText: 'Confirmar contraseña',
                                  prefixIcon: const Icon(
                                      Icons.lock_outline_rounded),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      state.obscureConfirmPassword
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                    ),
                                    onPressed: () => context
                                        .read<RegisterCubit>()
                                        .toggleConfirmPasswordVisibility(),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Confirma tu contraseña';
                                  }
                                  if (value != _passwordController.text) {
                                    return 'Las contraseñas no coinciden';
                                  }
                                  return null;
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // ── Botón registro ───────────────────
                    BlocBuilder<RegisterCubit, RegisterState>(
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
                              : const Text('Crear cuenta'),
                        );
                      },
                    ),

                    const SizedBox(height: 28),

                    // ── Divider ──────────────────────────
                    _OrDivider(color: cs.onSurfaceVariant),

                    const SizedBox(height: 28),

                    // ── Botones sociales ─────────────────
                    BlocBuilder<RegisterCubit, RegisterState>(
                      buildWhen: (prev, curr) =>
                          prev.status != curr.status,
                      builder: (context, state) {
                        return Row(
                          children: [
                            SocialSignInButton.google(
                              onPressed: state.isLoading
                                  ? null
                                  : () => context
                                      .read<RegisterCubit>()
                                      .signInWithGoogle(),
                            ),
                            const SizedBox(width: 14),
                            SocialSignInButton.apple(
                              onPressed: state.isLoading
                                  ? null
                                  : () => context
                                      .read<RegisterCubit>()
                                      .signInWithApple(),
                            ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 32),

                    // ── Link a login ─────────────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '¿Ya tienes cuenta? ',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Text(
                            'Inicia sesión',
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

// ─── Cabecera con botón atrás, icono y textos ────────────
class _Header extends StatelessWidget {
  const _Header({required this.colorScheme, required this.theme});
  final ColorScheme colorScheme;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Botón atrás
        Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () => Navigator.of(context).pop(),
            style: IconButton.styleFrom(
              backgroundColor:
                  colorScheme.onSurface.withValues(alpha: 0.06),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Icono
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.25),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Icon(
            Icons.person_add_alt_1_rounded,
            color: Colors.white,
            size: 30,
          ),
        ),
        const SizedBox(height: 16),

        Text(
          'Crear cuenta',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Empieza a estudiar de forma inteligente',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
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
