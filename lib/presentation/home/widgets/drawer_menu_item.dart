import 'package:desafio_flutter/core/themes/colors.dart';
import 'package:desafio_flutter/core/themes/dimens.dart';
import 'package:flutter/material.dart';

class DrawerMenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isSelected;
  final VoidCallback? onTap;

  const DrawerMenuItem({
    super.key,
    required this.icon,
    required this.text,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimens.paddingMD,
        vertical: AppDimens.paddingXS,
      ),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.menuItemHover : Colors.transparent,
        borderRadius: BorderRadius.circular(AppDimens.radiusSM),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimens.paddingMD,
          vertical: AppDimens.paddingXS,
        ),
        leading: Icon(
          icon,
          color: isSelected ? AppColors.accent : AppColors.iconSecondary,
          size: 20,
        ),
        title: Text(
          text,
          style: TextStyle(
            color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 14,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        onTap: onTap ?? () {},
        visualDensity: VisualDensity.compact,
      ),
    );
  }
}
