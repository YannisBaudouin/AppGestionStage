part of 'charte_bloc.dart';

sealed class CharteState {
  const CharteState();
}

final class CharteInitial extends CharteState {
  const CharteInitial();
}

final class CharteInitialised extends CharteState {
  const CharteInitialised();
}
