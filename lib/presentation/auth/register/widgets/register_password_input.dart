import 'package:desafio_flutter/core/themes/colors.dart';
import 'package:desafio_flutter/core/themes/dimens.dart';
import 'package:desafio_flutter/presentation/auth/register/bloc/register_bloc.dart';
import 'package:desafio_flutter/shared/widgets/custom_input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPasswordInput extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onPasswordChanged;

  const RegisterPasswordInput({
    super.key,
    required this.controller,
    required this.onPasswordChanged,
  });

  @override
  State<RegisterPasswordInput> createState() => _RegisterPasswordInputState();
}

class _RegisterPasswordInputState extends State<RegisterPasswordInput> {
  bool _isPasswordObscured = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormField(
          controller: widget.controller,
          style: const TextStyle(color: AppColors.textPrimary),
          decoration: CustomInputDecoration.build(
            hintText: 'Senha',
            prefixIcon: Icons.lock_outline,
            errorText:
                state.password.isNotValid &&
                    state.password.displayError?.name == 'empty'
                ? 'Senha é obrigatória'
                : null,
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordObscured
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: AppColors.textTertiary,
                size: AppDimens.iconSM,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordObscured = !_isPasswordObscured;
                });
              },
            ),
          ),
          obscureText: _isPasswordObscured,
          onChanged: (password) {
            widget.onPasswordChanged(password);
            context.read<RegisterBloc>().add(RegisterPasswordChanged(password));
          },
        );
      },
    );
  }
}
