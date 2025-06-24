import 'package:desafio_flutter/data/services/firebase/firebase_auth_service.dart';
import 'package:desafio_flutter/data/services/firebase/firestore_service.dart';
import 'package:desafio_flutter/domain/repositories/auth/auth_repository.dart';
import 'package:desafio_flutter/domain/models/user.dart';
import 'package:desafio_flutter/utils/result.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepository extends IAuthRepository {
  final FirebaseAuthService _firebaseAuth;
  final FirebaseStoreService _firestore;

  FirebaseAuthRepository({
    required FirebaseAuthService firebaseAuthService,
    required FirebaseStoreService firestoreService,
  }) : _firebaseAuth = firebaseAuthService,
       _firestore = firestoreService;

  String _cpfToEmail(String cpf) {
    final cleanCpf = cpf.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleanCpf.length != 11) {
      throw ArgumentError('CPF deve ter 11 dígitos');
    }
    return '$cleanCpf@desafio.flutter';
  }

  @override
  Future<Result<UserEntity>> signIn({
    required String cpf,
    required String password,
  }) async {
    final credentialResult = await _firebaseAuth.signInWithEmailAndPassword(
      email: _cpfToEmail(cpf),
      password: password,
    );
    switch (credentialResult) {
      case Ok(value: final credential):
        final docResult = await _firestore.getUserDocument(
          credential.user!.uid,
        );

        switch (docResult) {
          case Ok(value: final userDoc):
            if (userDoc.exists) {
              final userData = userDoc.data() as Map<String, dynamic>;
              final user = UserEntity.fromMap({
                'id': credential.user!.uid,
                ...userData,
              });
              return Result.ok(user);
            } else {
              return Result.error(
                Exception('Dados do usuário não encontrados.'),
              );
            }

          case Error(error: final firestoreError):
            return Result.error(firestoreError);
        }

      case Error(error: final authError):
        return Result.error(authError);
    }
  }

  @override
  Future<Result<UserEntity>> signUp({
    required String cpf,
    required String password,
    required String name,
    required String email,
  }) async {
    final credentialResult = await _firebaseAuth.createUserWithEmailAndPassword(
      email: _cpfToEmail(cpf),
      password: password,
    );

    switch (credentialResult) {
      case Ok(value: final credential):
        final user = UserEntity(
          id: credential.user!.uid,
          name: name,
          cpf: cpf,
          email: email,
        );

        final setResult = await _firestore.setUserDocument(
          credential.user!.uid,
          user.toMap(),
        );

        return switch (setResult) {
          Ok() => Result.ok(user),
          Error(error: final firestoreError) => Result.error(firestoreError),
        };

      case Error(error: final authError):
        return Result.error(authError);
    }
  }

  @override
  Future<Result<void>> signOut() async {
    return await _firebaseAuth.signOut();
  }

  @override
  Future<Result<void>> requestPasswordReset({required String email}) async {
    try {
      final userQueryResult = await _firestore.findUserByRealEmail(email);

      switch (userQueryResult) {
        case Ok(value: final querySnapshot):
          if (querySnapshot.docs.isNotEmpty) {
            final userData =
                querySnapshot.docs.first.data() as Map<String, dynamic>;
            final cpf = userData['cpf'] as String?;

            if (cpf != null) {
              await _firebaseAuth.requestPasswordReset(email: _cpfToEmail(cpf));
            }
          }
          break;

        case Error(error: final error):
          print('Erro de Firestore durante o reset de senha: $error');
          break;
      }
      return const Result.ok(null);
    } catch (e) {
      print('Erro inesperado durante o requestPasswordReset: $e');
      return const Result.ok(null);
    }
  }

  @override
  Future<Result<UserEntity?>> getCurrentUser() async {
    final userResult = await _firebaseAuth.getCurrentUser();

    switch (userResult) {
      case Ok(value: final firebaseUser):
        if (firebaseUser == null) {
          return Result.ok(null);
        }

        final docResult = await _firestore.getUserDocument(firebaseUser.uid);

        switch (docResult) {
          case Ok(value: final userDoc):
            if (userDoc.exists) {
              final userData = userDoc.data() as Map<String, dynamic>;
              final user = UserEntity.fromMap({
                'id': firebaseUser.uid,
                ...userData,
              });
              return Result.ok(user);
            } else {
              return Result.error(
                Exception(
                  'Usuário autenticado, mas sem dados no banco de dados.',
                ),
              );
            }
          case Error(error: final firestoreError):
            return Result.error(firestoreError);
        }

      case Error(error: final authError):
        return Result.error(authError);
    }
  }

  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges;
}
