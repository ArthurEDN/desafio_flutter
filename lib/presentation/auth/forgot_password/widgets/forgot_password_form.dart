import 'package:desafio_flutter/core/themes/colors.dart';
import 'package:desafio_flutter/core/themes/dimens.dart';
import 'package:desafio_flutter/presentation/auth/forgot_password/widgets/forgot_password_header.dart';
import 'package:desafio_flutter/presentation/auth/forgot_password/widgets/forgot_password_email_input.dart';
import 'package:desafio_flutter/presentation/auth/forgot_password/widgets/forgot_password_submit_button.dart';
import 'package:flutter/material.dart';

class ForgotPasswordForm extends StatelessWidget {
  const ForgotPasswordForm({super.key});

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
              const ForgotPasswordHeader(),
              const SizedBox(height: AppDimens.spacingXL),
              const ForgotPasswordEmailInput(),
              const SizedBox(
                height: AppDimens.fabSize / 2 + AppDimens.spacingMD,
              ),
            ],
          ),
        ),
        const Positioned(
          bottom: -(AppDimens.fabSize / 2),
          child: ForgotPasswordSubmitButton(),
        ),
      ],
    );
  }
}
