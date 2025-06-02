import 'package:flutter/material.dart';
import 'global_var.dart' as global;
import 'init/auth_user.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login_page.dart';
import 'app_page.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  AuthUser.init();

  FirebaseAuth.instance
    .authStateChanges()
    .listen((User? user) {
    if (user == null) {
      print("User logged off !");
    } else {
      print("User logged in !");
    }
  });
  
  runApp(MainPage()); 
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: global.lightTheme,
      darkTheme: global.darkTheme,
      home: AuthUser.user == null ? LoginPage() : AppPage(title: "AppPage"),
    );
  }
}