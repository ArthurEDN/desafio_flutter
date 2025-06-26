import 'package:desafio_flutter/core/themes/colors.dart';
import 'package:desafio_flutter/presentation/auth/register/bloc/register_bloc.dart';
import 'package:desafio_flutter/shared/widgets/custom_input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCpfInput extends StatelessWidget {
  final TextEditingController controller;

  const RegisterCpfInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.cpf != current.cpf,
      builder: (context, state) {
        return TextFormField(
          controller: controller,
          style: const TextStyle(color: AppColors.textPrimary),
          decoration: CustomInputDecoration.build(
            hintText: 'CPF',
            prefixIcon: Icons.badge_outlined,
            errorText: state.cpf.displayError != null ? 'CPF inválido' : null,
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(11),
          ],
          onChanged: (value) =>
              context.read<RegisterBloc>().add(RegisterCpfChanged(value)),
        );
      },
    );
  }
}
