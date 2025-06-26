import 'package:desafio_flutter/core/themes/colors.dart';
import 'package:desafio_flutter/core/themes/dimens.dart';
import 'package:desafio_flutter/presentation/auth/bloc/auth_bloc.dart';
import 'package:desafio_flutter/presentation/home/bloc/home_bloc.dart';
import 'package:desafio_flutter/presentation/home/widgets/home_app_bar.dart';
import 'package:desafio_flutter/presentation/home/widgets/home_drawer.dart';
import 'package:desafio_flutter/presentation/home/widgets/home_main_content.dart';
import 'package:desafio_flutter/presentation/home/widgets/home_side_menu.dart';
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
            appBar: isDesktop ? null : const HomeMobileAppBar(),
            drawer: isDesktop ? null : const HomeDrawer(),
            body: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isDesktop) const HomeDesktopSideMenu(),
                const Expanded(child: HomeMainContent()),
              ],
            ),
          );
        },
      ),
    );
  }
}
