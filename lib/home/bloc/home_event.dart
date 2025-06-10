part of 'home_bloc.dart';

sealed class HomeEvent {
  const HomeEvent();
}

class getArticle extends HomeEvent {
  final Uri url;
  final BuildContext context;
  const getArticle({required this.url, required this.context});
}
