part of 'about_bloc.dart';

sealed class AboutEvent {
  const AboutEvent();
}

class getTextFile extends AboutEvent {
  final String path;
  const getTextFile({required this.path});
}
