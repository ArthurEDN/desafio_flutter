import 'package:desafio_flutter/core/themes/dimens.dart';
import 'package:flutter/material.dart';

class DrawerHeaderWidget extends StatelessWidget {
  const DrawerHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
