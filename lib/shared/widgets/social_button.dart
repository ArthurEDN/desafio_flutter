import 'package:desafio_flutter/core/themes/colors.dart';
import 'package:desafio_flutter/core/themes/dimens.dart';
import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String icon;
  final VoidCallback onPressed;

  const SocialButton({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(AppDimens.socialButtonSize / 2),
      child: Container(
        width: AppDimens.socialButtonSize,
        height: AppDimens.socialButtonSize,
        decoration: const BoxDecoration(
          color: AppColors.socialButtonBackground,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            icon,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.socialButtonText,
            ),
          ),
        ),
      ),
    );
  }
}
