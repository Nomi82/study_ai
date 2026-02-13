import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_ai/core/di/injection.dart';
import 'package:study_ai/features/auth/auth.dart';
import 'package:study_ai/features/home/presentation/presentation.dart';
import 'package:study_ai/features/splash/presentation/splash_screen.dart';
import 'package:study_ai/router/auth_notifier.dart';

abstract class AppRoutes {
  static const splash = '/';
  static const auth = '/auth';
  static const home = '/home';
}

GoRouter createRouter() {
  final authCubit = get<AuthCubit>();

  return GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: AuthNotifier(authCubit),

    redirect: (context, state) {
      final authState = authCubit.state;
      final isLoggingIn = state.matchedLocation == AppRoutes.auth;
      final isSplash = state.matchedLocation == AppRoutes.splash;

      if (authState is AuthLoading) {
        return AppRoutes.splash;
      }

      if (authState is AuthUnauthenticated) {
        return isLoggingIn ? null : AppRoutes.auth;
      }

      if (authState is AuthAuthenticated) {
        return AppRoutes.home;
      }

      return null;
    },

    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (_, __) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.auth,
        builder: (_, __) => const AuthScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (_, __) => const HomeScreen(),
      ),
    ],
  );
}
