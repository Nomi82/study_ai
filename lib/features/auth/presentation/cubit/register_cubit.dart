import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_state.dart' show AuthFormStatus;
import 'register_state.dart';

/// Cubit que gestiona toda la lógica de la pantalla de Registro.
///
/// Controla:
/// - Toggle de visibilidad de contraseña y confirmación
/// - Registro con correo/contraseña
/// - Registro con Google
/// - Registro con Apple
class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(const RegisterState());

  /// Alterna la visibilidad de la contraseña.
  void togglePasswordVisibility() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  /// Alterna la visibilidad de la confirmación de contraseña.
  void toggleConfirmPasswordVisibility() {
    emit(state.copyWith(
      obscureConfirmPassword: !state.obscureConfirmPassword,
    ));
  }

  /// Crea una cuenta con correo, contraseña y nombre.
  Future<void> registerWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: AuthFormStatus.loading));
    try {
      // TODO: Implementar con Firebase Auth
      // await _authRepository.createUserWithEmail(name, email, password);
      emit(state.copyWith(status: AuthFormStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: AuthFormStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  /// Registra / inicia sesión con Google.
  Future<void> signInWithGoogle() async {
    emit(state.copyWith(status: AuthFormStatus.loading));
    try {
      // TODO: Implementar con Google Sign-In + Firebase Auth
      emit(state.copyWith(status: AuthFormStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: AuthFormStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  /// Registra / inicia sesión con Apple.
  Future<void> signInWithApple() async {
    emit(state.copyWith(status: AuthFormStatus.loading));
    try {
      // TODO: Implementar con Sign in with Apple + Firebase Auth
      emit(state.copyWith(status: AuthFormStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: AuthFormStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  /// Resetea el estado a inicial.
  void resetStatus() {
    emit(state.copyWith(status: AuthFormStatus.initial));
  }
}
