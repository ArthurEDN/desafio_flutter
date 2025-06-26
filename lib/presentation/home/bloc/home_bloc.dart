import 'package:bloc/bloc.dart';
import 'package:desafio_flutter/core/utils/result.dart';
import 'package:desafio_flutter/domain/models/user.dart';
import 'package:desafio_flutter/domain/repositories/user/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IUserRepository _userRepository;

  HomeBloc({required IUserRepository userRepository})
    : _userRepository = userRepository,
      super(HomeInitial()) {
    on<HomeDataRequested>(_onDataRequested);
  }

  Future<void> _onDataRequested(
    HomeDataRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadInProgress());
    final result = await _userRepository.getUserProfile(event.id);
    if (result.isSuccess) {
      emit(HomeLoadSuccess(result.value));
    } else {
      emit(
        HomeLoadFailure(result.failureOrNull?.message ?? 'Erro desconhecido'),
      );
    }
  }
}
