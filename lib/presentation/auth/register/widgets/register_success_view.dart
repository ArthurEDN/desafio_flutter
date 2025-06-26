import 'package:desafio_flutter/core/themes/colors.dart';
import 'package:desafio_flutter/core/themes/dimens.dart';
import 'package:desafio_flutter/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterSuccessView extends StatelessWidget {
  const RegisterSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingXL),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppDimens.radiusXL),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.check_circle_outline_rounded,
            color: AppColors.accent,
            size: 64,
          ),
          const SizedBox(height: AppDimens.spacingLG),
          Text(
            'Registo Realizado!',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimens.spacingMD),
          Text(
            'A sua conta foi criada com sucesso. Por favor, faça o login para continuar.',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimens.spacingXL),
          ElevatedButton(
            onPressed: () => context.go(Routes.login),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.paddingXL,
                vertical: AppDimens.paddingMD,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimens.radiusMD),
              ),
            ),
            child: const Text('Ir para o Login'),
          ),
        ],
      ),
    );
  }
}
