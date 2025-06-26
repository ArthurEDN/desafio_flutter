import 'package:desafio_flutter/core/themes/dimens.dart';
import 'package:desafio_flutter/presentation/auth/register/bloc/register_bloc.dart';
import 'package:desafio_flutter/presentation/auth/register/widgets/register_form_content.dart';
import 'package:desafio_flutter/presentation/auth/register/widgets/register_header.dart';
import 'package:desafio_flutter/presentation/auth/register/widgets/register_success_view.dart';
import 'package:desafio_flutter/shared/widgets/gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dimens = AppDimens.of(context);

    return Scaffold(
      body: Stack(
        children: [
          GradientBackground(),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: dimens.edgeInsetsScreenSymmetric,
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: dimens.dialogMaxWidth,
                    ),
                    child: BlocBuilder<RegisterBloc, RegisterState>(
                      builder: (context, state) {
                        if (state.status == FormzSubmissionStatus.success) {
                          return const RegisterSuccessView();
                        }
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const RegisterHeader(),
                            const SizedBox(height: AppDimens.spacingLG),
                            const RegisterFormContent(),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
