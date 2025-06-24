import 'package:desafio_flutter/core/failures/failure.dart';

abstract class UserFailure extends Failure {
  const UserFailure({
    required super.message,
    required super.code,
    super.details,
  });
}

class UserDataNotFoundFailure extends UserFailure {
  const UserDataNotFoundFailure()
    : super(
        message: 'Dados do usuário não encontrados',
        code: 'user_data_not_found',
      );
}

class IncompleteUserDataFailure extends UserFailure {
  const IncompleteUserDataFailure()
    : super(
        message: 'Dados do usuário incompletos',
        code: 'incomplete_user_data',
      );
}

class UserProfileUpdateFailure extends UserFailure {
  const UserProfileUpdateFailure()
    : super(
        message: 'Erro ao atualizar perfil do usuário',
        code: 'user_profile_update_failure',
      );
}
