import 'package:flutter/material.dart';
import 'global_var.dart' as global;

/*
class BottomNavBarPage extends StatelessWidget {
  const BottomNavBarPage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agestage',
      themeMode: ThemeMode.system,
      theme: global.lightTheme,
      darkTheme: global.darkTheme,
      home: const BottomNavBar(title: 'Agestage'),
    );
  }
}*/

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key, required this.title});

  final String title;

  @override
  State<BottomNavBar> createState() => BottomBar();
}

class BottomBar extends State<BottomNavBar> {
  //fonction qui permet de changer d'index et donc de page affichée
  void onItemTapped(int index) {
    setState(() {
      global.selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Booléen qui change par rapport au thème
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Center(child: global.btmPages.elementAt(global.selectedIndex)),
      //initialisation de la bar de navigation
      bottomNavigationBar: BottomNavigationBar(
        //personnalisation des items contenu dans la bar de navigation
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            //Changement de la couleur de fond pour rapport au thème
            backgroundColor: isDarkMode
                ? Color(global.darkThemeSeco)
                : Color(global.lightThemeSeco),
            //Icône utilisé quand l'utilisateur est sur la page
            activeIcon: Icon(Icons.backpack),
            //Icône utilisé quand l'utilisateur n'est pas sur la page
            icon: const Icon(Icons.backpack_outlined),
            //Nom affiché sur l'icône
            label: 'PFMP',
          ),
          BottomNavigationBarItem(
            //Changement de la couleur de fond pour rapport au thème
            backgroundColor: isDarkMode
                ? Color(global.darkThemeSeco)
                : Color(global.lightThemeSeco),
            //Icône utilisé quand l'utilisateur est sur la page
            activeIcon: Icon(Icons.file_open),
            //Icône utilisé quand l'utilisateur n'est pas sur la page
            icon: Icon(Icons.file_open_outlined),
            //Nom affiché sur l'icône
            label: 'Ressources',
          ),
          BottomNavigationBarItem(
            //Changement de la couleur de fond pour rapport au thème
            backgroundColor: isDarkMode
                ? Color(global.darkThemeSeco)
                : Color(global.lightThemeSeco),
            //Icône utilisé quand l'utilisateur est sur la page
            activeIcon: Icon(Icons.home),
            //Icône utilisé quand l'utilisateur n'est pas sur la page
            icon: Icon(Icons.home_outlined),
            //Nom affiché sur l'icône
            label: 'Home',
          ),
          BottomNavigationBarItem(
            //Changement de la couleur de fond pour rapport au thème
            backgroundColor: isDarkMode
                ? Color(global.darkThemeSeco)
                : Color(global.lightThemeSeco),
            //Icône utilisé quand l'utilisateur est sur la page
            activeIcon: Icon(Icons.messenger),
            //Icône utilisé quand l'utilisateur n'est pas sur la page
            icon: Icon(Icons.messenger_outline),
            //Nom affiché sur l'icône
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            //Changement de la couleur de fond pour rapport au thème
            backgroundColor: isDarkMode
                ? Color(global.darkThemeSeco)
                : Color(global.lightThemeSeco),
            //Icône utilisé quand l'utilisateur est sur la page
            activeIcon: Icon(Icons.person),
            //Icône utilisé quand l'utilisateur n'est pas sur la page
            icon: Icon(Icons.person_outline),
            //Nom affiché sur l'icône
            label: 'Profil',
          ),
        ],
        //définit l'index que la bar utilise quand elle est instancié dans l'application
        currentIndex: global.selectedIndex,
        //Couleur de l'icône quand il est sélectionner ou pas
        selectedItemColor: Color(global.commonTheme),
        unselectedItemColor: Colors.grey,
        //appelle la fonction pour changer de page
        onTap: onItemTapped,
        //permet d'afficher les labels des pages non sélectionner
        showUnselectedLabels: true,
        elevation: 10,
      ),
    );
  }
}
