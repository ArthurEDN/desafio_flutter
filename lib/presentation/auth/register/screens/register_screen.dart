import 'package:desafio_flutter/core/themes/colors.dart';
import 'package:desafio_flutter/core/themes/dimens.dart';
import 'package:desafio_flutter/presentation/auth/register/bloc/register_bloc.dart';
import 'package:desafio_flutter/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordObscured = true;
  bool _has8Chars = false;
  bool _hasUppercase = false;
  bool _hasLowercase = false;
  bool _hasNumber = false;
  bool _hasSpecialChar = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _cpfController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validatePassword(String password) {
    setState(() {
      _has8Chars = password.length >= 8;
      _hasUppercase = password.contains(RegExp(r'[A-Z]'));
      _hasLowercase = password.contains(RegExp(r'[a-z]'));
      _hasNumber = password.contains(RegExp(r'[0-9]'));
      _hasSpecialChar = password.contains(RegExp(r'[!@#\$&*~]'));
    });
  }

  @override
  Widget build(BuildContext context) {
    final dimens = AppDimens.of(context);

    return Scaffold(
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
                    child: BlocBuilder<RegisterBloc, RegisterState>(
                      builder: (context, state) {
                        if (state.status == FormzSubmissionStatus.success) {
                          return _buildSuccessView(context);
                        }
                        return _buildRegisterForm(context);
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
            Icons.check_circle_outline_rounded,
            color: AppColors.accent,
            size: 64,
          ),
          const SizedBox(height: AppDimens.spacingLG),
          Text(
            'Registo Realizado!',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimens.spacingMD),
          Text(
            'A sua conta foi criada com sucesso. Por favor, faça o login para continuar.',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimens.spacingXL),
          ElevatedButton(
            onPressed: () => context.go(Routes.login),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.paddingXL,
                vertical: AppDimens.paddingMD,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimens.radiusMD),
              ),
            ),
            child: const Text('Ir para o Login'),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterForm(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildHeader(context),
        const SizedBox(height: AppDimens.spacingLG),
        _buildRegisterFormStack(context),
      ],
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
          'Crie sua Conta',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppDimens.spacingSM),
        Text(
          'É rápido e fácil, vamos começar!',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.white.withOpacity(0.9),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildRegisterFormStack(BuildContext context) {
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
              _buildNameInput(),
              const SizedBox(height: AppDimens.spacingMD),
              _buildEmailInput(),
              const SizedBox(height: AppDimens.spacingMD),
              _buildCpfInput(),
              const SizedBox(height: AppDimens.spacingMD),
              _buildPasswordInput(),
              const SizedBox(height: AppDimens.spacingMD),
              _buildPasswordRequirements(),
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
        GestureDetector(
          onTap: () => context.go(Routes.login),
          child: Text(
            'Entrar',
            style: Theme.of(
              context,
            ).textTheme.labelLarge?.copyWith(color: AppColors.textSecondary),
          ),
        ),
        const SizedBox(width: AppDimens.spacingXL),
        Column(
          children: [
            Text(
              'Cadastrar',
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

  Widget _buildNameInput() {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextFormField(
          controller: _nameController,
          style: const TextStyle(color: AppColors.textPrimary),
          decoration: _buildInputDecoration(
            hintText: 'Nome completo',
            prefixIcon: Icons.person_outline,
            errorText: state.name.displayError != null ? 'Nome inválido' : null,
          ),
          keyboardType: TextInputType.name,
          onChanged: (value) =>
              context.read<RegisterBloc>().add(RegisterNameChanged(value)),
        );
      },
    );
  }

  Widget _buildEmailInput() {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormField(
          controller: _emailController,
          style: const TextStyle(color: AppColors.textPrimary),
          decoration: _buildInputDecoration(
            hintText: 'E-mail',
            prefixIcon: Icons.email_outlined,
            errorText: state.email.displayError != null
                ? 'E-mail inválido'
                : null,
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) =>
              context.read<RegisterBloc>().add(RegisterEmailChanged(value)),
        );
      },
    );
  }

  Widget _buildCpfInput() {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.cpf != current.cpf,
      builder: (context, state) {
        return TextFormField(
          controller: _cpfController,
          style: const TextStyle(color: AppColors.textPrimary),
          decoration: _buildInputDecoration(
            hintText: 'CPF',
            prefixIcon: Icons.badge_outlined,
            errorText: state.cpf.displayError != null ? 'CPF inválido' : null,
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(11),
          ],
          onChanged: (value) =>
              context.read<RegisterBloc>().add(RegisterCpfChanged(value)),
        );
      },
    );
  }

  Widget _buildPasswordInput() {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormField(
          controller: _passwordController,
          style: const TextStyle(color: AppColors.textPrimary),
          decoration: _buildInputDecoration(
            hintText: 'Senha',
            prefixIcon: Icons.lock_outline,
            errorText:
                state.password.isNotValid &&
                    state.password.displayError?.name == 'empty'
                ? 'Senha é obrigatória'
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
          onChanged: (password) {
            _validatePassword(password);
            context.read<RegisterBloc>().add(RegisterPasswordChanged(password));
          },
        );
      },
    );
  }

  Widget _buildPasswordRequirements() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingSM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PasswordRequirementItem(
            text: 'Mínimo de 8 caracteres',
            isMet: _has8Chars,
          ),
          const SizedBox(height: AppDimens.spacingSM),
          _PasswordRequirementItem(
            text: 'Uma letra maiúscula (A-Z)',
            isMet: _hasUppercase,
          ),
          const SizedBox(height: AppDimens.spacingSM),
          _PasswordRequirementItem(
            text: 'Uma letra minúscula (a-z)',
            isMet: _hasLowercase,
          ),
          const SizedBox(height: AppDimens.spacingSM),
          _PasswordRequirementItem(text: 'Um número (0-9)', isMet: _hasNumber),
          const SizedBox(height: AppDimens.spacingSM),
          _PasswordRequirementItem(
            text: 'Um caractere especial (!@#\$&*~)',
            isMet: _hasSpecialChar,
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        final isLoading = state.status == FormzSubmissionStatus.inProgress;
        return SizedBox(
          width: AppDimens.fabSize,
          height: AppDimens.fabSize,
          child: ElevatedButton(
            onPressed: isLoading
                ? null
                : () => context.read<RegisterBloc>().add(
                    const RegisterSubmitted(),
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
                : const Icon(Icons.arrow_forward),
          ),
        );
      },
    );
  }
}

class _PasswordRequirementItem extends StatelessWidget {
  final String text;
  final bool isMet;

  const _PasswordRequirementItem({required this.text, required this.isMet});

  @override
  Widget build(BuildContext context) {
    final color = isMet ? AppColors.success : AppColors.textTertiary;
    return Row(
      children: [
        Icon(
          isMet ? Icons.check_circle : Icons.remove_circle_outline,
          color: color,
          size: AppDimens.iconSM,
        ),
        const SizedBox(width: AppDimens.spacingSM),
        Text(
          text,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: color),
        ),
      ],
    );
  }
}
