import 'package:app_gestion_stage/init/dark_mode.dart';
import 'package:flutter/material.dart';
import 'global_var.dart' as global;

class PFMP extends StatelessWidget {
  const PFMP({super.key});

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                global.currentLogo(isDarkMode),
                Row(
                  children: <Widget>[
                    RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: 'Mes PFMP',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SecondRoute(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        backgroundColor: DarkMode.getDarkMode
                            ? Color(global.lightThemePrim)
                            : Color(global.darkThemePrim),
                        iconColor: Color(global.commonTheme),
                      ),
                      child: Icon(Icons.add_circle_outline, size: 35),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height - 500,
                        width: MediaQuery.of(context).size.width,
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

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    DateTime lastDate = DateTime.now();
    DateTime firstDate = DateTime(1980, 1, 1, 0, 0, 0, 0, 0);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          global.currentLogo(isDarkMode),
          RichText(
            text: TextSpan(
              text: 'Nouvelle PFMP',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            width: MediaQuery.of(context).size.width - 50,
            height: MediaQuery.of(context).size.width / 1.30,
            decoration: BoxDecoration(
              //color: Color(global.darkThemeSeco),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView(
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    text: "Société",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Nom",
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(fontSize: 20),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Adresse",
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(fontSize: 20),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Status juridique",
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(fontSize: 20),
                  ),
                ),
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    text: "Formateur",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Nom du formateur",
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(fontSize: 20),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Contact du formateur",
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(fontSize: 20),
                  ),
                ),
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    text: "Période",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: ElevatedButton(
                    onPressed: () => showDateRangePicker(
                      context: context,
                      firstDate: firstDate,
                      lastDate: lastDate,
                    ),
                    child: const Text("Selectionner la date"),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Terminer'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Retour'),
          ),
        ],
      ),
    );
  }
}
