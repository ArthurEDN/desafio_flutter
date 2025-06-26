import 'package:desafio_flutter/core/themes/colors.dart';
import 'package:desafio_flutter/core/themes/dimens.dart';
import 'package:desafio_flutter/presentation/auth/login/bloc/login_bloc.dart';
import 'package:desafio_flutter/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _cpfController = TextEditingController();
  final _passwordController = TextEditingController();
  final _cpfFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  bool _rememberMe = false;
  bool _isPasswordObscured = true;

  @override
  void dispose() {
    _cpfController.dispose();
    _passwordController.dispose();
    _cpfFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

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
            Positioned.fill(child: _buildBackground()),
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: dimens.edgeInsetsScreenSymmetric,
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: dimens.dialogMaxWidth,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildHeader(context),
                          const SizedBox(height: AppDimens.spacingLG),
                          _buildLoginFormStack(context),
                          const SizedBox(height: AppDimens.spacingXXL),
                          _buildFooter(context),
                          const SizedBox(height: AppDimens.spacingLG),
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
          'Bem vindo!',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppDimens.spacingSM),
        Text(
          'Aqui você gerencia seus seguros e de sua família em poucos cliques!',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.white.withOpacity(0.9),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildLoginFormStack(BuildContext context) {
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
              _buildAuthTabs(context),
              const SizedBox(height: AppDimens.spacingXL),
              _buildCpfInput(),
              const SizedBox(height: AppDimens.spacingMD),
              _buildPasswordInput(),
              const SizedBox(height: AppDimens.spacingMD),
              _buildOptionsRow(context),
              const SizedBox(height: AppDimens.fabSize / 2),
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

  Widget _buildAuthTabs(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(
              'Entrar',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppDimens.spacingXS),
            Container(
              height: AppDimens.spacingXS,
              width: AppDimens.paddingXL,
              decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(AppDimens.radiusCircle),
              ),
            ),
          ],
        ),
        const SizedBox(width: AppDimens.spacingXL),
        GestureDetector(
          onTap: () => context.go(Routes.register),
          child: Text(
            'Cadastrar',
            style: Theme.of(
              context,
            ).textTheme.labelLarge?.copyWith(color: AppColors.textSecondary),
          ),
        ),
      ],
    );
  }

  InputDecoration _buildInputDecoration({
    required String hintText,
    required IconData prefixIcon,
    Widget? suffixIcon,
    String? errorText,
  }) {
    return InputDecoration(
      prefixIcon: Icon(
        prefixIcon,
        color: AppColors.textTertiary,
        size: AppDimens.iconSM,
      ),
      suffixIcon: suffixIcon,
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
      enabledBorder: OutlineInputBorder(
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

  Widget _buildCpfInput() {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.cpf != current.cpf,
      builder: (context, state) {
        return TextFormField(
          controller: _cpfController,
          focusNode: _cpfFocusNode,
          style: const TextStyle(color: AppColors.textPrimary),
          decoration: _buildInputDecoration(
            hintText: 'CPF',
            prefixIcon: Icons.person_outline,
            errorText: state.cpf.displayError != null ? 'CPF inválido' : null,
          ),
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(11),
          ],
          onChanged: (value) {
            context.read<LoginBloc>().add(LoginCpfChanged(value));
          },
          onFieldSubmitted: (_) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
        );
      },
    );
  }

  Widget _buildPasswordInput() {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormField(
          controller: _passwordController,
          focusNode: _passwordFocusNode,
          style: const TextStyle(color: AppColors.textPrimary),
          decoration: _buildInputDecoration(
            hintText: 'Senha',
            prefixIcon: Icons.lock_outline,
            errorText: state.password.displayError != null
                ? 'Senha inválida'
                : null,
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordObscured
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: AppColors.textTertiary,
                size: AppDimens.iconSM,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordObscured = !_isPasswordObscured;
                });
              },
            ),
          ),
          obscureText: _isPasswordObscured,
          textInputAction: TextInputAction.done,
          onChanged: (value) {
            context.read<LoginBloc>().add(LoginPasswordChanged(value));
          },
          onFieldSubmitted: (_) {
            context.read<LoginBloc>().add(LoginSubmitted());
          },
        );
      },
    );
  }

  Widget _buildOptionsRow(BuildContext context) {
    final isMobile = AppDimens.isMobile(context);

    return Row(
      children: [
        SizedBox(
          width: AppDimens.iconMD,
          height: AppDimens.iconMD,
          child: Checkbox(
            value: _rememberMe,
            onChanged: (value) {
              setState(() {
                _rememberMe = value ?? false;
              });
            },
            shape: const CircleBorder(),
            activeColor: AppColors.accent,
          ),
        ),
        SizedBox(width: isMobile ? AppDimens.spacingXS : AppDimens.spacingSM),
        Flexible(
          flex: isMobile ? 2 : 3,
          child: Text(
            'Lembrar Sempre',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
              fontSize: isMobile ? 12 : null,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        SizedBox(width: isMobile ? AppDimens.spacingXS : AppDimens.spacingSM),
        Flexible(
          flex: isMobile ? 2 : 2,
          child: TextButton(
            onPressed: () => context.go(Routes.forgotPassword),
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile
                    ? AppDimens.paddingXS
                    : AppDimens.paddingSM,
              ),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'Esqueceu a senha?',
              style: TextStyle(
                color: AppColors.accent,
                fontWeight: FontWeight.bold,
                fontSize: isMobile ? 12 : 16,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.right,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        final isLoading = state.status == FormzSubmissionStatus.inProgress;
        return SizedBox(
          width: AppDimens.fabSize,
          height: AppDimens.fabSize,
          child: ElevatedButton(
            onPressed: isLoading
                ? null
                : () => context.read<LoginBloc>().add(LoginSubmitted()),
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
                : const Icon(Icons.arrow_forward),
          ),
        );
      },
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'tokio resolve',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppDimens.spacingMD),
        Text(
          'Acesse através das redes sociais',
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: AppDimens.spacingLG),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _SocialButton(icon: 'G', onPressed: () {}),
            const SizedBox(width: AppDimens.spacingLG),
            _SocialButton(icon: 'f', onPressed: () {}),
            const SizedBox(width: AppDimens.spacingLG),
            _SocialButton(icon: '𝕏', onPressed: () {}),
          ],
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String icon;
  final VoidCallback onPressed;

  const _SocialButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(AppDimens.socialButtonSize / 2),
      child: Container(
        width: AppDimens.socialButtonSize,
        height: AppDimens.socialButtonSize,
        decoration: const BoxDecoration(
          color: AppColors.socialButtonBackground,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            icon,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.socialButtonText,
            ),
          ),
        ),
      ),
    );
  }
}
