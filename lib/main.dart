import 'package:app_gestion_stage/init/LocalNotification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'global_var.dart' as global;
import 'init/auth_user.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login_page.dart';
import 'app_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  AuthUser.init();

  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print("User logged off !");
    } else {
      print("User logged in !");
    }
  });

  await LocalNotification.init();
  LocalNotification.display("Agestage", "Hey! Pense à remplir ton carnet de bord ! 🖐");

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Received message: ${message.notification?.title}');
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print("Notification opened: ${message.notification?.title}");
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
