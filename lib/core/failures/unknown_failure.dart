import 'package:desafio_flutter/core/failures/failure.dart';

class UnknownFailure extends Failure {
  const UnknownFailure({super.details})
    : super(
        message: 'Erro inesperado. Tente novamente',
        code: 'unknown_failure',
      );
}
