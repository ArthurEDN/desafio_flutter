import 'package:desafio_flutter/core/failures/failure.dart';

abstract class FirestoreFailure extends Failure {
  const FirestoreFailure({
    required super.message,
    required super.code,
    super.details,
  });
}

class PermissionDeniedFailure extends FirestoreFailure {
  const PermissionDeniedFailure()
    : super(
        message: 'Permissão negada para acessar os dados',
        code: 'permission_denied',
      );
}

class DocumentNotFoundFailure extends FirestoreFailure {
  const DocumentNotFoundFailure()
    : super(message: 'Documento não encontrado', code: 'document_not_found');
}

class ServiceUnavailableFailure extends FirestoreFailure {
  const ServiceUnavailableFailure()
    : super(
        message: 'Serviço temporariamente indisponível. Verifique sua conexão',
        code: 'service_unavailable',
      );
}

class DocumentAlreadyExistsFailure extends FirestoreFailure {
  const DocumentAlreadyExistsFailure()
    : super(message: 'Documento já existe', code: 'document_already_exists');
}

class QuotaExceededFailure extends FirestoreFailure {
  const QuotaExceededFailure()
    : super(
        message: 'Cota excedida. Tente novamente mais tarde',
        code: 'quota_exceeded',
      );
}

class OperationTimeoutFailure extends FirestoreFailure {
  const OperationTimeoutFailure()
    : super(
        message: 'Operação demorou muito para ser concluída',
        code: 'operation_timeout',
      );
}
