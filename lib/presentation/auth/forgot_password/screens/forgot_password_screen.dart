import 'package:desafio_flutter/core/routing/routes.dart';
import 'package:desafio_flutter/core/themes/dimens.dart';
import 'package:desafio_flutter/presentation/auth/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:desafio_flutter/presentation/auth/forgot_password/widgets/forgot_password_form.dart';
import 'package:desafio_flutter/presentation/auth/forgot_password/widgets/forgot_password_success_view.dart';
import 'package:desafio_flutter/shared/widgets/gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dimens = AppDimens.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => context.go(Routes.login),
        ),
      ),
      body: Stack(
        children: [
          const GradientBackground(),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: dimens.edgeInsetsScreenSymmetric,
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: dimens.dialogMaxWidth,
                    ),
                    child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                      builder: (context, state) {
                        if (state.status == FormzSubmissionStatus.success) {
                          return const ForgotPasswordSuccessView();
                        }
                        return const ForgotPasswordForm();
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
