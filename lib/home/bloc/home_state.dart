part of 'home_bloc.dart';

sealed class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeInitialisedState extends HomeState {
  List tops;
  Function launch;
  HomeInitialisedState(this.tops, this.launch) : super();
}
