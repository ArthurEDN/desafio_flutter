import 'package:desafio_flutter/core/themes/colors.dart';
import 'package:desafio_flutter/core/themes/dimens.dart';
import 'package:desafio_flutter/presentation/auth/register/widgets/auth_tabs_register.dart';
import 'package:desafio_flutter/presentation/auth/register/widgets/register_form_fields.dart';
import 'package:desafio_flutter/presentation/auth/register/widgets/register_submit_button.dart';
import 'package:flutter/material.dart';

class RegisterFormContent extends StatelessWidget {
  const RegisterFormContent({super.key});

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
              const AuthTabsRegister(),
              const SizedBox(height: AppDimens.spacingXL),
              const RegisterFormFields(),
              const SizedBox(height: AppDimens.fabSize / 2),
            ],
          ),
        ),
        const Positioned(
          bottom: -(AppDimens.fabSize / 2),
          child: RegisterSubmitButton(),
        ),
      ],
    );
  }
}
