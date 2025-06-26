import 'package:desafio_flutter/core/themes/colors.dart';
import 'package:desafio_flutter/core/themes/dimens.dart';
import 'package:desafio_flutter/presentation/home/widgets/drawer_header_widget.dart';
import 'package:desafio_flutter/presentation/home/widgets/drawer_menu_item.dart';

import 'package:desafio_flutter/presentation/home/widgets/promo_banner.dart';
import 'package:desafio_flutter/shared/widgets/logout_dialog.dart';
import 'package:flutter/material.dart';

class HomeDesktopSideMenu extends StatelessWidget {
  const HomeDesktopSideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimens.drawerWidth,
      color: AppColors.drawerBackground,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DrawerHeaderWidget(),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerMenuItem(
                    icon: Icons.home_outlined,
                    text: 'Home/Seguro',
                    isSelected: true,
                  ),
                  DrawerMenuItem(
                    icon: Icons.article_outlined,
                    text: 'Minhas Contratações',
                  ),
                  DrawerMenuItem(
                    icon: Icons.shield_outlined,
                    text: 'Meus Sinistros',
                  ),
                  DrawerMenuItem(
                    icon: Icons.family_restroom_outlined,
                    text: 'Minha Família',
                  ),
                  DrawerMenuItem(
                    icon: Icons.wallet_outlined,
                    text: 'Meus Bens',
                  ),
                  DrawerMenuItem(
                    icon: Icons.payment_outlined,
                    text: 'Pagamentos',
                  ),
                  DrawerMenuItem(
                    icon: Icons.receipt_long_outlined,
                    text: 'Validar Boleto',
                  ),
                  DrawerMenuItem(
                    icon: Icons.phone_outlined,
                    text: 'Telefones Importantes',
                  ),
                  DrawerMenuItem(
                    icon: Icons.settings_outlined,
                    text: 'Configurações',
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(AppDimens.paddingMD),
              child: ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text(
                  'Sair',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () => LogoutDialog.show(context),
              ),
            ),
            const PromoBanner(),
          ],
        ),
      ),
    );
  }
}
