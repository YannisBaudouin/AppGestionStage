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
    final Uri url = Uri.parse('https://www.lemonde.fr/rss/une.xml');
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        print("FLAG 6");
        switch (state) {
          case HomeInitial():
            print("FLAG 5");
            context.read<HomeBloc>().add(
              getArticle(url: url, context: context),
            );
          default:
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
              Container(
                width: 350,
                height: MediaQuery.of(context).size.height / 1.8,
                margin: EdgeInsets.only(top: 20),
                child: context.read<HomeBloc>().listViewCool,
              ),
            ],
          ),
        );
      },
    );
  }
}
