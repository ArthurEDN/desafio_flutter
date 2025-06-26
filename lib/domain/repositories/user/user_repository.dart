import 'package:desafio_flutter/core/utils/result.dart';
import 'package:desafio_flutter/domain/models/user.dart';

abstract class IUserRepository {
  Future<Result<UserEntity>> getUserProfile(String id);
}
