import 'package:desafio_flutter/core/failures/failure.dart';

abstract class NetworkFailure extends Failure {
  const NetworkFailure({
    required super.message,
    required super.code,
    super.details,
  });
}

class NoInternetConnectionFailure extends NetworkFailure {
  const NoInternetConnectionFailure()
    : super(
        message: 'Sem conexão com a internet',
        code: 'no_internet_connection',
      );
}

class TimeoutFailure extends NetworkFailure {
  const TimeoutFailure()
    : super(message: 'Tempo limite excedido', code: 'timeout');
}

class ServerFailure extends NetworkFailure {
  const ServerFailure()
    : super(message: 'Erro no servidor. Tente novamente', code: 'server_error');
}
