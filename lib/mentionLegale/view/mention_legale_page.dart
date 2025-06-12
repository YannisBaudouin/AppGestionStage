import 'package:app_gestion_stage/customWidget/custom_widget.dart';
import 'package:app_gestion_stage/global_var.dart' as global;
import 'package:app_gestion_stage/profil_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../mention_legale.dart';

class MentionLegale extends StatelessWidget {
  const MentionLegale({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppStage',
      themeMode: ThemeMode.system,
      theme: global.lightTheme,
      darkTheme: global.darkTheme,
      home: const MentionLegalePage(),
    );
  }
}

class MentionLegalePage extends StatelessWidget {
  const MentionLegalePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MentionLegaleBloc(),
      child: MentionLegaleView(),
    );
  }
}

class MentionLegaleView extends StatelessWidget {
  MentionLegaleView({super.key});

  @override
  Widget build(BuildContext context) {
    //Booléen qui change par rapport au thème
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    String mention = "Fail";
    return BlocBuilder<MentionLegaleBloc, MentionLegaleState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        switch (state) {
          case MentionLegaleInitial():
            context.read<MentionLegaleBloc>().add(
              getTextFile(path: 'assets/mentionLegal.txt'),
            );
          default:
        }

        mention = context.select((MentionLegaleBloc bloc) => bloc.mentions);
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
              CustomEB(
                text: "Retour",
                context: context,
                pressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PageProfil()),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
