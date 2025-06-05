//import 'package:app_gestion_stage/profilEdit/profil_edit.dart';
import 'package:app_gestion_stage/customWidget/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/profil_edit_bloc.dart';
import 'package:app_gestion_stage/class/appUser.dart';

class ProfilEditPage extends StatelessWidget {
  const ProfilEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfilEditBloc(),
      child: ProfilEditView(),
    );
  }
}

class ProfilEditView extends StatelessWidget {
  ProfilEditView({super.key});

  final TextEditingController fNameController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();
  DateTime? birthDate;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfilEditBloc, ProfilEditState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {

        switch (state) {
          case ProfilEditInitial():
            context.read<ProfilEditBloc>().add(ProfilEdit_GetInfos());
          default:
        }

        AppUser? user = context.select((ProfilEditBloc bloc) => bloc.user);

        if (user == null) {
          return Scaffold(
            body: Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[Text('Vous n\'êtes pas connecté(e)s.')],
              ),
            ),
          );
        }

        fNameController.text = user.firstName;
        lNameController.text = user.lastName;
        birthDate = user.birthDate;

        return Scaffold(
          body: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Edition du profil"),
                // PRENOM
                SizedBox(
                  width: 250,
                  child: CustomTF(
                    labelText: "Prénom",
                    controller: fNameController,
                    context: context,
                    hintText: "Roger",
                    helperText: null,
                    cacher: false,
                  ),
                ),
                // NOM
                SizedBox(
                  width: 250,
                  child: CustomTF(
                    labelText: "Nom",
                    controller: lNameController,
                    context: context,
                    hintText: "Figman",
                    helperText: null,
                    cacher: false,
                  ),
                ),
                // DATE DE NAISSANCE
                CustomEB(
                  text: "Date de naissance",
                  pressed: () async {
                    birthDate = await showDatePicker(
                      context: context,
                      initialDate: birthDate,
                      firstDate: DateTime(1980),
                      lastDate: DateTime.now(),
                    );
                  },
                  context: context,
                ),
                // Bouton Confirmer
                CustomEB(
                  text: "Confirmer",
                  pressed: () => context.read<ProfilEditBloc>().add(
                    SubmitEdits(
                      fNameController.text,
                      lNameController.text,
                      birthDate!,
                      context
                    ),
                  ),
                  context: context,
                ),
                // Bouton retour
                CustomREB(context: context, text: "Retour"),
              ],
            ),
          ),
        );
      },
    );
  }
}
