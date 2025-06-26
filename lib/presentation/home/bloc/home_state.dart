part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoadInProgress extends HomeState {}

class HomeLoadSuccess extends HomeState {
  final UserEntity user;
  const HomeLoadSuccess(this.user);
  @override
  List<Object> get props => [user];
}

class HomeLoadFailure extends HomeState {
  final String error;
  const HomeLoadFailure(this.error);
  @override
  List<Object> get props => [error];
}
