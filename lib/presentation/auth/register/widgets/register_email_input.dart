import 'package:desafio_flutter/core/themes/colors.dart';
import 'package:desafio_flutter/presentation/auth/register/bloc/register_bloc.dart';
import 'package:desafio_flutter/shared/widgets/custom_input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterEmailInput extends StatelessWidget {
  final TextEditingController controller;

  const RegisterEmailInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormField(
          controller: controller,
          style: const TextStyle(color: AppColors.textPrimary),
          decoration: CustomInputDecoration.build(
            hintText: 'E-mail',
            prefixIcon: Icons.email_outlined,
            errorText: state.email.displayError != null
                ? 'E-mail inválido'
                : null,
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) =>
              context.read<RegisterBloc>().add(RegisterEmailChanged(value)),
        );
      },
    );
  }
}
