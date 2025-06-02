import 'package:app_gestion_stage/profil_page.dart';
import 'package:flutter/material.dart';
import 'global_var.dart' as global;

import 'bottom_nav_bar.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'mailConnexion.dart';
import 'mailInscription.dart';
import 'app_page.dart';

// Exporte le context de la page (💀💀💀💀)
BuildContext? context_;

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    context_ = context;

    return MaterialApp(
      title: 'Agestage',
      themeMode: ThemeMode.system,
      theme: global.lightTheme,
      darkTheme: global.darkTheme,
      home: const MyHomePage(title: 'Agestage'),
      initialRoute: '/',
      routes: {
      '/inscription': (context) => const MailInscriptionPage(title: "test"),
      '/connexion': (context) => const MailConnexionPage(title: "test"),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
                ElevatedButton(onPressed: () { Navigator.pushNamed(context, '/connexion'); }, child: Text("Se connecter avec une adresse Mail")),
                ElevatedButton(onPressed: () { Navigator.pushNamed(context, '/inscription'); }, child: Text("S'inscrire avec une adresse Mail"))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
