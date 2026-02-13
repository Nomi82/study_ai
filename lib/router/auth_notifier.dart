import 'package:flutter/material.dart';
import 'package:study_ai/features/auth/presentation/cubit/auth_cubit.dart';

class AuthNotifier extends ChangeNotifier {
  final AuthCubit cubit;

  AuthNotifier(this.cubit) {
    cubit.stream.listen((_) {
      notifyListeners();
    });
  }
}
