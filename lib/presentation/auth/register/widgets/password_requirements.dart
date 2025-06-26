import 'package:desafio_flutter/core/themes/dimens.dart';
import 'package:desafio_flutter/presentation/auth/register/widgets/password_requirement_item.dart';
import 'package:flutter/material.dart';

class PasswordRequirements extends StatelessWidget {
  final bool has8Chars;
  final bool hasUppercase;
  final bool hasLowercase;
  final bool hasNumber;
  final bool hasSpecialChar;

  const PasswordRequirements({
    super.key,
    required this.has8Chars,
    required this.hasUppercase,
    required this.hasLowercase,
    required this.hasNumber,
    required this.hasSpecialChar,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingSM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PasswordRequirementItem(
            text: 'Mínimo de 8 caracteres',
            isMet: has8Chars,
          ),
          const SizedBox(height: AppDimens.spacingSM),
          PasswordRequirementItem(
            text: 'Uma letra maiúscula (A-Z)',
            isMet: hasUppercase,
          ),
          const SizedBox(height: AppDimens.spacingSM),
          PasswordRequirementItem(
            text: 'Uma letra minúscula (a-z)',
            isMet: hasLowercase,
          ),
          const SizedBox(height: AppDimens.spacingSM),
          PasswordRequirementItem(text: 'Um número (0-9)', isMet: hasNumber),
          const SizedBox(height: AppDimens.spacingSM),
          PasswordRequirementItem(
            text: 'Um caractere especial (!@#\$&*~)',
            isMet: hasSpecialChar,
          ),
        ],
      ),
    );
  }
}
