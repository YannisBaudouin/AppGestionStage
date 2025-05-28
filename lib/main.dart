import 'package:flutter/material.dart';
import 'bottom_nav_bar.dart';
import 'global_var.dart' as global;
import 'init/dark_mode.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login_page.dart';
import 'app_page.dart';

void main() async {
  MaterialApp matApp = MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: global.lightTheme,
      darkTheme: global.darkTheme,
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: LoginPage(),
    );
    
  //runApp(const Main());
  runApp(matApp); 

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseAuth.instance
  .authStateChanges()
  .listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
      Navigator.popUntil(context_!, ModalRoute.withName(Navigator.defaultRouteName));
    } else {
      print('User is signed in!');
      //Navigator.pushNamed(context_! , "/home");

      // Push sur la page application (qui instantie la NavBar) à partir du context de login_page
      Navigator.of(context_!).push(
        MaterialPageRoute(builder: (context) => const AppPage(title: "AppPage")),
      );
    }
  });
}