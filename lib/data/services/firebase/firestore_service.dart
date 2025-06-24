import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_flutter/utils/result.dart';

class FirebaseStoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference get _usersCollection => _firestore.collection('users');

  Future<Result<DocumentSnapshot>> getUserDocument(String uid) async {
    try {
      final document = await _usersCollection.doc(uid).get();
      return Result.ok(document);
    } on FirebaseException catch (e) {
      return Result.error(_createFirebaseException(e));
    } catch (e) {
      return Result.error(Exception('Erro inesperado no Firestore: $e'));
    }
  }

  Future<Result<void>> setUserDocument(
    String uid,
    Map<String, dynamic> data,
  ) async {
    try {
      await _usersCollection.doc(uid).set(data);
      return const Result.ok(null);
    } on FirebaseException catch (e) {
      return Result.error(_createFirebaseException(e));
    } catch (e) {
      return Result.error(Exception('Erro inesperado no Firestore: $e'));
    }
  }

  Future<Result<void>> updateUserDocument(
    String uid,
    Map<String, dynamic> data,
  ) async {
    try {
      await _usersCollection.doc(uid).update(data);
      return const Result.ok(null);
    } on FirebaseException catch (e) {
      return Result.error(_createFirebaseException(e));
    } catch (e) {
      return Result.error(Exception('Erro inesperado no Firestore: $e'));
    }
  }

  Future<Result<bool>> userExists(String uid) async {
    final result = await getUserDocument(uid);
    return switch (result) {
      Ok(value: final doc) => Result.ok(doc.exists),
      Error(error: final e) => Result.error(e),
    };
  }

  Future<Result<QuerySnapshot>> findUserByRealEmail(String email) async {
    try {
      final querySnapshot = await _usersCollection
          .where('email', isEqualTo: email)
          .limit(1)
          .get();
      return Result.ok(querySnapshot);
    } on FirebaseException catch (e) {
      return Result.error(_createFirebaseException(e));
    } catch (e) {
      return Result.error(Exception('Erro inesperado no Firestore: $e'));
    }
  }

  FirebaseException _createFirebaseException(FirebaseException e) {
    return FirebaseException(
      plugin: 'cloud_firestore',
      message: _getFirestoreErrorMessage(e.code),
      code: e.code,
    );
  }

  String _getFirestoreErrorMessage(String code) {
    switch (code) {
      case 'permission-denied':
        return 'Permissão negada para acessar os dados';
      case 'unavailable':
        return 'Serviço temporariamente indisponível. Verifique sua conexão';
      case 'not-found':
        return 'Documento não encontrado';
      case 'already-exists':
        return 'Documento já existe';
      case 'resource-exhausted':
        return 'Cota excedida. Tente novamente mais tarde';
      case 'failed-precondition':
        return 'Condição prévia falhou';
      case 'aborted':
        return 'Operação abortada devido a conflito';
      case 'invalid-argument':
        return 'Argumento inválido fornecido';
      case 'deadline-exceeded':
        return 'Tempo limite da operação excedido';
      case 'unauthenticated':
        return 'Usuário não autenticado';
      default:
        return 'Erro no banco de dados: $code';
    }
  }
}
