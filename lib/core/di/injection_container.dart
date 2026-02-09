import 'package:get_it/get_it.dart';
import 'package:study_ai/features/auth/presentation/cubit/login_cubit.dart';
import 'package:study_ai/features/auth/presentation/cubit/register_cubit.dart';

/// Instancia global del service locator.
final sl = GetIt.instance;

/// Inicializa todas las dependencias de la app.
///
/// Debe llamarse antes de [runApp] en `main.dart`.
/// Organizado por capas: externos → datasources → repos → cubits.
Future<void> initDependencies() async {
  // ─────────────────────────────────────────────────────
  //  AUTH
  // ─────────────────────────────────────────────────────

  // Cubits (factory: nueva instancia por pantalla)
  sl.registerFactory(() => LoginCubit());
  sl.registerFactory(() => RegisterCubit());

  // TODO: Registrar repositorios como lazySingleton
  // sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(...));

  // TODO: Registrar datasources
  // sl.registerLazySingleton<AuthRemoteDataSource>(
  //   () => AuthRemoteDataSourceImpl(firebaseAuth: sl(), googleSignIn: sl()),
  // );

  // TODO: Registrar servicios externos
  // sl.registerLazySingleton(() => FirebaseAuth.instance);
  // sl.registerLazySingleton(() => GoogleSignIn());
}
