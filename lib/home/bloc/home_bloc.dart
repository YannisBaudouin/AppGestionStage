import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xml2json/xml2json.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeInitial()) {
    on<getArticle>(_getArticle);
  }

  final Xml2Json xml2json = Xml2Json();

  void _launchUrl(Uri url) async {
    //si jamais la redirection échoue, renvoie un message d'erreur
    if (!await launchUrl(url)) {
      throw 'Could not lauch $url';
    }
  }

  void _getArticle(getArticle event, Emitter<HomeState> emit) async {
    http.Response reponse = await http.get(event.url);
    // Tranforme la réponse
    xml2json.parse(reponse.body);
    // Convert XML to JSON format
    String jsondata = xml2json.toGData();
    dynamic data = json.decode(jsondata);
    // Extract top stories from the JSON data
    List tops = data['rss']['channel']['item'];

    emit(HomeInitialisedState(tops, _launchUrl));
  }
}
