import 'package:flutter/material.dart';
import 'global_var.dart' as global;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  String currentUid = FirebaseAuth.instance.currentUser != null ? FirebaseAuth.instance.currentUser!.uid.toString() : "N/A" ; 
  String currentEmail = FirebaseAuth.instance.currentUser != null ? FirebaseAuth.instance.currentUser!.email.toString() : "N/A" ; 

  Map<String, dynamic>? userData;
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
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    final snapshot = await users.doc(FirebaseAuth.instance.currentUser!.uid).get();
    userData = snapshot.data() as Map<String, dynamic>;
    firstName = userData != null ? userData!["firstName"] : "N/A";
    lastName = userData != null ? userData!["lastName"] : "N/A";

    DateTime now = DateTime.now();
    DateTime birthDate = DateTime.parse(userData!["birthDate"]);
    DateTime dateDifference = DateTime(now.year-birthDate.year, now.month-birthDate.month, now.day-birthDate.day);
    age = dateDifference.year.toString();

    etablissement = userData != null ? userData!["school"].id : "N/A";

    //DocumentReference statutRef = userData!["statut"];
    statut = userData != null ? userData!["statut"].id : "N/A";
    filiere = userData != null ? userData!["sector"].id : "N/A";
    classe = userData != null ? userData!["class"].id : "N/A";

    //print(userData);

    setState(() {
      
    });
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
                Text("UID : " + currentUid),
                Text("Prénom : " + firstName),
                Text("Nom : "+ lastName),
                Text("Age: " + age + " ans"),
                Text("Etablissement : "+ etablissement),
                Text("Status : "+ statut),
                Text("Filière : " + filiere),
                Text("Classe : " + classe),
                Text("Email : " + currentEmail),
              
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
