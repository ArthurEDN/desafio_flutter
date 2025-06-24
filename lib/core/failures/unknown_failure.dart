import 'package:desafio_flutter/core/failures/failure.dart';

class UnknownFailure extends Failure {
  const UnknownFailure({String? details})
    : super(
        message: 'Erro inesperado. Tente novamente',
        code: 'unknown_failure',
        details: details,
      );
}
