import 'package:desafio_flutter/core/failures/firestore_failure.dart';
import 'package:desafio_flutter/data/services/firebase/firebase_auth_service.dart';
import 'package:desafio_flutter/data/services/firebase/firestore_service.dart';
import 'package:desafio_flutter/domain/repositories/auth/auth_repository.dart';
import 'package:desafio_flutter/domain/models/user.dart';
import 'package:desafio_flutter/core/utils/result.dart';
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

    if (credentialResult.isFailure) {
      return Result.failure(credentialResult.failureOrNull!);
    }

    final credential = credentialResult.value;
    final uid = credential.user!.uid;
    final docResult = await _firestore.getUserDocument(uid);

    if (docResult.isFailure) {
      return Result.failure(docResult.failureOrNull!);
    }

    final userDoc = docResult.value;

    if (userDoc.exists) {
      final userData = userDoc.data() as Map<String, dynamic>;
      final user = UserEntity.fromMap({'id': uid, ...userData});
      return Result.ok(user);
    } else {
      return const Result.failure(DocumentNotFoundFailure());
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
    if (credentialResult.isFailure) {
      return Result.failure(credentialResult.failureOrNull!);
    }

    final credential = credentialResult.value;
    final uid = credential.user!.uid;
    final user = UserEntity(id: uid, name: name, cpf: cpf, email: email);
    final setResult = await _firestore.setUserDocument(uid, user.toMap());

    if (setResult.isFailure) {
      return Result.failure(setResult.failureOrNull!);
    }

    return Result.ok(user);
  }

  @override
  Future<Result<void>> signOut() async {
    return await _firebaseAuth.signOut();
  }

  @override
  Future<Result<void>> requestPasswordReset({required String email}) async {
    final userQueryResult = await _firestore.findUserByRealEmail(email);

    if (userQueryResult.isFailure) {
      return Result.failure(userQueryResult.failureOrNull!);
    }

    final querySnapshot = userQueryResult.value;

    if (querySnapshot.docs.isNotEmpty) {
      final userData = querySnapshot.docs.first.data() as Map<String, dynamic>;
      final cpf = userData['cpf'] as String?;

      if (cpf != null) {
        return await _firebaseAuth.requestPasswordReset(
          email: _cpfToEmail(cpf),
        );
      }
    }
    return const Result.ok(null);
  }

  @override
  Future<Result<UserEntity?>> getCurrentUser() async {
    final userResult = await _firebaseAuth.getCurrentUser();
    if (userResult.isFailure) {
      return Result.failure(userResult.failureOrNull!);
    }

    final firebaseUser = userResult.value;

    if (firebaseUser == null) {
      return Result.ok(null);
    }

    final docResult = await _firestore.getUserDocument(firebaseUser.uid);

    if (docResult.isFailure) {
      return Result.failure(docResult.failureOrNull!);
    }

    final userDoc = docResult.value;

    if (userDoc.exists) {
      final userData = userDoc.data() as Map<String, dynamic>;
      final user = UserEntity.fromMap({'id': firebaseUser.uid, ...userData});
      return Result.ok(user);
    } else {
      return const Result.failure(DocumentNotFoundFailure());
    }
  }

  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges;
}
