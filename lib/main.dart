import 'package:desafio_flutter/core/config/dependecies.dart';
import 'package:desafio_flutter/core/themes/theme.dart';
import 'package:desafio_flutter/presentation/auth/bloc/auth_bloc.dart';
import 'package:desafio_flutter/presentation/auth/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:desafio_flutter/presentation/auth/login/bloc/login_bloc.dart';
import 'package:desafio_flutter/presentation/auth/register/bloc/register_bloc.dart';
import 'package:desafio_flutter/presentation/home/bloc/home_bloc.dart';
import 'package:desafio_flutter/core/routing/router.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => locator<AuthBloc>()),
        BlocProvider<LoginBloc>(create: (context) => locator<LoginBloc>()),
        BlocProvider<RegisterBloc>(
          create: (context) => locator<RegisterBloc>(),
        ),
        BlocProvider<ForgotPasswordBloc>(
          create: (context) => locator<ForgotPasswordBloc>(),
        ),
        BlocProvider<HomeBloc>(create: (context) => locator<HomeBloc>()),
      ],
      child: MaterialApp.router(
        title: 'Desafio Flutter',
        theme: AppTheme.darkTheme,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
