import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_flutter/domain/models/user.dart';
import 'package:desafio_flutter/utils/result.dart';
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
        return Result.error(Exception('Falha no login'));
      }
      return Result.ok(credential);
    } on FirebaseAuthException catch (e) {
      return Result.error(
        FirebaseAuthException(
          message: _getAuthErrorMessage(e.code),
          code: e.code,
        ),
      );
    } catch (e) {
      return Result.error(Exception('Erro inesperado: ${e.toString()}'));
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
        return Result.error(Exception('Falha ao criar usuário'));
      }

      return Result.ok(credential);
    } on FirebaseAuthException catch (e) {
      return Result.error(
        FirebaseAuthException(
          message: _getAuthErrorMessage(e.code),
          code: e.code,
        ),
      );
    } catch (e) {
      return Result.error(Exception('Erro inesperado: ${e.toString()}'));
    }
  }

  Future<Result<void>> signOut() async {
    try {
      await _auth.signOut();
      return Result.ok(null);
    } catch (e) {
      return Result.error(Exception('Erro ao fazer logout: ${e.toString()}'));
    }
  }

  Future<Result<void>> requestPasswordReset({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return const Result.ok(null);
    } on FirebaseAuthException catch (e) {
      return Result.error(
        FirebaseAuthException(
          message: _getAuthErrorMessage(e.code),
          code: e.code,
        ),
      );
    } catch (e) {
      return Result.error(Exception('Erro inesperado: $e'));
    }
  }

  Future<Result<User?>> getCurrentUser() async {
    try {
      final firebaseUser = _auth.currentUser;
      if (firebaseUser == null) {
        return const Result.ok(null);
      }
      return Result.ok(firebaseUser);
    } catch (e) {
      return Result.error(Exception('Erro ao obter usuário: $e'));
    }
  }

  String _getAuthErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'CPF não encontrado';
      case 'wrong-password':
        return 'Senha incorreta';
      case 'email-already-in-use':
        return 'CPF já está em uso';
      case 'weak-password':
        return 'Senha muito fraca';
      case 'invalid-email':
        return 'CPF inválido';
      case 'too-many-requests':
        return 'Muitas tentativas. Tente novamente mais tarde';
      default:
        return 'Erro de autenticação: $code';
    }
  }
}
