import 'package:flutter/material.dart';
import 'global_var.dart' as global;
import 'package:firebase_auth/firebase_auth.dart';

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
