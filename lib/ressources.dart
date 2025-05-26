import 'package:flutter/material.dart';
import 'global_var.dart' as global;
import 'init/dark_mode.dart';

class Ressources extends StatelessWidget {
  const Ressources({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agestage',
      themeMode: ThemeMode.system,
      theme: global.lightTheme,
      darkTheme: global.darkTheme,
      home: const MyHomePage(title: 'Agestage'),
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
  Brightness getBrightness() {
    return MediaQuery.of(context).platformBrightness;
  }

  @override
  Widget build(BuildContext context) {
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
                getBrightness() == global.darkTheme.brightness
                    ? DarkMode.getBlackLogo
                    : DarkMode.getWhiteLogo,
                Container(
                  alignment: Alignment.topCenter,
                  color: const Color(0xFF000000),
                  height: MediaQuery.of(context).size.height - 500,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Container(
                        height: 100,
                        color: const Color(0xFFB00A60),
                      ),
                      Container(
                        height: 100,
                        color: const Color(0xFFFFEEDD),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
