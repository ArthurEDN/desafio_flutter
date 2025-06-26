import 'package:desafio_flutter/data/respositories/auth/firebase_repository.dart';
import 'package:desafio_flutter/data/respositories/user/user_repository.dart';
import 'package:desafio_flutter/data/services/firebase/firebase_auth_service.dart';
import 'package:desafio_flutter/data/services/firebase/firestore_service.dart';
import 'package:desafio_flutter/domain/repositories/auth/auth_repository.dart';
import 'package:desafio_flutter/domain/repositories/user/user_repository.dart';
import 'package:desafio_flutter/presentation/auth/bloc/auth_bloc.dart';
import 'package:desafio_flutter/presentation/auth/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:desafio_flutter/presentation/auth/login/bloc/login_bloc.dart';
import 'package:desafio_flutter/presentation/auth/register/bloc/register_bloc.dart';
import 'package:desafio_flutter/presentation/home/bloc/home_bloc.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => FirebaseAuthService());
  locator.registerLazySingleton(() => FirebaseStoreService());

  locator.registerLazySingleton<IAuthRepository>(
    () => FirebaseAuthRepository(
      firebaseAuthService: locator<FirebaseAuthService>(),
      firestoreService: locator<FirebaseStoreService>(),
    ),
  );

  locator.registerLazySingleton<IUserRepository>(
    () => UserRepositoryImpl(storeService: locator<FirebaseStoreService>()),
  );

  locator.registerFactory(
    () => AuthBloc(authRepository: locator<IAuthRepository>()),
  );

  locator.registerFactory(
    () => LoginBloc(authRepository: locator<IAuthRepository>()),
  );

  locator.registerFactory(
    () => RegisterBloc(authRepository: locator<IAuthRepository>()),
  );

  locator.registerFactory(
    () => ForgotPasswordBloc(authRepository: locator<IAuthRepository>()),
  );

  locator.registerFactory(
    () => HomeBloc(userRepository: locator<IUserRepository>()),
  );
}
