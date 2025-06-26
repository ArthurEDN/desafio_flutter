part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginCpfChanged extends LoginEvent {
  const LoginCpfChanged(this.cpf);
  final String cpf;

  @override
  List<Object> get props => [cpf];
}

class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged(this.password);
  final String password;

  @override
  List<Object> get props => [password];
}

class LoginSubmitted extends LoginEvent {}
