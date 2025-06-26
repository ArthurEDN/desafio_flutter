import 'package:desafio_flutter/core/routing/routes.dart';
import 'package:desafio_flutter/core/themes/colors.dart';
import 'package:desafio_flutter/core/themes/dimens.dart';
import 'package:desafio_flutter/presentation/auth/login/bloc/login_bloc.dart';
import 'package:desafio_flutter/presentation/auth/login/widgets/login_background.dart';
import 'package:desafio_flutter/presentation/auth/login/widgets/login_footer.dart';
import 'package:desafio_flutter/presentation/auth/login/widgets/login_form.dart';
import 'package:desafio_flutter/presentation/auth/login/widgets/login_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dimens = AppDimens.of(context);

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == FormzSubmissionStatus.success) {
          context.go(Routes.home);
        } else if (state.status == FormzSubmissionStatus.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  state.errorMessage ?? 'Credenciais inválidas',
                  textAlign: TextAlign.center,
                ),
                backgroundColor: AppColors.error,
                behavior: SnackBarBehavior.fixed,
                duration: const Duration(seconds: 3),
              ),
            );
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            const Positioned.fill(child: LoginBackground()),
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: dimens.edgeInsetsScreenSymmetric,
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: dimens.dialogMaxWidth,
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LoginHeader(),
                          SizedBox(height: AppDimens.spacingLG),
                          LoginForm(),
                          SizedBox(height: AppDimens.spacingXXL),
                          LoginFooter(),
                          SizedBox(height: AppDimens.spacingLG),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
