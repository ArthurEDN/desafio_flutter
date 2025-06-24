import 'package:desafio_flutter/core/failures/failure.dart';

abstract class AuthFailure extends Failure {
  const AuthFailure({
    required super.message,
    required super.code,
    super.details,
  });
}

class InvalidCredentialsFailure extends AuthFailure {
  const InvalidCredentialsFailure()
    : super(message: 'CPF ou senha incorretos', code: 'invalid_credentials');
}

class UserNotFoundFailure extends AuthFailure {
  const UserNotFoundFailure()
    : super(message: 'Usuário não encontrado', code: 'user_not_found');
}

class WeakPasswordFailure extends AuthFailure {
  const WeakPasswordFailure()
    : super(
        message: 'Senha deve ter pelo menos 6 caracteres',
        code: 'weak_password',
      );
}

class CpfAlreadyInUseFailure extends AuthFailure {
  const CpfAlreadyInUseFailure()
    : super(
        message: 'Este CPF já está cadastrado',
        code: 'email_already_in_use',
      );
}

class TooManyRequestsFailure extends AuthFailure {
  const TooManyRequestsFailure()
    : super(
        message: 'Muitas tentativas. Tente novamente em alguns minutos',
        code: 'too_many_requests',
      );
}

class InvalidCpfFailure extends AuthFailure {
  const InvalidCpfFailure()
    : super(message: 'CPF inválido', code: 'invalid_email');
}

class UserDisabledFailure extends AuthFailure {
  const UserDisabledFailure()
    : super(
        message: 'Conta desativada. Entre em contato com o suporte',
        code: 'user_disabled',
      );
}

class AuthenticationRequiredFailure extends AuthFailure {
  const AuthenticationRequiredFailure()
    : super(
        message: 'É necessário fazer login para continuar',
        code: 'authentication_required',
      );
}

class NetworkRequestFailedFailure extends AuthFailure {
  const NetworkRequestFailedFailure()
    : super(
        message: 'Sem conexão com a internet',
        code: 'network_request_failed',
      );
}

class UnknownAuthFailure extends AuthFailure {
  const UnknownAuthFailure({String? details})
    : super(
        message: 'Erro na autenticação. Tente novamente',
        code: 'unknown_auth_error',
        details: details,
      );
}
