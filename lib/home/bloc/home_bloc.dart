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
  List topStories = [];
  List<Widget> widgetsListActu = <Widget>[];
  ListView listViewCool = ListView();

  void _lauchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw 'Could not lauch $url';
    }
  }

  void _getArticle(getArticle event, Emitter<HomeState> emit) async {
    print("FLAG 1");
    http.Response reponse = await http.get(event.url);
    // Tranforme la réponse
    xml2json.parse(reponse.body);
    // Convert XML to JSON format
    String jsondata = xml2json.toGData();
    dynamic data = json.decode(jsondata);
    // Extract top stories from the JSON data
    topStories = data['rss']['channel']['item'];
    print("FLAG 2");
    try {
      for (int i = 1; i < topStories.length; i++) {
        //print(topStories[i]['guid']['\$t']);
        //print(topStories[i]);
        widgetsListActu.add(
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              maximumSize: Size(200, 250),
              backgroundColor: Color(global.commonTheme),
            ),
            onPressed: () {
              _lauchUrl(Uri.parse(topStories[i]['guid']['\$t']));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.network(
                  topStories[i]['media\$content']['url'],
                  height: 100,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: topStories[i]['title']['__cdata'],
                    style: Theme.of(event.context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
        );

        print("FLAG 3");
      }
    } catch (e) {
      print(e);
    }

    listViewCool = ListView(children: widgetsListActu);
    emit(HomeInitialised());
    print("FLAG 4");
    print(widgetsListActu);
  }
}
