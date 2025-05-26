import 'package:flutter/material.dart';
import 'global_var.dart' as global;

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
  double counter = 0.0;

  void _incrementCounter() {
    setState(() {
      counter += 1.0;
    });
  }

  void _decrementCounter() {
    setState(() {
      counter -= 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    Brightness getBrightness() {
      return MediaQuery.of(context).platformBrightness;
    }

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
                  alignment: Alignment.center,
                  height: 100,
                  width: MediaQuery.of(context).size.width / 2,
                  child: const SelectionContainer.disabled(
                    child: Text(
                      textAlign: TextAlign.center,
                      'You have pushed the button this many times:',
                    ),
                  ),
                ),
                Text(
                  '$counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //Bouton plus
                    ElevatedButton(
                      onPressed: () {
                        _incrementCounter();
                      },
                      child: const Icon(Icons.add),
                    ),
                    //Bouton moins
                    ElevatedButton(
                      onPressed: () {
                        _decrementCounter();
                      },
                      child: const Icon(Icons.minimize),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
