import 'dart:async';

import 'package:desafio_flutter/core/config/dependecies.dart';
import 'package:desafio_flutter/presentation/auth/bloc/auth_bloc.dart';
import 'package:desafio_flutter/presentation/auth/login/views/login_screen.dart';
import 'package:desafio_flutter/presentation/auth/register/views/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'routes.dart';

final GoRouter router = GoRouter(
  initialLocation: Routes.home,
  debugLogDiagnostics: true,
  refreshListenable: GoRouterRefreshStream(locator<AuthBloc>().stream),
  redirect: (BuildContext context, GoRouterState state) {
    final authBloc = locator<AuthBloc>();
    final bool isLoggedIn = authBloc.state.status == AuthStatus.authenticated;

    final bool isLoggingIn = state.matchedLocation == Routes.login;
    final bool isRegistering = state.matchedLocation == Routes.register;

    if (!isLoggedIn) {
      return isLoggingIn || isRegistering ? null : Routes.login;
    }

    if (isLoggingIn || isRegistering) {
      return Routes.home;
    }

    return null;
  },
  routes: <RouteBase>[
    GoRoute(
      path: Routes.login,
      pageBuilder: (context, state) => CustomTransitionPage<void>(
        key: state.pageKey,
        child: const LoginScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
            child: ScaleTransition(
              scale: CurveTween(curve: Curves.easeOutCirc).animate(animation),
              child: child,
            ),
          );
        },
      ),
    ),
    GoRoute(
      path: Routes.register,
      pageBuilder: (context, state) => CustomTransitionPage<void>(
        key: state.pageKey,
        child: const RegisterScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
            child: ScaleTransition(
              scale: CurveTween(curve: Curves.easeOutCirc).animate(animation),
              child: child,
            ),
          );
        },
      ),
    ),
    //GoRoute(path: Routes.home, builder: (context, state) => const HomeScreen()),
  ],
);

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (dynamic _) => notifyListeners(),
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
