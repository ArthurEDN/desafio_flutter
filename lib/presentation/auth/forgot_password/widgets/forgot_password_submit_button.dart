import 'package:desafio_flutter/core/themes/colors.dart';
import 'package:desafio_flutter/core/themes/dimens.dart';
import 'package:desafio_flutter/presentation/auth/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class ForgotPasswordSubmitButton extends StatelessWidget {
  const ForgotPasswordSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
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
}
