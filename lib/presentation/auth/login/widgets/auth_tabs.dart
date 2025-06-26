import 'package:desafio_flutter/core/routing/routes.dart';
import 'package:desafio_flutter/core/themes/colors.dart';
import 'package:desafio_flutter/core/themes/dimens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthTabs extends StatelessWidget {
  const AuthTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(
              'Entrar',
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
        const SizedBox(width: AppDimens.spacingXL),
        GestureDetector(
          onTap: () => context.go(Routes.register),
          child: Text(
            'Cadastrar',
            style: Theme.of(
              context,
            ).textTheme.labelLarge?.copyWith(color: AppColors.textSecondary),
          ),
        ),
      ],
    );
  }
}
