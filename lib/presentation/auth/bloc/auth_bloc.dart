import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:desafio_flutter/domain/repositories/auth/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _authRepository;
  StreamSubscription<User?>? _userSubscription;

  AuthBloc({required IAuthRepository authRepository})
    : _authRepository = authRepository,
      super(const AuthState.unknown()) {
    on<AuthStateChanged>(_onAuthStateChanged);
    on<AuthSignOutRequested>(_onSignOutRequested);

    _userSubscription = _authRepository.authStateChanges.listen(
      (user) => add(AuthStateChanged(user)),
    );
  }

  void _onAuthStateChanged(AuthStateChanged event, Emitter<AuthState> emit) {
    emit(
      event.user != null
          ? AuthState.authenticated(event.user!)
          : const AuthState.unauthenticated(),
    );
  }

  void _onSignOutRequested(
    AuthSignOutRequested event,
    Emitter<AuthState> emit,
  ) {
    _authRepository.signOut();
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
