import 'package:desafio_flutter/core/failures/firestore_failure.dart';
import 'package:desafio_flutter/core/utils/result.dart';
import 'package:desafio_flutter/data/services/firebase/firestore_service.dart';
import 'package:desafio_flutter/domain/models/user.dart';
import 'package:desafio_flutter/domain/repositories/user/user_repository.dart';

class UserRepositoryImpl implements IUserRepository {
  final FirebaseStoreService _storeService;

  UserRepositoryImpl({required FirebaseStoreService storeService})
    : _storeService = storeService;

  @override
  Future<Result<UserEntity>> getUserProfile(String id) async {
    final docResult = await _storeService.getUserDocument(id);

    if (docResult.isFailure) {
      return Result.failure(docResult.failureOrNull!);
    }
    final userDoc = docResult.value;

    if (userDoc.exists) {
      final user = UserEntity.fromMap(userDoc.data() as Map<String, dynamic>);
      return Result.ok(user);
    } else {
      return const Result.failure(DocumentNotFoundFailure());
    }
  }
}
