import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_flutter/core/utils/failure_mapper.dart';
import 'package:desafio_flutter/core/utils/result.dart';

class FirebaseStoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference get _usersCollection => _firestore.collection('users');

  Future<Result<DocumentSnapshot>> getUserDocument(String uid) async {
    try {
      final document = await _usersCollection.doc(uid).get();
      return Result.ok(document);
    } catch (e) {
      return Result.failure(FailureMapper.mapToFailure(e));
    }
  }

  Future<Result<void>> setUserDocument(
    String uid,
    Map<String, dynamic> data,
  ) async {
    try {
      await _usersCollection.doc(uid).set(data);
      return const Result.ok(null);
    } catch (e) {
      return Result.failure(FailureMapper.mapToFailure(e));
    }
  }

  Future<Result<void>> updateUserDocument(
    String uid,
    Map<String, dynamic> data,
  ) async {
    try {
      await _usersCollection.doc(uid).update(data);
      return const Result.ok(null);
    } catch (e) {
      return Result.failure(FailureMapper.mapToFailure(e));
    }
  }

  Future<Result<bool>> userExists(String uid) async {
    final result = await getUserDocument(uid);
    return switch (result) {
      Ok(value: final doc) => Result.ok(doc.exists),
      Error(failure: final failure) => Result.failure(
        FailureMapper.mapToFailure(failure),
      ),
    };
  }

  Future<Result<QuerySnapshot>> findUserByRealEmail(String email) async {
    try {
      final querySnapshot = await _usersCollection
          .where('email', isEqualTo: email)
          .limit(1)
          .get();
      return Result.ok(querySnapshot);
    } catch (e) {
      return Result.failure(FailureMapper.mapToFailure(e));
    }
  }
}
