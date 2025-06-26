import 'package:desafio_flutter/core/themes/dimens.dart';
import 'package:desafio_flutter/shared/widgets/social_button.dart';
import 'package:flutter/material.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialButton(icon: 'G', onPressed: () {}),
        const SizedBox(width: AppDimens.spacingLG),
        SocialButton(icon: 'f', onPressed: () {}),
        const SizedBox(width: AppDimens.spacingLG),
        SocialButton(icon: '𝕏', onPressed: () {}),
      ],
    );
  }
}
