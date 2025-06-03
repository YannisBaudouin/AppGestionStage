import 'customWidget/custom_textfield.dart';
import 'customWidget/custom_buttons.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'class/appUser.dart';

class EditionProfilPage extends StatefulWidget {
  const EditionProfilPage({super.key, required this.title});

  final String title;

  @override
  State<EditionProfilPage> createState() => EditionProfilPageState();
}

class EditionProfilPageState extends State<EditionProfilPage> {
  final TextEditingController fNameController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();
  DateTime? birthDate;

  late AppUser user;

  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    user = await AppUser.retrieve(FirebaseAuth.instance.currentUser!.uid);

    fNameController.text = user.firstName;
    lNameController.text = user.lastName;
    birthDate = user.birthDate;
  }

  @override
  Widget build(BuildContext context) {
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
              pressed: () async {
                user.firstName = fNameController.text;
                user.lastName = lNameController.text;
                user.birthDate = birthDate!;

                user.update();

                Navigator.pop(context);
              },
              context: context,
            ),
            // Bouton retour
            CustomREB(context: context, text: "Retour"),
          ],
        ),
      ),
    );
  }
}
