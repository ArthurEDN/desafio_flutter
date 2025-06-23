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
  const factory Result.error(Exception error) = Error._;
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
  const Error._(this.error);

  /// Erro retornado no resultado.
  final Exception error;

  @override
  String toString() => 'Result<$T>.error($error)';
}