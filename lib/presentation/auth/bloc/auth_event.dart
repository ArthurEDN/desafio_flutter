part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

final class AuthStateChanged extends AuthEvent {
  final User? user;
  const AuthStateChanged(this.user);
  @override
  List<Object?> get props => [user];
}

final class AuthSignOutRequested extends AuthEvent {}
