import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:study_ai/features/auth/data/data.dart';
import 'package:study_ai/features/auth/presentation/cubit/cubit.dart';

final get = GetIt.instance;

Future<void> initDependencies() async {
  /// 🔹 Servicios externos
  get.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  get.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);

  /// 🔹 Repositorio
  get.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      get<FirebaseAuth>(),
      get<FirebaseFirestore>(),
    ),
  );

  /// 🔹 Cubit
  get.registerLazySingleton<AuthCubit>(
    () => AuthCubit(get()),
  );
}
