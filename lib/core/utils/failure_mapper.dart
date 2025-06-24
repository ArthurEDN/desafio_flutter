import 'dart:async';
import 'dart:io';
import 'package:desafio_flutter/core/failures/auth_failure.dart';
import 'package:desafio_flutter/core/failures/firestore_failure.dart';
import 'package:desafio_flutter/core/failures/network_failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_flutter/core/failures/unknown_failure.dart';
import 'package:desafio_flutter/core/failures/failure.dart';

class FailureMapper {
  /// Mapeia exceções para objetos Failure
  static Failure mapToFailure(Object error) {
    if (error is FirebaseAuthException) {
      return _mapFirebaseAuthError(error);
    }
    if (error is FirebaseException) {
      return _mapFirestoreError(error);
    }
    if (error is SocketException) {
      return const NoInternetConnectionFailure();
    }
    if (error is TimeoutException) {
      return const TimeoutFailure();
    }
    return UnknownFailure(details: error.toString());
  }

  /// Mapeia exceções para strings (para compatibilidade)
  static String mapToString(Object error) {
    return mapToFailure(error).message;
  }

  static AuthFailure _mapFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      // Credenciais inválidas - CPF ou senha incorretos
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return const InvalidCredentialsFailure();

      // CPF já cadastrado (Firebase retorna email-already-in-use)
      case 'email-already-in-use':
        return const CpfAlreadyInUseFailure();

      // Senha fraca
      case 'weak-password':
        return const WeakPasswordFailure();

      // CPF inválido (Firebase retorna invalid-email)
      case 'invalid-email':
        return const InvalidCpfFailure();

      // Muitas tentativas
      case 'too-many-requests':
        return const TooManyRequestsFailure();

      // Usuário desabilitado
      case 'user-disabled':
        return const UserDisabledFailure();

      // Sem conexão
      case 'network-request-failed':
        return const NetworkRequestFailedFailure();

      default:
        return UnknownAuthFailure(details: 'Firebase Auth Error: ${e.code}');
    }
  }

  static FirestoreFailure _mapFirestoreError(FirebaseException e) {
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

      default:
        return UnknownFirestoreFailure(details: 'Firestore Error: ${e.code}');
    }
  }
}
