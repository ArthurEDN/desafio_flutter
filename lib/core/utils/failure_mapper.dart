import 'package:desafio_flutter/core/failures/auth_failure.dart';
import 'package:desafio_flutter/core/failures/failure.dart';
import 'package:desafio_flutter/core/failures/firestore_failure.dart';
import 'package:desafio_flutter/core/failures/unknown_failure.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FailureMapper {
  /// Mapeia erros do FirebaseAuth para Failure
  static Failure mapFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
      case 'wrong-password':
        return const InvalidCredentialsFailure();
      case 'cpf-already-in-use':
        return const CpfAlreadyInUseFailure();
      case 'weak-password':
        return const WeakPasswordFailure();
      case 'invalid-email':
        return const InvalidCpfFailure();
      case 'too-many-requests':
        return const TooManyRequestsFailure();
      case 'user-disabled':
        return const UserDisabledFailure();
      case 'operation-not-allowed':
        return const UnknownFailure(details: 'Operação não permitida');
      default:
        return UnknownFailure(details: 'Auth error: ${e.code}');
    }
  }

  /// Mapeia erros do Firestore para Failure
  static Failure mapFirestoreError(FirebaseException e) {
    switch (e.code) {
      case 'permission-denied':
        return const PermissionDeniedFailure();
      case 'unavailable':
        return const ServiceUnavailableFailure();
      case 'not-found':
        return const DocumentNotFoundFailure();
      case 'already-exists':
        return const DocumentAlreadyExistsFailure();
      case 'resource-exhausted':
        return const QuotaExceededFailure();
      case 'deadline-exceeded':
        return const OperationTimeoutFailure();
      case 'unauthenticated':
        return const AuthenticationRequiredFailure();
      default:
        return UnknownFailure(details: 'Firestore error: ${e.code}');
    }
  }
}
