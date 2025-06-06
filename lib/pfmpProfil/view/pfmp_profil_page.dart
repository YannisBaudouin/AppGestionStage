import 'package:flutter/material.dart';
import 'package:app_gestion_stage/pfmpInsert/pfmp_insert.dart';
import 'package:app_gestion_stage/global_var.dart' as global;
import 'package:app_gestion_stage/customWidget/custom_widget.dart';
import 'package:app_gestion_stage/pfmpProfil/pfmp_profil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PfmpProfilPage extends StatelessWidget {
  final String? pfmpId;
  const PfmpProfilPage({super.key, this.pfmpId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PfmpProfilBloc(),
      child: PfmpProfilView(pfmpId: pfmpId),
    );
  }
}

class PfmpProfilView extends StatelessWidget {
  final String? pfmpId;
  const PfmpProfilView({super.key, required this.pfmpId});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return BlocBuilder<PfmpProfilBloc, PfmpProfilState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        switch (state) {
          case PfmpProfilInitial():
            context.read<PfmpProfilBloc>().add(PfmpProfil_GetInfos(pfmpId));
          default:
        }

        return Scaffold(
          body: Column(
            children: <Widget>[
              global.currentLogo(isDarkMode),
              CustomTBI(
                text:
                    context.read<PfmpProfilBloc>().targetPfmp?.nomSociete ??
                    "Y'a r",
                pressed: () {
                  // redirection vers la page d'aperçu du profil
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PfmpInsertPage(pfmpId: pfmpId),
                    ),
                  );
                },
                selectedIcon: Icons.edit_square,
              ),
              CustomEB(
                text: "Carnet de bord",
                pressed: () {},
                context: context,
              ),
              CustomEB(text: "Évaluation", pressed: () {}, context: context),
              CustomREB(text: "Retour", context: context),
            ],
          ),
        );
      },
    );
  }
}
