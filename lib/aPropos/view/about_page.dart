import 'package:app_gestion_stage/customWidget/custom_widget.dart';
import 'package:app_gestion_stage/global_var.dart' as global;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../about.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => AboutBloc(), child: AbouteView());
  }
}

class AbouteView extends StatelessWidget {
  AbouteView({super.key});

  @override
  Widget build(BuildContext context) {
    //Booléen qui change par rapport au thème
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    String mention = "Fail";
    return BlocBuilder<AboutBloc, AboutState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        switch (state) {
          case AboutInitial():
            context.read<AboutBloc>().add(
              getTextFile(path: 'assets/about.txt'),
            );
          default:
        }

        mention = context.select((AboutBloc bloc) => bloc.mentions);
        return Scaffold(
          body: Column(
            children: <Widget>[
              global.currentLogo(isDarkMode),
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 20),
                width: MediaQuery.of(context).size.width - 50,
                height: MediaQuery.of(context).size.height / 1.8,
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? Color(global.darkThemeSeco)
                      : Color(global.lightThemeSeco),
                ),
                child: ListView(
                  children: <Widget>[
                    CustomRT(
                      style: Theme.of(context).textTheme.bodySmall,
                      context: context,
                      text: mention,
                    ),
                  ],
                ),
              ),
              CustomREB(text: "Retour", context: context),
            ],
          ),
        );
      },
    );
  }
}
