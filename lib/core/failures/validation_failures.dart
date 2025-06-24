import 'package:desafio_flutter/core/failures/failure.dart';

abstract class ValidationFailure extends Failure {
  const ValidationFailure({
    required super.message,
    required super.code,
    super.details,
  });
}

class InvalidEmailFailure extends ValidationFailure {
  const InvalidEmailFailure()
    : super(message: 'Email inválido', code: 'invalid_email');
}

class InvalidNameFailure extends ValidationFailure {
  const InvalidNameFailure()
    : super(
        message: 'Nome deve ter pelo menos 2 caracteres',
        code: 'invalid_name',
      );
}

class InvalidPasswordFailure extends ValidationFailure {
  const InvalidPasswordFailure()
    : super(
        message: 'Senha deve ter pelo menos 6 caracteres',
        code: 'invalid_password',
      );
}

class CpfFormatFailure extends ValidationFailure {
  const CpfFormatFailure()
    : super(message: 'CPF deve ter 11 dígitos', code: 'cpf_format_failure');
}

class CpfValidationFailure extends ValidationFailure {
  const CpfValidationFailure()
    : super(message: 'CPF inválido', code: 'cpf_validation_failure');
}
