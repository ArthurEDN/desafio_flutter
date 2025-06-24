import 'package:formz/formz.dart';

enum PasswordValidationError { empty, tooShort, invalid }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([super.value = '']) : super.dirty();

  static final passwordRegExp = RegExp(
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
  );

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) return PasswordValidationError.empty;
    if (!passwordRegExp.hasMatch(value)) return PasswordValidationError.invalid;
    if (value.length < 6) return PasswordValidationError.tooShort;
    return null;
  }
}

extension PasswordValidationErrorX on PasswordValidationError {
  String get message {
    switch (this) {
      case PasswordValidationError.empty:
        return 'Senha é obrigatória';
      case PasswordValidationError.invalid:
        return 'Senha deve atender todos os requisitos';
      case PasswordValidationError.tooShort:
        return 'Senha deve ter pelo menos 6 caracteres';
    }
  }
}
