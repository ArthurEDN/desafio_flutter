import 'package:desafio_flutter/core/themes/colors.dart';
import 'package:desafio_flutter/presentation/auth/login/bloc/login_bloc.dart';
import 'package:desafio_flutter/shared/widgets/custom_input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CpfInput extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String>? onFieldSubmitted;

  const CpfInput({
    super.key,
    required this.controller,
    required this.focusNode,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.cpf != current.cpf,
      builder: (context, state) {
        return TextFormField(
          controller: controller,
          focusNode: focusNode,
          style: const TextStyle(color: AppColors.textPrimary),
          decoration: CustomInputDecoration.build(
            hintText: 'CPF',
            prefixIcon: Icons.person_outline,
            errorText: state.cpf.displayError != null ? 'CPF inválido' : null,
          ),
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(11),
          ],
          onChanged: (value) {
            context.read<LoginBloc>().add(LoginCpfChanged(value));
          },
          onFieldSubmitted: onFieldSubmitted,
        );
      },
    );
  }
}
