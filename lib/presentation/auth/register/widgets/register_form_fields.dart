import 'package:desafio_flutter/core/themes/dimens.dart';
import 'package:desafio_flutter/presentation/auth/register/widgets/register_name_input.dart';
import 'package:desafio_flutter/presentation/auth/register/widgets/register_email_input.dart';
import 'package:desafio_flutter/presentation/auth/register/widgets/register_cpf_input.dart';
import 'package:desafio_flutter/presentation/auth/register/widgets/register_password_input.dart';
import 'package:desafio_flutter/presentation/auth/register/widgets/password_requirements.dart';
import 'package:flutter/material.dart';

class RegisterFormFields extends StatefulWidget {
  const RegisterFormFields({super.key});

  @override
  State<RegisterFormFields> createState() => _RegisterFormFieldsState();
}

class _RegisterFormFieldsState extends State<RegisterFormFields> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _has8Chars = false;
  bool _hasUppercase = false;
  bool _hasLowercase = false;
  bool _hasNumber = false;
  bool _hasSpecialChar = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _cpfController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validatePassword(String password) {
    setState(() {
      _has8Chars = password.length >= 8;
      _hasUppercase = password.contains(RegExp(r'[A-Z]'));
      _hasLowercase = password.contains(RegExp(r'[a-z]'));
      _hasNumber = password.contains(RegExp(r'[0-9]'));
      _hasSpecialChar = password.contains(RegExp(r'[!@#\$&*~]'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RegisterNameInput(controller: _nameController),
        const SizedBox(height: AppDimens.spacingMD),
        RegisterEmailInput(controller: _emailController),
        const SizedBox(height: AppDimens.spacingMD),
        RegisterCpfInput(controller: _cpfController),
        const SizedBox(height: AppDimens.spacingMD),
        RegisterPasswordInput(
          controller: _passwordController,
          onPasswordChanged: _validatePassword,
        ),
        const SizedBox(height: AppDimens.spacingMD),
        PasswordRequirements(
          has8Chars: _has8Chars,
          hasUppercase: _hasUppercase,
          hasLowercase: _hasLowercase,
          hasNumber: _hasNumber,
          hasSpecialChar: _hasSpecialChar,
        ),
      ],
    );
  }
}
