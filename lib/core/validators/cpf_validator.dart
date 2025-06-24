import 'package:formz/formz.dart';

enum CpfValidationError { empty, invalid }

class Cpf extends FormzInput<String, CpfValidationError> {
  const Cpf.pure() : super.pure('');
  const Cpf.dirty([super.value = '']) : super.dirty();

  static bool _isValidCpf(String cpf) {
    if (cpf.isEmpty) return false;
    
    // Remove caracteres não numéricos
    cpf = cpf.replaceAll(RegExp(r'[^0-9]'), '');
    
    // Verifica se tem 11 dígitos
    if (cpf.length != 11) return false;
    
    // Verifica se todos os dígitos são iguais
    if (cpf.split('').every((digit) => digit == cpf[0])) return false;
    
    // Calcula primeiro dígito verificador
    int sum = 0;
    for (int i = 0; i < 9; i++) {
      sum += int.parse(cpf[i]) * (10 - i);
    }
    int remainder = sum % 11;
    int digit1 = remainder < 2 ? 0 : 11 - remainder;
    
    if (digit1 != int.parse(cpf[9])) return false;
    
    // Calcula segundo dígito verificador
    sum = 0;
    for (int i = 0; i < 10; i++) {
      sum += int.parse(cpf[i]) * (11 - i);
    }
    remainder = sum % 11;
    int digit2 = remainder < 2 ? 0 : 11 - remainder;
    
    return digit2 == int.parse(cpf[10]);
  }

  @override
  CpfValidationError? validator(String value) {
    if (value.isEmpty) return CpfValidationError.empty;
    if (!_isValidCpf(value)) return CpfValidationError.invalid;
    return null;
  }
}

extension CpfValidationErrorX on CpfValidationError {
  String get message {
    switch (this) {
      case CpfValidationError.empty:
        return 'CPF é obrigatório';
      case CpfValidationError.invalid:
        return 'CPF inválido';
    }
  }
}