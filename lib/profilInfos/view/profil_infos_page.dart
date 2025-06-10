import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_gestion_stage/global_var.dart' as global;
import 'package:firebase_auth/firebase_auth.dart';

import 'package:app_gestion_stage/profilEdit/profil_edit.dart';
import 'package:app_gestion_stage/class/appUser.dart';
import 'package:app_gestion_stage/customWidget/custom_widget.dart';
import 'package:app_gestion_stage/profil_page.dart';

import '../bloc/profil_infos_bloc.dart';

class ProfilInfosPage extends StatelessWidget {
  const ProfilInfosPage({super.key});

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
    return BlocProvider(
      create: (_) => ProfilInfosBloc(),
      child: ProfilInfosPageView(),
    );
  }
}

class ProfilInfosPageView extends StatelessWidget {
  const ProfilInfosPageView({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    List<Widget> popupOption = [
      CustomTB(
        text: "Déconnexion",
        pressed: () async {
          await FirebaseAuth.instance.signOut();

          if (FirebaseAuth.instance.currentUser == null) {
            Navigator.of(
              context,
              rootNavigator: true,
            ).pushNamedAndRemoveUntil("/", (_) => false);
          }
        },
      ),
      CustomRTB(text: "Annuler"),
    ];

    return BlocBuilder<ProfilInfosBloc, ProfilInfosState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        switch (state) {
          case ProfilInfosInitial():
            context.read<ProfilInfosBloc>().add(GetInfos());
          default:
        }

        AppUser? user = context.select((ProfilInfosBloc bloc) => bloc.user);

        if (user == null) {
          return Scaffold(
            body: Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[Text('Vous n\'êtes pas connecté(es).')],
              ),
            ),
          );
        }

        return Scaffold(
          body: Column(
            children: <Widget>[
              global.currentLogo(isDarkMode),
              Container(
                margin: EdgeInsets.only(top: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width - 200,
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? Color(global.darkThemeSeco)
                            : Color(global.lightThemeSeco),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: RichText(
                        text: TextSpan(
                          text: "Profil",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30, bottom: 30),
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      width: MediaQuery.of(context).size.width - 50,
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? Color(global.darkThemeSeco)
                            : Color(global.lightThemeSeco),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                              text: "UID : ${user.uid}",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: "Prénom : ${user.firstName}",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: "Nom : ${user.lastName}",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text:
                                  "Age: ${DateTime(DateTime.now().year - user.birthDate.year, DateTime.now().month - user.birthDate.month, DateTime.now().day - user.birthDate.day).year} ans",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: "Status : ${user.status}",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: "Etablissement : ${user.school}",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: "Filière : ${user.sector}",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: "Classe : ${user.userClass}",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: "Email : ${user.email}",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomEB(
                      text: "Édition du profil",
                      pressed: () async {
                        // Attend que l'utilisateur ferme la page
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ProfilEditPage(),
                          ),
                        );

                        // Actualise les infos affichées
                        context.read<ProfilInfosBloc>().add(GetInfos());
                      },
                      context: context,
                    ),

                    // Bouton Déconnexion
                    CustomEB(
                      text: "Se déconnecter",
                      pressed: () {
                        customShowDialog(
                          context,
                          "Déconnexion",
                          "Êtes-vous sûr?",
                          popupOption,
                        );
                      },
                      context: context,
                    ),
                    //Bouton de retour à la page d'avant
                    CustomEB(
                      text: "Retour",
                      pressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ProfilPage(),
                          ),
                        );
                      },
                      context: context,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
