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
              child: TextField(
                controller: fNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Prénom",
                  hintText: 'Roger',
                ),
              ),
            ),
            // NOM 
            SizedBox(
              width: 250,
              child: TextField(
                controller: lNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Nom",
                  hintText: 'Figman',
                ),
              ),
            ),
            // DATE DE NAISSANCE 
            ElevatedButton(onPressed: () async {
               birthDate = await showDatePicker(
                context: context,
                initialDate: birthDate,
                firstDate: DateTime(1980),
                lastDate: DateTime.now(),
              );
               
            }, child: Text("Date de naissance")),
            // Bouton Confirmer
            ElevatedButton(onPressed: () async {
              user.firstName = fNameController.text;
              user.lastName = lNameController.text;
              user.birthDate = birthDate!;

              user.update();

              Navigator.pop(context);
            }, child: Text("Confirmer")),
            // Bouton retour
            ElevatedButton(onPressed: () {
              Navigator.pop(context);
            }, child: Text("Retour")),
          ],
        ),
      ),
    );
  }
}