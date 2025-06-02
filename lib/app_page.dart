import 'package:flutter/material.dart';
import 'bottom_nav_bar.dart';

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
