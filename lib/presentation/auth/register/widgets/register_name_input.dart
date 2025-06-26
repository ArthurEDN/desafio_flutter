import 'package:desafio_flutter/core/themes/colors.dart';
import 'package:desafio_flutter/presentation/auth/register/bloc/register_bloc.dart';
import 'package:desafio_flutter/shared/widgets/custom_input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterNameInput extends StatelessWidget {
  final TextEditingController controller;

  const RegisterNameInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextFormField(
          controller: controller,
          style: const TextStyle(color: AppColors.textPrimary),
          decoration: CustomInputDecoration.build(
            hintText: 'Nome completo',
            prefixIcon: Icons.person_outline,
            errorText: state.name.displayError != null ? 'Nome inválido' : null,
          ),
          keyboardType: TextInputType.name,
          onChanged: (value) =>
              context.read<RegisterBloc>().add(RegisterNameChanged(value)),
        );
      },
    );
  }
}
