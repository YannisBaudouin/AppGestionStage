part of 'home_bloc.dart';

sealed class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeInitialised extends HomeState {
  const HomeInitialised();
}
