import 'package:desafio_flutter/core/routing/routes.dart';
import 'package:desafio_flutter/core/themes/colors.dart';
import 'package:desafio_flutter/core/themes/dimens.dart';
import 'package:desafio_flutter/presentation/auth/forgot_password/bloc/forgot_password_bloc.dart';
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
          _buildBackground(),
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
                          return _buildSuccessView(context);
                        }
                        return _buildFormStack(context);
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

  Widget _buildBackground() {
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: Container(
            decoration: const BoxDecoration(
              gradient: AppColors.backgroundGradient,
            ),
          ),
        ),
        Expanded(flex: 6, child: Container(color: AppColors.background)),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Text(
          'Recuperar Senha',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppDimens.spacingMD),
        Text(
          'Insira o seu e-mail de registo e enviaremos as instruções para criar uma nova senha.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.white.withOpacity(0.9),
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildFormStack(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(AppDimens.paddingLG),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(AppDimens.radiusXL),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(context),
              const SizedBox(height: AppDimens.spacingXL),
              _buildEmailInput(),
              const SizedBox(
                height: AppDimens.fabSize / 2 + AppDimens.spacingMD,
              ),
            ],
          ),
        ),
        Positioned(
          bottom: -(AppDimens.fabSize / 2),
          child: _buildSubmitButton(),
        ),
      ],
    );
  }

  InputDecoration _buildInputDecoration({
    required String hintText,
    required IconData prefixIcon,
    String? errorText,
  }) {
    return InputDecoration(
      prefixIcon: Icon(
        prefixIcon,
        color: AppColors.textTertiary,
        size: AppDimens.iconSM,
      ),
      hintText: hintText,
      hintStyle: const TextStyle(color: AppColors.textTertiary),
      filled: true,
      fillColor: AppColors.background,
      contentPadding: const EdgeInsets.symmetric(
        vertical: AppDimens.paddingMD,
        horizontal: AppDimens.paddingMD,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimens.radiusMD),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimens.radiusMD),
        borderSide: const BorderSide(color: AppColors.accent, width: 1.5),
      ),
      errorText: errorText,
      errorStyle: const TextStyle(color: AppColors.error, fontSize: 12),
    );
  }

  Widget _buildEmailInput() {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormField(
          style: const TextStyle(color: AppColors.textPrimary),
          decoration: _buildInputDecoration(
            hintText: 'E-mail de registo',
            prefixIcon: Icons.email_outlined,
            errorText: state.email.displayError != null
                ? 'E-mail inválido'
                : null,
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) => context.read<ForgotPasswordBloc>().add(
            ForgotPasswordEmailChanged(value),
          ),
        );
      },
    );
  }

  Widget _buildSubmitButton() {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      builder: (context, state) {
        final isLoading = state.status == FormzSubmissionStatus.inProgress;
        return SizedBox(
          width: AppDimens.fabSize,
          height: AppDimens.fabSize,
          child: ElevatedButton(
            onPressed: isLoading
                ? null
                : () => context.read<ForgotPasswordBloc>().add(
                    const ForgotPasswordSubmitted(),
                  ),
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              backgroundColor: AppColors.accent,
              foregroundColor: Colors.white,
              padding: EdgeInsets.zero,
              fixedSize: const Size(AppDimens.fabSize, AppDimens.fabSize),
            ),
            child: isLoading
                ? const SizedBox(
                    width: AppDimens.iconMD,
                    height: AppDimens.iconMD,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Icon(Icons.send_outlined),
          ),
        );
      },
    );
  }

  Widget _buildSuccessView(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingXL),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppDimens.radiusXL),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.mark_email_read_outlined,
            color: AppColors.accent,
            size: 64,
          ),
          const SizedBox(height: AppDimens.spacingLG),
          Text(
            'Verifique o seu E-mail',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimens.spacingMD),
          Text(
            'Enviámos um link de recuperação para o seu endereço de e-mail. Por favor, siga as instruções para redefinir a sua senha.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimens.spacingXL),
          TextButton(
            onPressed: () => context.go(Routes.login),
            child: const Text(
              'Voltar ao Login',
              style: TextStyle(
                color: AppColors.accent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
