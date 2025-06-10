import 'package:app_gestion_stage/global_var.dart' as global;
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
  //liste des articles
  List topStories = [];
  //liste de widget pour contenir les boutons pour les articles
  List<Widget> widgetsListActu = <Widget>[];
  //widget pour contenir la liste de widget puis les intégrer dans une page
  ListView listViewCool = ListView();

  void _lauchUrl(Uri url) async {
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
    topStories = data['rss']['channel']['item'];
    try {
      for (int i = 0; i < topStories.length; i++) {
        widgetsListActu.add(
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              maximumSize: Size(200, 250),
              backgroundColor: Color(global.commonTheme),
            ),
            onPressed: () {
              //redirige vers le site
              _lauchUrl(Uri.parse(topStories[i]['link']['\$t']));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // image pour l'article
                Image.asset('assets/ministereEducNationale.png', height: 150),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    //titre de l'article
                    text: topStories[i]['title']['\$t'],
                    style: Theme.of(event.context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    } catch (e) {
      print(e);
    }

    listViewCool = ListView(children: widgetsListActu);
    emit(HomeInitialised());
  }
}
