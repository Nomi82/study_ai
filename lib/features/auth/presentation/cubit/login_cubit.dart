import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_state.dart';

/// Cubit que gestiona toda la lógica de la pantalla de Login.
///
/// Controla:
/// - Toggle de visibilidad de contraseña
/// - Login con correo/contraseña
/// - Login con Google
/// - Login con Apple
class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  /// Alterna la visibilidad de la contraseña.
  void togglePasswordVisibility() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  /// Inicia sesión con correo y contraseña.
  Future<void> loginWithEmail({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: AuthFormStatus.loading));
    try {
      // TODO: Implementar con Firebase Auth
      // await _authRepository.signInWithEmail(email, password);
      emit(state.copyWith(status: AuthFormStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: AuthFormStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  /// Inicia sesión con Google.
  Future<void> loginWithGoogle() async {
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

  /// Inicia sesión con Apple.
  Future<void> loginWithApple() async {
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

  /// Resetea el estado a inicial (tras mostrar un error, por ejemplo).
  void resetStatus() {
    emit(state.copyWith(status: AuthFormStatus.initial));
  }
}
