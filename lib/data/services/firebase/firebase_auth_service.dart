import 'package:desafio_flutter/core/utils/failure_mapper.dart';
import 'package:desafio_flutter/core/utils/result.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<Result<UserCredential>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user == null) {
        return Result.failure(
          FailureMapper.mapToFailure(
            Exception('Login falhou: usuário não encontrado'),
          ),
        );
      }
      return Result.ok(credential);
    } catch (e) {
      return Result.failure(FailureMapper.mapToFailure(e));
    }
  }

  Future<Result<UserCredential>> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        return Result.failure(
          FailureMapper.mapToFailure(
            Exception('Criação de usuário falhou: usuário não criado'),
          ),
        );
      }

      return Result.ok(credential);
    } catch (e) {
      return Result.failure(FailureMapper.mapToFailure(e));
    }
  }

  Future<Result<void>> signOut() async {
    try {
      await _auth.signOut();
      return Result.ok(null);
    } catch (e) {
      return Result.failure(FailureMapper.mapToFailure(e));
    }
  }

  Future<Result<void>> requestPasswordReset({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return const Result.ok(null);
    } catch (e) {
      return Result.failure(FailureMapper.mapToFailure(e));
    }
  }

  Future<Result<User?>> getCurrentUser() async {
    try {
      final firebaseUser = _auth.currentUser;
      return Result.ok(firebaseUser);
    } catch (e) {
      return Result.failure(FailureMapper.mapToFailure(e));
    }
  }
}
