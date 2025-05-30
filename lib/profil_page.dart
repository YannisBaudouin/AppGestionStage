import 'package:flutter/material.dart';
import 'global_var.dart' as global;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'edition_profil_page.dart';
import 'class/appUser.dart';

class Profil extends StatelessWidget {
  const Profil({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test flutter',
      themeMode: ThemeMode.system,
      theme: global.lightTheme,
      darkTheme: global.darkTheme,
      home: const HomePage(title: 'Flutter test Home Page'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Strings qui vont être affichées sur la page.
  String currentUid = FirebaseAuth.instance.currentUser!.uid.toString(); 
  String currentEmail = FirebaseAuth.instance.currentUser!.email.toString(); 
  String firstName = "N/A";
  String lastName = "N/A";
  String age = "N/A";
  String etablissement = "N/A";
  String statut = "N/A";
  String filiere = "N/A";
  String classe = "N/A";

  @override
  void initState(){
    super.initState();
    getData();
  }

  void getData() async {
    // Récupère les infos de l'utilisateur connecté
    AppUser user = await AppUser.retrieve(FirebaseAuth.instance.currentUser!.uid);

    firstName = user.firstName;
    lastName = user.lastName;

    // Fait la différence entre la date d'aujourd'hui et la date de naissance de l'utilisateur
    DateTime now = DateTime.now();
    DateTime birthDate = user.birthDate;
    DateTime dateDifference = DateTime(now.year-birthDate.year, now.month-birthDate.month, now.day-birthDate.day);
    age = dateDifference.year.toString();

    etablissement = user.school;

    statut = user.status;
    filiere = user.sector;
    classe = user.userClass;

    // Actualise la page
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                global.currentLogo(isDarkMode),
                Text("UID : $currentUid"),
                Text("Prénom : $firstName"),
                Text("Nom : $lastName"),
                Text("Age: $age ans"),
                Text("Status : $statut"),
                Text("Etablissement : $etablissement"),
                Text("Filière : $filiere"),
                Text("Classe : $classe"),
                Text("Email : $currentEmail"),
              
                // Bouton Confirmer
                ElevatedButton(onPressed: () async {
                  // Attend que l'utilisateur ferme la page
                  await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const EditionProfilPage(title: "AppPage")),
                  );

                  // Actualise les infos affichées
                  getData();
                }, child: Text("Edition du profil")),
                // Bouton Déconnexion
                ElevatedButton(onPressed: () async {
                 await FirebaseAuth.instance.signOut();
                }, child: Text("Se déconnecter")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
