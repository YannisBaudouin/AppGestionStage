//import 'package:app_gestion_stage/class/pfmp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_gestion_stage/global_var.dart' as global;
import 'package:app_gestion_stage/customWidget/custom_widget.dart';
import 'package:app_gestion_stage/emploiDuTemps/pfmp_emploi_temps.dart';

class PfmpEmploiTempsPage extends StatelessWidget {
  final String? pfmpId;
  const PfmpEmploiTempsPage({super.key, required this.pfmpId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PfmpEmploiTempsBloc(),
      child: PfmpEmploiTempsView(pfmpId: pfmpId),
    );
  }
}

class PfmpEmploiTempsView extends StatelessWidget {
  final String? pfmpId;
  const PfmpEmploiTempsView({super.key, required this.pfmpId});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    List<String> jourSemaine = [
      "Lundi",
      "Mardi",
      "Mercredi",
      "Jeudi",
      "Vendredi",
      "Samedi",
    ];
    List<Widget> listeWidget = [];
    for (int i = 0; i < jourSemaine.length; i++) {
      //case jour de la semaine
      listeWidget.add(
        CustomETC(
          enfant: CustomRT(
            text: jourSemaine[i],
            style: Theme.of(context).textTheme.headlineMedium,
            context: context,
          ),
          context: context,
        ),
      );
      //case pour le premier bouton
      listeWidget.add(
        CustomETC(
          enfant: CustomTB(text: "temp", pressed: () {}),
          context: context,
        ),
      );
      //case pour le deuxième bouton
      listeWidget.add(
        CustomETC(
          enfant: CustomTB(text: "temp", pressed: () {}),
          context: context,
        ),
      );
    }

    return BlocBuilder<PfmpEmploiTempsBloc, PfmpEmploiTempsState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        switch (state) {
          case PfmpEmploiTempsInitial():
            context.read<PfmpEmploiTempsBloc>().add(
              PfmpEmploiTempsGetInfo(pfmpId),
            );
          default:
        }
        return Scaffold(
          body: Column(
            children: <Widget>[
              global.currentLogo(isDarkMode),
              Container(
                width: MediaQuery.of(context).size.width - 50,
                height: MediaQuery.of(context).size.height - 300,
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? Color(global.darkThemeSeco)
                      : Color(global.lightThemeSeco),
                ),
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  children: listeWidget,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
