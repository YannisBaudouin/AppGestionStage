import 'package:app_gestion_stage/class/pfmp.dart';
import 'package:flutter/material.dart';
import 'global_var.dart' as global;

import 'class/appUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  List<Widget> widgetsListPfmps = <Widget>[];

  void updateWidgetsLists() async {
    widgetsListPfmps = <Widget>[];

    AppUser user = await AppUser.retrieve(FirebaseAuth.instance.currentUser!.uid);
    DocumentReference userRef = FirebaseFirestore.instance.collection("users").doc(user.uid);
    CollectionReference pfmpListRef = userRef.collection('pfmp');

    QuerySnapshot snapshot = await pfmpListRef.get();
    List<dynamic> pfmpList = snapshot.docs.map((doc) => doc.data()).toList();
    
    pfmpList.forEach((pfmpObj) {
      Pfmp pfmp = Pfmp('0', pfmpObj["nomSociete"], pfmpObj["nomSociete"], pfmpObj["statusSociete"], pfmpObj["nomFormateur"], pfmpObj["contactFormateur"], pfmpObj['dateDebut'].toDate(), pfmpObj['dateFin'].toDate());

      widgetsListPfmps.add(
        ElevatedButton(child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(pfmp.nomSociete, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          Text(pfmp.dateDebut.toString().split(' ')[0] + "/" + pfmp.dateFin.toString().split(' ')[0], style: TextStyle(color: Colors.white)),
        ],
        ), 
        onPressed: () {
          /*Navigator.push(context, MaterialPageRoute(builder: 
          (context) => EditPFMP(
            title: 'EditPFMP',
              pfmp: pfmp,
            ), // redirection vers la page d'édition de la PFMP
          ),
        );*/
        },
      )
      );
    });

    setState(() {
      
    });
  }

  @override
  void initState() {
    super.initState();
    updateWidgetsLists();
  }

  // page d'accueil des PFMPs
  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Theme.of(context).brightness ==
        Brightness.dark; //Booléen qui change par rapport au thème
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
                global.currentLogo(
                  isDarkMode,
                ), //Utilise le booléen définit plus haut pour changer l'image
                Row(
                  //partie pour ajouter une PFMP
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
                            builder: (context) => const CreaPFMP(
                              title: 'CreationPFMP',
                            ), // redirection vers la page de création d'une PFMP
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        //Modification du style du boutton
                        shape: CircleBorder(),
                        backgroundColor: isDarkMode
                            ? Color(global.darkThemePrim)
                            : Color(global.lightThemePrim),
                        iconColor: Color(global.commonTheme),
                      ),
                      child: Icon(Icons.add_circle_outline, size: 35),
                    ),
                    Column(
                      children: [],
                    )
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    // pour accueillir les futurs PFMP
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height - 500,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: widgetsListPfmps),
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
  //Page de création des PFMPs
  @override
  Widget build(BuildContext context) {
    //Booléen qui change par rapport au thème
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    //Définition des dates pour le calendrier
    DateTime lastDate = DateTime(DateTime.now().year+50, DateTime.now().month, DateTime.now().day);
    DateTime firstDate = DateTime(1980, 1, 1, 0, 0, 0, 0, 0);

    // attribut d'une PFMP en vue de la stockée dans la base de données
    DateTime dateDeb = DateTime.now();
    DateTime dateFin = DateTime.now();

    // date pour définir le début et la fin des dates sélectionner dans le calendrier
    DateTimeRange selectedDate = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now(),
    );

    // Controller pour les champs de saisies
    final nomSociete = TextEditingController();
    final adresseSoc = TextEditingController();
    final statusJuri = TextEditingController();
    final nomFormate = TextEditingController();
    final contactFor = TextEditingController();

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          //Utilise le booléen définit plus haut pour changer l'image
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
            //utiliser pour customiser un Container
            decoration: BoxDecoration(
              //backgroundcolors
              color: Color(global.darkThemeSeco),
              //permet d'arondir le container
              borderRadius: BorderRadius.circular(12),
            ),
            //contient le formulaire pour créer une nouvelle PFMP
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
                    labelText: "Nom", //Le nom qui est affiché dans le champs
                    border:
                        OutlineInputBorder(), //fait en sorte que le nom aille au-dessus du champs lors de la saisie
                  ),
                ),
                TextField(
                  controller: adresseSoc,
                  decoration: InputDecoration(
                    labelText:
                        "Adresse", //Le nom qui est affiché dans le champs
                    border:
                        OutlineInputBorder(), //fait en sorte que le nom aille au-dessus du champs lors de la saisie
                  ),
                ),
                TextField(
                  controller: statusJuri,
                  decoration: InputDecoration(
                    labelText:
                        "Status juridique", //Le nom qui est affiché dans le champs
                    border:
                        OutlineInputBorder(), //fait en sorte que le nom aille au-dessus du champs lors de la saisie
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
                    labelText:
                        "Nom du formateur", //Le nom qui est affiché dans le champs
                    border:
                        OutlineInputBorder(), //fait en sorte que le nom aille au-dessus du champs lors de la saisie
                  ),
                ),
                TextField(
                  controller: contactFor,
                  decoration: InputDecoration(
                    labelText:
                        "Contact du formateur", //Le nom qui est affiché dans le champs
                    border:
                        OutlineInputBorder(), //fait en sorte que le nom aille au-dessus du champs lors de la saisie
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
                    //boutton qui appelle le calendrier
                    onPressed: () async {
                      final DateTimeRange?
                      dateTimeRange = await showDateRangePicker(
                        //le calendrier
                        context: context,
                        firstDate:
                            firstDate, //première date sélectionnable(la plus loin dans le temps)
                        lastDate:
                            lastDate, //dernière date sélectionnable(la plus près dans le temps)
                        saveText:
                            "Enregistrer", //pour modifier l'affichage du boutton qui permet d'enregistrer les dates
                      );
                      if (dateTimeRange != null) {
                        selectedDate = dateTimeRange;
                          dateDeb = selectedDate
                              .start; //affectation de la valeur de début à une varible instancié avant
                          dateFin = selectedDate
                              .end; //affectation de la valeur de début à une varible instancié avant
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
              //Création d'un objet PFMP grâce au varible instancié précédement
              Pfmp newPFMP = new Pfmp(
                "",
                nomSociete.text,
                adresseSoc.text,
                statusJuri.text,
                nomFormate.text,
                contactFor.text,
                dateDeb,
                dateFin,
              );

              newPFMP.create();

              Navigator.pop(context);
              setState(() {});
            },
            child: const Text('Terminer'),
          ),
          ElevatedButton(
            //boutton pour quitter la page
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