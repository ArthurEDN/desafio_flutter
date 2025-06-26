import 'package:desafio_flutter/core/themes/colors.dart';
import 'package:desafio_flutter/core/themes/dimens.dart';
import 'package:desafio_flutter/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthTabsRegister extends StatelessWidget {
  const AuthTabsRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => context.go(Routes.login),
          child: Text(
            'Entrar',
            style: Theme.of(
              context,
            ).textTheme.labelLarge?.copyWith(color: AppColors.textSecondary),
          ),
        ),
        const SizedBox(width: AppDimens.spacingXL),
        Column(
          children: [
            Text(
              'Cadastrar',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppDimens.spacingXS),
            Container(
              height: AppDimens.spacingXS,
              width: AppDimens.paddingXL,
              decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(AppDimens.radiusCircle),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
