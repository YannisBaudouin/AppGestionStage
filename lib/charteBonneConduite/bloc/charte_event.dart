part of 'charte_bloc.dart';

sealed class CharteEvent {
  const CharteEvent();
}

class getTextFile extends CharteEvent {
  final String path;
  const getTextFile({required this.path});
}
