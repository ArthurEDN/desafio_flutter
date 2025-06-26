import 'package:bloc/bloc.dart';
import 'package:desafio_flutter/core/utils/result.dart';
import 'package:desafio_flutter/core/validators/cpf_validator.dart';
import 'package:desafio_flutter/core/validators/password_validator.dart';
import 'package:desafio_flutter/domain/repositories/auth/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final IAuthRepository _authRepository;

  LoginBloc({required IAuthRepository authRepository})
    : _authRepository = authRepository,
      super(const LoginState()) {
    on<LoginCpfChanged>(_onCpfChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  void _onCpfChanged(LoginCpfChanged event, Emitter<LoginState> emit) {
    final cpf = Cpf.dirty(event.cpf);
    emit(
      state.copyWith(
        cpf: cpf,
        isValid: Formz.validate([cpf, state.password]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([state.cpf, password]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    final cpf = Cpf.dirty(state.cpf.value);
    final password = Password.dirty(state.password.value);
    final isValid = Formz.validate([cpf, password]);
    emit(
      state.copyWith(
        cpf: cpf,
        password: password,
        isValid: isValid,
        status: FormzSubmissionStatus.initial,
      ),
    );

    if (!state.isValid) return;

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    if (isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      final result = await _authRepository.signIn(
        cpf: state.cpf.value,
        password: state.password.value,
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
