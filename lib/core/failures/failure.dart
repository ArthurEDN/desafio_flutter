abstract class Failure {
  const Failure({required this.message, required this.code, this.details});

  final String message;
  final String code;
  final String? details;

  @override
  String toString() => 'Failure(code: $code, message: $message)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure &&
          runtimeType == other.runtimeType &&
          code == other.code;

  @override
  int get hashCode => code.hashCode;
}
