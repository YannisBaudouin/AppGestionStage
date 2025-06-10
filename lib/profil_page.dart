import 'package:flutter/material.dart';
import 'package:app_gestion_stage/global_var.dart' as global;
import 'package:app_gestion_stage/customWidget/custom_widget.dart';
import 'profilInfos/profil_infos.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test flutter',
      themeMode: ThemeMode.system,
      theme: global.lightTheme,
      darkTheme: global.darkTheme,
      home: const PageProfil(),
    );
  }
}

class PageProfil extends StatefulWidget {
  const PageProfil({super.key});

  @override
  State<PageProfil> createState() => ProfilHome();
}

class ProfilHome extends State<PageProfil> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Column(
        children: <Widget>[
          global.currentLogo(isDarkMode),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 150,
              height: MediaQuery.of(context).size.height / 2,
              margin: EdgeInsets.only(top: 75),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? Color(global.darkThemeSeco)
                    : Color(global.lightThemeSeco),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CustomEBI(
                    labelText: "Profil",
                    selectedIcon: Icons.arrow_forward_ios,
                    pressed: () {
                      // redirection vers la page d'aperçu du profil
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfilInfosPage(),
                        ),
                      );
                    },
                    context: context,
                  ),
                  Divider(
                    height: 10,
                    thickness: 5,
                    indent: 20,
                    endIndent: 20,
                    color: Color(global.darkThemePrim),
                  ),
                  CustomEBI(
                    labelText: "Informations",
                    selectedIcon: Icons.arrow_forward_ios,
                    context: context,
                    pressed: () {},
                  ),
                  Divider(
                    height: 10,
                    thickness: 5,
                    indent: 20,
                    endIndent: 20,
                    color: Color(global.darkThemePrim),
                  ),
                  CustomEBI(
                    labelText: "Mentions Légales",
                    selectedIcon: Icons.arrow_forward_ios,
                    pressed: () {},
                    context: context,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
