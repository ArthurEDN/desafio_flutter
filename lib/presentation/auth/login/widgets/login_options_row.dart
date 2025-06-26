import 'package:desafio_flutter/core/routing/routes.dart';
import 'package:desafio_flutter/core/themes/colors.dart';
import 'package:desafio_flutter/core/themes/dimens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginOptionsRow extends StatelessWidget {
  final bool rememberMe;
  final ValueChanged<bool> onRememberMeChanged;

  const LoginOptionsRow({
    super.key,
    required this.rememberMe,
    required this.onRememberMeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = AppDimens.isMobile(context);

    return Row(
      children: [
        SizedBox(
          width: AppDimens.iconMD,
          height: AppDimens.iconMD,
          child: Checkbox(
            value: rememberMe,
            onChanged: (value) => onRememberMeChanged(value ?? false),
            shape: const CircleBorder(),
            activeColor: AppColors.accent,
          ),
        ),
        SizedBox(width: isMobile ? AppDimens.spacingXS : AppDimens.spacingSM),
        Flexible(
          flex: isMobile ? 2 : 3,
          child: Text(
            'Lembrar Sempre',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
              fontSize: isMobile ? 12 : null,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        SizedBox(width: isMobile ? AppDimens.spacingXS : AppDimens.spacingSM),
        Flexible(
          flex: isMobile ? 2 : 2,
          child: TextButton(
            onPressed: () => context.go(Routes.forgotPassword),
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile
                    ? AppDimens.paddingXS
                    : AppDimens.paddingSM,
              ),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'Esqueceu a senha?',
              style: TextStyle(
                color: AppColors.accent,
                fontWeight: FontWeight.bold,
                fontSize: isMobile ? 12 : 16,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.right,
            ),
          ),
        ),
      ],
    );
  }
}
