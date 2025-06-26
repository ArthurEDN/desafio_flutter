import 'package:desafio_flutter/core/themes/colors.dart';
import 'package:desafio_flutter/core/themes/dimens.dart';
import 'package:desafio_flutter/presentation/auth/bloc/auth_bloc.dart';
import 'package:desafio_flutter/presentation/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.unauthenticated) {
          context.go('/login');
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (authContext, authState) {
          if (authState.status == AuthStatus.authenticated &&
              authContext.read<HomeBloc>().state is HomeInitial) {
            authContext.read<HomeBloc>().add(
              HomeDataRequested(authState.user!.uid),
            );
          }

          final bool isDesktop = AppDimens.isDesktop(context);

          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: isDesktop ? null : _buildMobileAppBar(context),
            drawer: isDesktop ? null : _buildResponsiveDrawer(context),
            body: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isDesktop) _buildDesktopSideMenu(context),
                Expanded(child: _buildMainContent()),
              ],
            ),
          );
        },
      ),
    );
  }


  Widget _buildResponsiveDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.drawerBackground,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header do drawer
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppDimens.paddingLG),
              child: Image.network(
                'https://raw.githubusercontent.com/felipecastrosales/desafio_flutter/main/assets/images/logo.png',
                height: 40,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 40,
                  alignment: Alignment.center,
                  child: const Text(
                    'Logo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const Divider(color: Colors.white24, height: 1),
            // Menu items
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _ResponsiveMenuItem(
                    icon: Icons.home_outlined,
                    text: 'Home/Seguro',
                    isSelected: true,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  _ResponsiveMenuItem(
                    icon: Icons.article_outlined,
                    text: 'Minhas Contratações',
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  _ResponsiveMenuItem(
                    icon: Icons.shield_outlined,
                    text: 'Meus Sinistros',
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  _ResponsiveMenuItem(
                    icon: Icons.family_restroom_outlined,
                    text: 'Minha Família',
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  _ResponsiveMenuItem(
                    icon: Icons.wallet_outlined,
                    text: 'Meus Bens',
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  _ResponsiveMenuItem(
                    icon: Icons.payment_outlined,
                    text: 'Pagamentos',
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  _ResponsiveMenuItem(
                    icon: Icons.receipt_long_outlined,
                    text: 'Validar Boleto',
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  _ResponsiveMenuItem(
                    icon: Icons.phone_outlined,
                    text: 'Telefones Importantes',
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  _ResponsiveMenuItem(
                    icon: Icons.settings_outlined,
                    text: 'Configurações',
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            // Logout button
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
                  _showLogoutDialog(context);
                },
              ),
            ),
            // Promo banner
            _PromoBanner(),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopSideMenu(BuildContext context) {
    return Container(
      width: AppDimens.drawerWidth,
      color: AppColors.drawerBackground,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppDimens.paddingLG),
              child: Image.network(
                'https://raw.githubusercontent.com/felipecastrosales/desafio_flutter/main/assets/images/logo.png',
                height: 40,
                errorBuilder: (context, error, stackTrace) =>
                    const Text('Logo', style: TextStyle(color: Colors.white)),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _ResponsiveMenuItem(
                    icon: Icons.home_outlined,
                    text: 'Home/Seguro',
                    isSelected: true,
                  ),
                  _ResponsiveMenuItem(
                    icon: Icons.article_outlined,
                    text: 'Minhas Contratações',
                  ),
                  _ResponsiveMenuItem(
                    icon: Icons.shield_outlined,
                    text: 'Meus Sinistros',
                  ),
                  _ResponsiveMenuItem(
                    icon: Icons.family_restroom_outlined,
                    text: 'Minha Família',
                  ),
                  _ResponsiveMenuItem(
                    icon: Icons.wallet_outlined,
                    text: 'Meus Bens',
                  ),
                  _ResponsiveMenuItem(
                    icon: Icons.payment_outlined,
                    text: 'Pagamentos',
                  ),
                  _ResponsiveMenuItem(
                    icon: Icons.receipt_long_outlined,
                    text: 'Validar Boleto',
                  ),
                  _ResponsiveMenuItem(
                    icon: Icons.phone_outlined,
                    text: 'Telefones Importantes',
                  ),
                  _ResponsiveMenuItem(
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
                onTap: () => _showLogoutDialog(context),
              ),
            ),
            _PromoBanner(),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        title: const Text(
          'Confirmar saída',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        content: const Text(
          'Deseja realmente sair da sua conta?',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<AuthBloc>().add(AuthSignOutRequested());
            },
            child: const Text('Sair', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  AppBar _buildMobileAppBar(BuildContext context) {
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
              _showLogoutDialog(context);
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

  Widget _buildMainContent() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoadInProgress || state is HomeInitial) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is HomeLoadFailure) {
          return Center(
            child: Text(
              state.error,
              style: const TextStyle(color: Colors.white),
            ),
          );
        }
        if (state is HomeLoadSuccess) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppDimens.paddingLG),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Header(userName: state.user.name),
                const SizedBox(height: AppDimens.spacingXL),
                _QuoteAndBuySection(),
                const SizedBox(height: AppDimens.spacingXL),
                _InfoCard(
                  title: 'Minha Família',
                  icon: Icons.add_circle_outline,
                  description:
                      'Adicione aqui membros da sua família e compartilhe os seguros com eles.',
                ),
                const SizedBox(height: AppDimens.spacingLG),
                _InfoCard(
                  title: 'Contratados',
                  icon: Icons.sentiment_dissatisfied_outlined,
                  description: 'Você ainda não possui seguros contratados.',
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _ResponsiveMenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isSelected;
  final VoidCallback? onTap;

  const _ResponsiveMenuItem({
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

class _Header extends StatelessWidget {
  final String userName;
  const _Header({required this.userName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppDimens.paddingLG),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: AppColors.accent.withOpacity(0.5),
            backgroundImage: NetworkImage(
              'https://placehold.co/150x150/A5D6A7/1B5E20?text=${userName.isNotEmpty ? userName[0].toUpperCase() : 'U'}',
            ),
            onBackgroundImageError: (_, __) {},
          ),
          const SizedBox(width: AppDimens.spacingMD),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bem-vindo',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  userName,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PromoBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppDimens.paddingMD),
      padding: const EdgeInsets.all(AppDimens.paddingMD),
      decoration: BoxDecoration(
        gradient: AppColors.headerGradient,
        borderRadius: BorderRadius.circular(AppDimens.radiusLG),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.accent.withOpacity(0.5),
            backgroundImage: const NetworkImage(
              'https://placehold.co/150x150/80CBC4/004D40?text=A',
            ),
            onBackgroundImageError: (_, __) {},
            child: const Text(''),
          ),
          const SizedBox(width: AppDimens.spacingMD),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Dúvidas?',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.textPrimary,
                    fontSize: 12,
                  ),
                ),
                Text(
                  'Converse agora mesmo',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textPrimary.withOpacity(0.8),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuoteAndBuySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool isMobile = AppDimens.isMobile(context);

    final List<Map<String, dynamic>> allCategories = [
      {
        'label': 'Automóvel',
        'icon': Icons.directions_car_filled_outlined,
        'color': const Color(0xFF43A047),
      },
      {
        'label': 'Residência',
        'icon': Icons.home_work_outlined,
        'color': const Color(0xFFE53935),
      },
      {
        'label': 'Vida',
        'icon': Icons.favorite_border,
        'color': const Color(0xFF1E88E5),
      },
      {
        'label': 'Acidentes Pessoais',
        'icon': Icons.personal_injury_outlined,
        'color': const Color(0xFF8E44AD),
      },
    ];

    final categories = isMobile
        ? allCategories.take(4).toList()
        : allCategories;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cotar e Contratar',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppDimens.spacingMD),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isMobile ? 2 : 4,
            crossAxisSpacing: AppDimens.spacingSM,
            mainAxisSpacing: AppDimens.spacingSM,
            childAspectRatio: isMobile ? 1.2 : 0.85,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return _CategoryButton(
              icon: category['icon'],
              label: category['label'],
              color: category['color'],
            );
          },
        ),
      ],
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback? onTap;

  const _CategoryButton({
    required this.icon,
    required this.label,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.cardBackground,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.radiusMD),
      ),
      child: InkWell(
        onTap: onTap ?? () {},
        borderRadius: BorderRadius.circular(AppDimens.radiusMD),
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.paddingSM),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(AppDimens.paddingSM),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: AppDimens.iconLG),
              ),
              const SizedBox(height: AppDimens.spacingSM),
              Flexible(
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String description;

  const _InfoCard({
    required this.title,
    required this.icon,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: AppColors.cardBackground,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.radiusMD),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.paddingLG),
          child: Column(
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppDimens.spacingMD),
              Icon(
                icon,
                color: AppColors.textSecondary,
                size: AppDimens.iconXL,
              ),
              const SizedBox(height: AppDimens.spacingSM),
              Text(
                description,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
