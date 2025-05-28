import 'package:app_gestion_stage/class/pfmp.dart';
//import 'package:app_gestion_stage/init/dark_mode.dart';
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
                            builder: (context) =>
                                const CreaPFMP(title: 'CreationPFMP'),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        backgroundColor: isDarkMode
                            ? Color(global.darkThemePrim)
                            : Color(global.lightThemePrim),
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

class CreaPFMP extends StatefulWidget {
  const CreaPFMP({super.key, required this.title});

  final String title;

  @override
  State<CreaPFMP> createState() => _CreaPFMP();
}

class _CreaPFMP extends State<CreaPFMP> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    DateTime lastDate = DateTime.now();
    DateTime firstDate = DateTime(1980, 1, 1, 0, 0, 0, 0, 0);

    late String nom;
    late String adresse;
    late String statusJur;
    late String nomForma;
    late String contact;
    DateTime dateDeb = DateTime.now();
    DateTime dateFin = DateTime.now();
    DateTimeRange selectedDate = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now(),
    );

    final nomSociete = TextEditingController();
    final adresseSoc = TextEditingController();
    final statusJuri = TextEditingController();
    final nomFormate = TextEditingController();
    final contactFor = TextEditingController();

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
              color: Color(global.darkThemeSeco),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView(
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    text: "Société",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                TextField(
                  controller: nomSociete,
                  decoration: InputDecoration(
                    labelText: "Nom",
                    border: OutlineInputBorder(),
                  ),
                ),
                TextField(
                  controller: adresseSoc,
                  decoration: InputDecoration(
                    labelText: "Adresse",
                    border: OutlineInputBorder(),
                  ),
                ),
                TextField(
                  controller: statusJuri,
                  decoration: InputDecoration(
                    labelText: "Status juridique",
                    border: OutlineInputBorder(),
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
                  controller: nomFormate,
                  decoration: InputDecoration(
                    labelText: "Nom du formateur",
                    border: OutlineInputBorder(),
                  ),
                ),
                TextField(
                  controller: contactFor,
                  decoration: InputDecoration(
                    labelText: "Contact du formateur",
                    border: OutlineInputBorder(),
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
                    onPressed: () async {
                      final DateTimeRange? dateTimeRange =
                          await showDateRangePicker(
                            context: context,
                            firstDate: firstDate,
                            lastDate: lastDate,
                            saveText: "Enregistrer",
                          );
                      if (dateTimeRange != null) {
                        setState(() {
                          selectedDate = dateTimeRange;
                          dateDeb = selectedDate.start;
                          dateFin = selectedDate.end;
                        });
                      }
                    },
                    child: const Text("Selectionner la date"),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              nom = nomSociete.text;
              adresse = adresseSoc.text;
              statusJur = statusJuri.text;
              nomForma = nomFormate.text;
              contact = contactFor.text;
              Pfmp newPFMP = new Pfmp(
                nom,
                adresse,
                statusJur,
                nomForma,
                contact,
                dateDeb,
                dateFin,
              );
              //Navigator.pop(context);
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
