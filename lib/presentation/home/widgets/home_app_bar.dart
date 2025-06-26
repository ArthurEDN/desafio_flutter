import 'package:desafio_flutter/core/themes/colors.dart';
import 'package:desafio_flutter/shared/widgets/logout_dialog.dart';
import 'package:flutter/material.dart';

class HomeMobileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeMobileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(color: AppColors.textPrimary),
      title: Image.network(
        'https://raw.githubusercontent.com/felipecastrosales/desafio_flutter/main/assets/images/logo.png',
        height: 30,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => Container(
          height: 30,
          alignment: Alignment.center,
          child: const Text(
            'Logo',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.notifications_none_outlined,
            color: AppColors.textPrimary,
          ),
          onPressed: () {},
        ),
        PopupMenuButton<String>(
          icon: const Icon(
            Icons.account_circle_outlined,
            color: AppColors.textPrimary,
          ),
          onSelected: (value) {
            if (value == 'logout') {
              LogoutDialog.show(context);
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'logout',
              child: Row(
                children: [
                  Icon(Icons.logout, color: AppColors.textSecondary),
                  SizedBox(width: 8),
                  Text('Sair'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
