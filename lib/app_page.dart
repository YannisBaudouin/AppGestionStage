import 'package:flutter/material.dart';
import 'bottom_nav_bar.dart';
import 'global_var.dart' as global;
import 'init/dark_mode.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login_page.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key, required this.title});

  final String title;

  @override
  State<AppPage> createState() => AppPageState();
}

class AppPageState extends State<AppPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        BottomNavBar(
          title: 'navbar',
        ),
      ],
    ));
  }

}
