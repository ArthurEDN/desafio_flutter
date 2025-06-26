import 'package:desafio_flutter/core/themes/dimens.dart';
import 'package:desafio_flutter/presentation/home/bloc/home_bloc.dart';
import 'package:desafio_flutter/presentation/home/widgets/home_header.dart';
import 'package:desafio_flutter/presentation/home/widgets/quote_and_buy_section.dart';
import 'package:desafio_flutter/presentation/home/widgets/info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeMainContent extends StatelessWidget {
  const HomeMainContent({super.key});

  @override
  Widget build(BuildContext context) {
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
                HomeHeader(userName: state.user.name),
                const SizedBox(height: AppDimens.spacingXL),
                const QuoteAndBuySection(),
                const SizedBox(height: AppDimens.spacingXL),
                const InfoCard(
                  title: 'Minha Família',
                  icon: Icons.add_circle_outline,
                  description:
                      'Adicione aqui membros da sua família e compartilhe os seguros com eles.',
                ),
                const SizedBox(height: AppDimens.spacingLG),
                const InfoCard(
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
