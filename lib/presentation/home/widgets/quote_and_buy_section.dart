import 'package:desafio_flutter/core/themes/colors.dart';
import 'package:desafio_flutter/core/themes/dimens.dart';
import 'package:desafio_flutter/presentation/home/widgets/category_button.dart';
import 'package:flutter/material.dart';

class QuoteAndBuySection extends StatelessWidget {
  const QuoteAndBuySection({super.key});

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
            return CategoryButton(
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
