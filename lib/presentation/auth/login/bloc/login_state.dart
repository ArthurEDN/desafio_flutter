part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.cpf = const Cpf.pure(),
    this.password = const Password.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.errorMessage,
  });

  final Cpf cpf;
  final Password password;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String? errorMessage;
  LoginState copyWith({
    Cpf? cpf,
    Password? password,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? errorMessage,
  }) {
    return LoginState(
      cpf: cpf ?? this.cpf,
      password: password ?? this.password,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [cpf, password, status, isValid, errorMessage];
}
