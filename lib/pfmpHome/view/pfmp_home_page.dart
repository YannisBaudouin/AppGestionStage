import 'package:app_gestion_stage/pfmpInsert/view/pfmp_insert_page.dart';
import 'package:flutter/material.dart';

import 'package:app_gestion_stage/global_var.dart' as global;
import 'package:app_gestion_stage/customWidget/custom_widget.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/pfmp_home_bloc.dart';

class PfmpHomePage extends StatelessWidget {
  const PfmpHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: global.lightTheme,
      darkTheme: global.darkTheme,
      home: const BuildPage(),
    );
  }
}

class BuildPage extends StatelessWidget {
  const BuildPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => PfmpHomeBloc(), child: PfmpHomeView());
  }
}

class PfmpHomeView extends StatelessWidget {
  PfmpHomeView({super.key});

  // page d'accueil des PFMPs
  @override
  Widget build(BuildContext context) {
    //Booléen qui change par rapport au thème
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return BlocBuilder<PfmpHomeBloc, PfmpHomeState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        switch (state) {
          case PfmpHomeInitial():
           context.read<PfmpHomeBloc>().add(PfmpHome_GetListWidgets(context: context));
          default:
        }

        return Scaffold(
          body: Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //Utilise le booléen définit plus haut pour changer l'image
                    global.currentLogo(isDarkMode),
                    Row(
                      //partie pour ajouter une PFMP
                      children: <Widget>[
                        RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            text: 'Mes PFMP',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                        CustomEBSI(
                          context: context,
                          selectedIcon: Icons.add_circle_outline,
                          shapeButton: CircleBorder(),
                          colorDark: Color(global.darkThemePrim),
                          colorLight: Color(global.lightThemePrim),
                          pressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const PfmpInsertPage()),
                            );

                            context.read<PfmpHomeBloc>().add(PfmpHome_GetListWidgets(context: context));
                          },
                        ),
                        Column(children: []),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 25),
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? Color(global.darkThemeSeco)
                            : Color(global.lightThemeSeco),
                      ),
                      alignment: Alignment.topCenter,
                      height: 500,
                      width: MediaQuery.of(context).size.width - 50,
                      child: ListView(children: context.select((PfmpHomeBloc bloc) => bloc.widgetsListPfmps)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
