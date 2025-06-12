import 'package:flutter/material.dart';
import 'global_var.dart' as global;

class Ressources extends StatefulWidget {
  const Ressources({super.key});

  @override
  State<Ressources> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Ressources> {
  Brightness getBrightness() {
    return MediaQuery.of(context).platformBrightness;
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
                Container(
                  alignment: Alignment.topCenter,
                  color: const Color(0xFF000000),
                  height: MediaQuery.of(context).size.height - 500,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Container(height: 100, color: const Color(0xFFB00A60)),
                      Container(height: 100, color: const Color(0xFFFFEEDD)),
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
