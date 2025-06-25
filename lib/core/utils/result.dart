import 'package:desafio_flutter/core/failures/failure.dart';

/// Classe utilitária para encapsular o resultado de uma operação,
/// que pode ser um sucesso (Ok) ou um erro (Error).
///
/// Avalie o resultado usando um switch statement:
/// ```dart
/// switch (result) {
///   case Ok():
///     print(result.value);
///   case Error():
///     print(result.error);
/// }
/// ```
sealed class Result<T> {
  const Result();

  /// Cria um de sucesso, completo com o [value] especificado.
  const factory Result.ok(T value) = Ok._;

  /// Cria um de erro, completo com o [error] especificado.
  const factory Result.failure(Failure failure) = Error._;
}

/// Subclasse de Result para valores de sucesso.
final class Ok<T> extends Result<T> {
  const Ok._(this.value);

  /// Valor retornado no resultado.
  final T value;

  @override
  String toString() => 'Result<$T>.ok($value)';
}

/// Subclasse de Result para erros.
final class Error<T> extends Result<T> {
  const Error._(this.failure);

  /// Erro retornado no resultado.
  final Failure failure;

  @override
  String toString() => 'Result<$T>.error($failure)';
}

extension ResultExtensions<T> on Result<T> {
  /// Extrai o valor ou lança a Failure
  T get value {
    if (this is Error<T>) {
      throw (this as Error<T>).failure;
    }
    return (this as Ok<T>).value;
  }

  /// Extrai o valor ou retorna null
  T? get valueOrNull {
    if (this is Error<T>) return null;
    return (this as Ok<T>).value;
  }

  /// Extrai a failure ou retorna null
  Failure? get failureOrNull {
    if (this is Ok<T>) return null;
    return (this as Error<T>).failure;
  }

  /// Verifica se é sucesso
  bool get isSuccess => this is Ok<T>;

  /// Verifica se é erro
  bool get isFailure => this is Error<T>;
}
