import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_ai/features/auth/data/data.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repository;

  AuthCubit(this.repository) : super(AuthInitial()) {
    repository.authStateChanges().listen((user) {
      if (user != null) {
        emit(AuthAuthenticated());
      } else {
        emit(AuthUnauthenticated());
      }
    });
  }


  

  Future<void> signInAnonymously() async {
    try {
      emit(AuthLoading());
      await repository.signInAnonymously();
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      emit(AuthLoading());
      await repository.signInWithGoogle();
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signOut() async {
    await repository.signOut();
  }
}
