import 'package:desafio_flutter/core/themes/colors.dart';
import 'package:desafio_flutter/presentation/auth/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:desafio_flutter/shared/widgets/custom_input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordEmailInput extends StatelessWidget {
  const ForgotPasswordEmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormField(
          style: const TextStyle(color: AppColors.textPrimary),
          decoration: CustomInputDecoration.build(
            hintText: 'E-mail de registo',
            prefixIcon: Icons.email_outlined,
            errorText: state.email.displayError != null
                ? 'E-mail inválido'
                : null,
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) => context.read<ForgotPasswordBloc>().add(
            ForgotPasswordEmailChanged(value),
          ),
        );
      },
    );
  }
}
