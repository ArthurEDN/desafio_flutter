import 'package:desafio_flutter/core/themes/colors.dart';
import 'package:desafio_flutter/core/themes/dimens.dart';
import 'package:desafio_flutter/presentation/auth/login/bloc/login_bloc.dart';
import 'package:desafio_flutter/presentation/auth/login/widgets/auth_tabs.dart';
import 'package:desafio_flutter/presentation/auth/login/widgets/cpf_input.dart';
import 'package:desafio_flutter/presentation/auth/login/widgets/login_options_row.dart';
import 'package:desafio_flutter/presentation/auth/login/widgets/login_submit_button.dart';
import 'package:desafio_flutter/presentation/auth/login/widgets/password_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _cpfController = TextEditingController();
  final _passwordController = TextEditingController();
  final _cpfFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  bool _rememberMe = false;

  @override
  void dispose() {
    _cpfController.dispose();
    _passwordController.dispose();
    _cpfFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(AppDimens.paddingLG),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(AppDimens.radiusXL),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const AuthTabs(),
              const SizedBox(height: AppDimens.spacingXL),
              CpfInput(
                controller: _cpfController,
                focusNode: _cpfFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_passwordFocusNode);
                },
              ),
              const SizedBox(height: AppDimens.spacingMD),
              PasswordInput(
                controller: _passwordController,
                focusNode: _passwordFocusNode,
                onFieldSubmitted: (_) {
                  context.read<LoginBloc>().add(LoginSubmitted());
                },
              ),
              const SizedBox(height: AppDimens.spacingMD),
              LoginOptionsRow(
                rememberMe: _rememberMe,
                onRememberMeChanged: (value) {
                  setState(() {
                    _rememberMe = value;
                  });
                },
              ),
              const SizedBox(height: AppDimens.fabSize / 2),
            ],
          ),
        ),
        const Positioned(
          bottom: -(AppDimens.fabSize / 2),
          child: LoginSubmitButton(),
        ),
      ],
    );
  }
}
