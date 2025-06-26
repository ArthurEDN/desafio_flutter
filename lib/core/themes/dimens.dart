import 'package:flutter/material.dart';

abstract final class AppDimens {
  const AppDimens();

  static const paddingXS = 4.0;
  static const paddingSM = 8.0;
  static const paddingMD = 16.0;
  static const paddingLG = 24.0;
  static const paddingXL = 32.0;
  static const paddingXXL = 48.0;

  static const spacingXS = 4.0;
  static const spacingSM = 8.0;
  static const spacingMD = 16.0;
  static const spacingLG = 24.0;
  static const spacingXL = 32.0;
  static const spacingXXL = 48.0;

  static const radiusXS = 4.0;
  static const radiusSM = 8.0;
  static const radiusMD = 12.0;
  static const radiusLG = 16.0;
  static const radiusXL = 24.0;
  static const radiusXXL = 32.0;
  static const radiusCircle = 999.0;

  static const elevationXS = 1.0;
  static const elevationSM = 2.0;
  static const elevationMD = 4.0;
  static const elevationLG = 8.0;
  static const elevationXL = 12.0;
  static const elevationXXL = 16.0;

  static const iconXS = 16.0;
  static const iconSM = 20.0;
  static const iconMD = 24.0;
  static const iconLG = 32.0;
  static const iconXL = 48.0;
  static const iconXXL = 64.0;

  static const buttonHeightSM = 36.0;
  static const buttonHeightMD = 44.0;
  static const buttonHeightLG = 52.0;
  static const buttonHeightXL = 60.0;

  static const loginButtonHeight = 52.0; // Botão "Entrar"
  static const inputHeight = 56.0; // Campos CPF e Senha
  static const socialButtonSize = 48.0; // Botões G, F, Twitter
  static const profileAvatarSize = 64.0; // Avatar do usuário (Caio Máximo)
  static const cardIconSize = 40.0; // Ícones dos cards de função
  static const menuItemHeight = 48.0; // Itens do drawer/menu lateral

  // Layout principais
  static const cardHeight = 120.0; // Cards da tela principal
  static const bottomNavHeight = 70.0; // Navegação inferior
  static const appBarHeight = 56.0; // Barra superior
  static const drawerWidth = 280.0; // Largura do menu lateral
  static const fabSize = 56.0; // Floating Action Button

  // Elementos de lista e navegação
  static const listTileHeight = 56.0; // Altura padrão de ListTile
  static const tabHeight = 48.0; // Altura das tabs
  static const chipHeight = 32.0; // Altura dos chips

  static const textFieldBorderWidth = 1.0;
  static const textFieldFocusedBorderWidth = 2.0;

  double get paddingScreenHorizontal;
  double get paddingScreenVertical;
  double get maxContentWidth;
  double get profilePictureSize;
  double get logoSize;
  double get cardGridSpacing;
  double get sectionSpacing;
  double get dialogMaxWidth;
  double get bottomSheetMaxWidth;

  EdgeInsets get edgeInsetsScreenHorizontal =>
      EdgeInsets.symmetric(horizontal: paddingScreenHorizontal);

  EdgeInsets get edgeInsetsScreenVertical =>
      EdgeInsets.symmetric(vertical: paddingScreenVertical);

  EdgeInsets get edgeInsetsScreenSymmetric => EdgeInsets.symmetric(
    horizontal: paddingScreenHorizontal,
    vertical: paddingScreenVertical,
  );

  EdgeInsets get edgeInsetsScreenAll => EdgeInsets.all(paddingScreenHorizontal);

  static const edgeInsetsXS = EdgeInsets.all(paddingXS);
  static const edgeInsetsSM = EdgeInsets.all(paddingSM);
  static const edgeInsetsMD = EdgeInsets.all(paddingMD);
  static const edgeInsetsLG = EdgeInsets.all(paddingLG);
  static const edgeInsetsXL = EdgeInsets.all(paddingXL);

  static const edgeInsetsHorizontalMD = EdgeInsets.symmetric(
    horizontal: paddingMD,
  );
  static const edgeInsetsVerticalMD = EdgeInsets.symmetric(vertical: paddingMD);
  static const edgeInsetsHorizontalLG = EdgeInsets.symmetric(
    horizontal: paddingLG,
  );
  static const edgeInsetsVerticalLG = EdgeInsets.symmetric(vertical: paddingLG);

  static const AppDimens mobile = _DimensMobile();
  static const AppDimens tablet = _DimensTablet();
  static const AppDimens desktop = _DimensDesktop();

  factory AppDimens.of(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    if (width >= 1200) {
      return desktop;
    } else if (width >= 768) {
      return tablet;
    } else {
      return mobile;
    }
  }

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 768;

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= 768 && width < 1200;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 1200;

  static const borderRadiusXS = Radius.circular(radiusXS);
  static const borderRadiusSM = Radius.circular(radiusSM);
  static const borderRadiusMD = Radius.circular(radiusMD);
  static const borderRadiusLG = Radius.circular(radiusLG);
  static const borderRadiusXL = Radius.circular(radiusXL);

  static const borderRadiusCircular = Radius.circular(radiusCircle);

  static const borderRadiusAllXS = BorderRadius.all(borderRadiusXS);
  static const borderRadiusAllSM = BorderRadius.all(borderRadiusSM);
  static const borderRadiusAllMD = BorderRadius.all(borderRadiusMD);
  static const borderRadiusAllLG = BorderRadius.all(borderRadiusLG);
  static const borderRadiusAllXL = BorderRadius.all(borderRadiusXL);
}

final class _DimensMobile extends AppDimens {
  @override
  final double paddingScreenHorizontal = AppDimens.paddingLG;

  @override
  final double paddingScreenVertical = AppDimens.paddingLG;

  @override
  final double maxContentWidth = double.infinity;

  @override
  final double profilePictureSize = 40.0;

  @override
  final double logoSize = 120.0;

  @override
  final double cardGridSpacing = AppDimens.paddingMD;

  @override
  final double sectionSpacing = AppDimens.paddingXL;

  @override
  final double dialogMaxWidth = 320.0;

  @override
  final double bottomSheetMaxWidth = double.infinity;

  const _DimensMobile();
}

final class _DimensTablet extends AppDimens {
  @override
  final double paddingScreenHorizontal = AppDimens.paddingXL;

  @override
  final double paddingScreenVertical = AppDimens.paddingXL;

  @override
  final double maxContentWidth = 720.0;

  @override
  final double profilePictureSize = 48.0;

  @override
  final double logoSize = 140.0;

  @override
  final double cardGridSpacing = AppDimens.paddingLG;

  @override
  final double sectionSpacing = AppDimens.paddingXXL;

  @override
  final double dialogMaxWidth = 480.0;

  @override
  final double bottomSheetMaxWidth = 600.0;

  const _DimensTablet();
}

final class _DimensDesktop extends AppDimens {
  @override
  final double paddingScreenHorizontal = 80.0;

  @override
  final double paddingScreenVertical = 60.0;

  @override
  final double maxContentWidth = 1200.0;

  @override
  final double profilePictureSize = 56.0;

  @override
  final double logoSize = 160.0;

  @override
  final double cardGridSpacing = AppDimens.paddingXL;

  @override
  final double sectionSpacing = 64.0;

  @override
  final double dialogMaxWidth = 600.0;

  @override
  final double bottomSheetMaxWidth = 800.0;

  const _DimensDesktop();
}
