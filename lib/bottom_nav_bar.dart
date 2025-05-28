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
  void onItemTapped(int index) {
    setState(() {
      global.selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Center(child: global.btmPages.elementAt(global.selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: isDarkMode
                ? Color(global.darkThemeSeco)
                : Color(global.lightThemeSeco),
            activeIcon: Icon(Icons.backpack),
            icon: const Icon(Icons.backpack_outlined),
            label: 'PFMP',
          ),
          BottomNavigationBarItem(
            backgroundColor: isDarkMode
                ? Color(global.darkThemeSeco)
                : Color(global.lightThemeSeco),
            activeIcon: Icon(Icons.file_open),
            icon: Icon(Icons.file_open_outlined),
            label: 'Ressources',
          ),
          BottomNavigationBarItem(
            backgroundColor: isDarkMode
                ? Color(global.darkThemeSeco)
                : Color(global.lightThemeSeco),
            activeIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: isDarkMode
                ? Color(global.darkThemeSeco)
                : Color(global.lightThemeSeco),
            activeIcon: Icon(Icons.messenger),
            icon: Icon(Icons.messenger_outline),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            backgroundColor: isDarkMode
                ? Color(global.darkThemeSeco)
                : Color(global.lightThemeSeco),
            activeIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outline),
            label: 'Profil',
          ),
        ],
        currentIndex: global.selectedIndex,
        selectedItemColor: Color(global.commonTheme),
        unselectedItemColor: Colors.grey,
        onTap: onItemTapped,
        showUnselectedLabels: true,
        elevation: 10,
      ),
    );
  }
}
