import 'dart:async';
import 'package:desafio_flutter/core/config/dependecies.dart';
import 'package:desafio_flutter/presentation/auth/bloc/auth_bloc.dart';
import 'package:desafio_flutter/presentation/auth/forgot_password/screens/forgot_screen.dart';
import 'package:desafio_flutter/presentation/auth/login/screens/login_screen.dart';
import 'package:desafio_flutter/presentation/auth/register/screens/register_screen.dart';
import 'package:desafio_flutter/presentation/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'routes.dart';

final GoRouter router = GoRouter(
  initialLocation: Routes.home,
  debugLogDiagnostics: true,
  refreshListenable: GoRouterRefreshStream(locator<AuthBloc>().stream),
  redirect: (BuildContext context, GoRouterState state) {
    final authBloc = locator<AuthBloc>();
    final authStatus = authBloc.state.status;

    // Se o estado de autenticação ainda é desconhecido, não fazemos nada.
    // O router vai esperar que o estado mude para Authenticated ou Unauthenticated.
    if (authStatus == AuthStatus.unknown) {
      return null;
    }

    final isLoggedIn = authStatus == AuthStatus.authenticated;
    final location = state.matchedLocation;

    // Verifica se o destino é uma das rotas de autenticação
    final isGoingToAuthRoute =
        location == Routes.login ||
        location == Routes.register ||
        location == Routes.forgotPassword;

    // CASO 1: O usuário NÃO está logado.
    if (!isLoggedIn) {
      // Se ele já vai para uma rota de autenticação, permite.
      // Caso contrário, redireciona para o login.
      return isGoingToAuthRoute ? null : Routes.login;
    }

    // CASO 2: O usuário ESTÁ logado.
    if (isLoggedIn && isGoingToAuthRoute) {
      // Se ele tenta ir a uma tela de login/registo/etc. já estando logado,
      // redireciona para a home.
      return Routes.home;
    }

    // Em todos os outros casos (usuário utilizador logado numa rota protegida), não há redirecionamento.
    return null;
  },
  routes: <RouteBase>[
    GoRoute(
      path: Routes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: Routes.register,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: Routes.forgotPassword,
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(path: Routes.home, builder: (context, state) => const HomeScreen()),
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
