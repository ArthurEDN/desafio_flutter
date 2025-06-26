import 'package:bloc/bloc.dart';
import 'package:desafio_flutter/core/utils/result.dart';
import 'package:desafio_flutter/core/validators/email_validator.dart';
import 'package:desafio_flutter/domain/repositories/auth/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final IAuthRepository _authRepository;

  ForgotPasswordBloc({required IAuthRepository authRepository})
    : _authRepository = authRepository,
      super(const ForgotPasswordState()) {
    on<ForgotPasswordEmailChanged>(_onEmailChanged);
    on<ForgotPasswordSubmitted>(_onSubmitted);
  }

  void _onEmailChanged(
    ForgotPasswordEmailChanged event,
    Emitter<ForgotPasswordState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(email: email, isValid: Formz.validate([email])));
  }

  Future<void> _onSubmitted(
    ForgotPasswordSubmitted event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    final email = Email.dirty(state.email.value);
    final isValid = Formz.validate([email]);

    emit(
      state.copyWith(
        email: email,
        isValid: isValid,
        status: FormzSubmissionStatus.initial,
      ),
    );

    if (isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      final result = await _authRepository.requestPasswordReset(
        email: state.email.value,
      );

      if (result.isSuccess) {
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } else {
        emit(
          state.copyWith(
            status: FormzSubmissionStatus.failure,
            errorMessage: result.failureOrNull?.message,
          ),
        );
      }
    }
  }
}
