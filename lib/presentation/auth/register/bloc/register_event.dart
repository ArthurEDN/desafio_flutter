part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

final class RegisterNameChanged extends RegisterEvent {
  const RegisterNameChanged(this.name);
  final String name;

  @override
  List<Object> get props => [name];
}

final class RegisterEmailChanged extends RegisterEvent {
  const RegisterEmailChanged(this.email);
  final String email;

  @override
  List<Object> get props => [email];
}

final class RegisterCpfChanged extends RegisterEvent {
  const RegisterCpfChanged(this.cpf);
  final String cpf;

  @override
  List<Object> get props => [cpf];
}

final class RegisterPasswordChanged extends RegisterEvent {
  const RegisterPasswordChanged(this.password);
  final String password;

  @override
  List<Object> get props => [password];
}

final class RegisterSubmitted extends RegisterEvent {
  const RegisterSubmitted();
}
