import 'package:desafio_flutter/core/themes/colors.dart';
import 'package:desafio_flutter/core/themes/dimens.dart';
import 'package:desafio_flutter/presentation/home/widgets/drawer_header_widget.dart';
import 'package:desafio_flutter/presentation/home/widgets/drawer_menu_item.dart';
import 'package:desafio_flutter/presentation/home/widgets/promo_banner.dart';
import 'package:desafio_flutter/shared/widgets/logout_dialog.dart';
import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.drawerBackground,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DrawerHeaderWidget(),
            const Divider(color: Colors.white24, height: 1),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerMenuItem(
                    icon: Icons.home_outlined,
                    text: 'Home/Seguro',
                    isSelected: true,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  DrawerMenuItem(
                    icon: Icons.article_outlined,
                    text: 'Minhas Contratações',
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  DrawerMenuItem(
                    icon: Icons.shield_outlined,
                    text: 'Meus Sinistros',
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  DrawerMenuItem(
                    icon: Icons.family_restroom_outlined,
                    text: 'Minha Família',
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  DrawerMenuItem(
                    icon: Icons.wallet_outlined,
                    text: 'Meus Bens',
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  DrawerMenuItem(
                    icon: Icons.payment_outlined,
                    text: 'Pagamentos',
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  DrawerMenuItem(
                    icon: Icons.receipt_long_outlined,
                    text: 'Validar Boleto',
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  DrawerMenuItem(
                    icon: Icons.phone_outlined,
                    text: 'Telefones Importantes',
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  DrawerMenuItem(
                    icon: Icons.settings_outlined,
                    text: 'Configurações',
                    onTap: () => Navigator.of(context).pop(),
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
                onTap: () {
                  Navigator.of(context).pop();
                  LogoutDialog.show(context);
                },
              ),
            ),
            const PromoBanner(),
          ],
        ),
      ),
    );
  }
}
