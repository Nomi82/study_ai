import 'package:equatable/equatable.dart';

/// Estado posible del formulario de auth.
enum AuthFormStatus { initial, loading, success, failure }

/// Estado de la pantalla de login.
///
/// Gestiona visibilidad de contraseña, estado de carga
/// y mensajes de error.
class LoginState extends Equatable {
  const LoginState({
    this.obscurePassword = true,
    this.status = AuthFormStatus.initial,
    this.errorMessage,
  });

  /// Si la contraseña está oculta.
  final bool obscurePassword;

  /// Estado actual del formulario (loading, success, etc.).
  final AuthFormStatus status;

  /// Mensaje de error (solo cuando [status] == failure).
  final String? errorMessage;

  /// Si el formulario está procesando una petición.
  bool get isLoading => status == AuthFormStatus.loading;

  LoginState copyWith({
    bool? obscurePassword,
    AuthFormStatus? status,
    String? errorMessage,
  }) {
    return LoginState(
      obscurePassword: obscurePassword ?? this.obscurePassword,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [obscurePassword, status, errorMessage];
}
