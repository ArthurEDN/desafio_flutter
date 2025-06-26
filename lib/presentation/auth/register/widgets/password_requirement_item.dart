import 'package:desafio_flutter/core/themes/colors.dart';
import 'package:desafio_flutter/core/themes/dimens.dart';
import 'package:flutter/material.dart';

class PasswordRequirementItem extends StatelessWidget {
  final String text;
  final bool isMet;

  const PasswordRequirementItem({
    super.key,
    required this.text,
    required this.isMet,
  });

  @override
  Widget build(BuildContext context) {
    final color = isMet ? AppColors.success : AppColors.textTertiary;
    return Row(
      children: [
        Icon(
          isMet ? Icons.check_circle : Icons.remove_circle_outline,
          color: color,
          size: AppDimens.iconSM,
        ),
        const SizedBox(width: AppDimens.spacingSM),
        Text(
          text,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: color),
        ),
      ],
    );
  }
}
