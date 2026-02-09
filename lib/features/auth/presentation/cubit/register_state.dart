import 'package:equatable/equatable.dart';
import 'login_state.dart' show AuthFormStatus;

/// Estado de la pantalla de registro.
///
/// Gestiona visibilidad de ambos campos de contraseña,
/// estado de carga y mensajes de error.
class RegisterState extends Equatable {
  const RegisterState({
    this.obscurePassword = true,
    this.obscureConfirmPassword = true,
    this.status = AuthFormStatus.initial,
    this.errorMessage,
  });

  /// Si la contraseña está oculta.
  final bool obscurePassword;

  /// Si la confirmación de contraseña está oculta.
  final bool obscureConfirmPassword;

  /// Estado actual del formulario.
  final AuthFormStatus status;

  /// Mensaje de error (solo cuando [status] == failure).
  final String? errorMessage;

  /// Si el formulario está procesando una petición.
  bool get isLoading => status == AuthFormStatus.loading;

  RegisterState copyWith({
    bool? obscurePassword,
    bool? obscureConfirmPassword,
    AuthFormStatus? status,
    String? errorMessage,
  }) {
    return RegisterState(
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword:
          obscureConfirmPassword ?? this.obscureConfirmPassword,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        obscurePassword,
        obscureConfirmPassword,
        status,
        errorMessage,
      ];
}
