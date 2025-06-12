part of 'about_bloc.dart';

sealed class AboutState {
  const AboutState();
}

final class AboutInitial extends AboutState {
  const AboutInitial();
}

final class AboutInitialised extends AboutState {
  const AboutInitialised();
}
