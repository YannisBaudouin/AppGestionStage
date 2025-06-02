import 'package:flutter/material.dart';
import 'global_var.dart' as global;

import 'mailConnexion.dart';
import 'mailInscription.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
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
