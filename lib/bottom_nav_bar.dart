import 'package:flutter/material.dart';
import 'global_var.dart' as global;


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
}

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key, required this.title});

  final String title;

  @override
  State<BottomNavBar> createState() => BottomBar();
}

class BottomBar extends State<BottomNavBar> {
  void onItemTapped(int index) {
    setState(() {
      global.selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: global.btmPages.elementAt(global.selectedIndex)),
        bottomNavigationBar: BottomNavigationBar(          
          //backgroundColor: global.isDarkMode ? Colors.white : Colors.black,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.backpack_outlined),
              label: 'PFMP',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.file_open_outlined),
              label: 'Ressources',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.messenger_outlined),
              label: 'Messages',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profil',
            ),
          ],
          currentIndex: global.selectedIndex,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey,
          onTap: onItemTapped,
        ),
    );
  }
}
