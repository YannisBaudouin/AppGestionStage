import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_gestion_stage/global_var.dart' as global;
//import 'package:app_gestion_stage/customWidget/custom_widget.dart';
import 'package:app_gestion_stage/home/home.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => HomeBloc(), child: HomeView());
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Uri url = Uri.parse(
      'https://www.education.gouv.fr/actualites.rss#xtor=RSS-20',
    );
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        switch (state) {
          case HomeInitial():
            context.read<HomeBloc>().add(
              getArticle(url: url, context: context),
            );
          case HomeInitialisedState():
            return Scaffold(
              body: Column(
                children: <Widget>[
                  global.currentLogo(isDarkMode),
                  RichText(
                    text: TextSpan(
                      text: "Actualités",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                  Container(
                    width: 350,
                    height: MediaQuery.of(context).size.height / 1.8,
                    margin: EdgeInsets.only(top: 20),
                    child: ListView(
                      children: <Widget>[
                        for (int j = 0; j < state.tops.length; j++)
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              maximumSize: Size(200, 250),
                              backgroundColor: Color(global.commonTheme),
                            ),
                            onPressed: () {
                              //redirige vers le site
                              state.launch(
                                Uri.parse(state.tops[j]['link']['\$t']),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                // image pour l'article
                                Image.asset(
                                  'assets/ministereEducNationale.png',
                                  height: 150,
                                ),
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    //titre de l'article
                                    text: state.tops[j]['title']['\$t'],
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
        }

        return Scaffold(
          body: Column(
            children: <Widget>[
              global.currentLogo(isDarkMode),
              RichText(
                text: TextSpan(
                  text: "Actualités",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
