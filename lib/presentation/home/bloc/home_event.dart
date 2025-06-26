part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object> get props => [];
}

class HomeDataRequested extends HomeEvent {
  final String id;
  const HomeDataRequested(this.id);
  @override
  List<Object> get props => [id];
}
