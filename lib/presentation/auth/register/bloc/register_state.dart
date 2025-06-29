part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final Name name;
  final Email email;
  final Cpf cpf;
  final Password password;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String? errorMessage;

  const RegisterState({
    this.name = const Name.pure(),
    this.email = const Email.pure(),
    this.cpf = const Cpf.pure(),
    this.password = const Password.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.errorMessage,
  });

  RegisterState copyWith({
    Name? name,
    Email? email,
    Cpf? cpf,
    Password? password,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? errorMessage,
  }) {
    return RegisterState(
      name: name ?? this.name,
      email: email ?? this.email,
      cpf: cpf ?? this.cpf,
      password: password ?? this.password,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    name,
    email,
    cpf,
    password,
    status,
    isValid,
    errorMessage,
  ];
}
