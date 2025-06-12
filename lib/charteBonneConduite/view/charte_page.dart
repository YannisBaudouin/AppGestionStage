import 'package:app_gestion_stage/customWidget/custom_widget.dart';
import 'package:app_gestion_stage/global_var.dart' as global;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../charte.dart';

class ChartePage extends StatelessWidget {
  const ChartePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => CharteBloc(), child: CharteView());
  }
}

class CharteView extends StatelessWidget {
  const CharteView({super.key});

  @override
  Widget build(BuildContext context) {
    //Booléen qui change par rapport au thème
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    String mention = "Fail";
    return BlocBuilder<CharteBloc, CharteState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        switch (state) {
          case CharteInitial():
            context.read<CharteBloc>().add(
              getTextFile(path: 'assets/charteConduite.txt'),
            );
          default:
        }

        mention = context.select((CharteBloc bloc) => bloc.mentions);
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
