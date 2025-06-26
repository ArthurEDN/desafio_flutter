import 'package:desafio_flutter/core/utils/result.dart';
import 'package:desafio_flutter/core/validators/cpf_validator.dart';
import 'package:desafio_flutter/core/validators/email_validator.dart';
import 'package:desafio_flutter/core/validators/name_validator.dart';
import 'package:desafio_flutter/core/validators/password_validator.dart';
import 'package:bloc/bloc.dart';
import 'package:desafio_flutter/domain/repositories/auth/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final IAuthRepository _authRepository;

  RegisterBloc({required IAuthRepository authRepository})
    : _authRepository = authRepository,
      super(const RegisterState()) {
    on<RegisterNameChanged>(_onNameChanged);
    on<RegisterEmailChanged>(_onEmailChanged);
    on<RegisterCpfChanged>(_onCpfChanged);
    on<RegisterPasswordChanged>(_onPasswordChanged);
    on<RegisterSubmitted>(_onSubmitted);
  }

  void _onNameChanged(RegisterNameChanged event, Emitter<RegisterState> emit) {
    final name = Name.dirty(event.name);
    emit(
      state.copyWith(
        name: name,
        isValid: Formz.validate([name, state.email, state.cpf, state.password]),
      ),
    );
  }

  void _onEmailChanged(
    RegisterEmailChanged event,
    Emitter<RegisterState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([state.name, email, state.cpf, state.password]),
      ),
    );
  }

  void _onCpfChanged(RegisterCpfChanged event, Emitter<RegisterState> emit) {
    final cpf = Cpf.dirty(event.cpf);
    emit(
      state.copyWith(
        cpf: cpf,
        isValid: Formz.validate([state.name, state.email, cpf, state.password]),
      ),
    );
  }

  void _onPasswordChanged(
    RegisterPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([state.name, state.email, state.cpf, password]),
      ),
    );
  }

  Future<void> _onSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    // Cria versões "dirty" de todos os inputs para forçar a exibição de erros
    final name = Name.dirty(state.name.value);
    final email = Email.dirty(state.email.value);
    final cpf = Cpf.dirty(state.cpf.value);
    final password = Password.dirty(state.password.value);

    // Re-valida com os inputs "dirty"
    final isValid = Formz.validate([name, email, cpf, password]);

    // Emite o novo estado com os inputs "dirty" para que a UI atualize e mostre os erros
    emit(
      state.copyWith(
        name: name,
        email: email,
        cpf: cpf,
        password: password,
        isValid: isValid,
      ),
    );

    if (isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      final result = await _authRepository.signUp(
        name: state.name.value,
        email: state.email.value,
        cpf: state.cpf.value,
        password: state.password.value,
      );

      if (result.isSuccess) {
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } else {
        print(result.failureOrNull?.message);
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
