library;

import 'package:flutter/material.dart';
import 'home_page.dart';
import 'profil_page.dart';
import 'ressources_page.dart';
import 'pfmp_page.dart';
import 'messages_page.dart';
import 'login_page.dart';

//index de départ pour la bar de navigation
int selectedIndex = 2;

//variable qui contiennent les valeurs héxadécimales des couleurs nécessaires pour l'application
const int lightThemePrim = 0xFFF1F1F1;
const int lightThemeSeco = 0xFFFFFFFF;
const int lightThemeText = 0xFF434343;

const int darkThemePrim = 0xFF2B2B2B;
const int darkThemeSeco = 0xFF424242;
const int darkThemeText = 0xFFD3D3D3;

const int commonTheme = 0xFFDC3C3C;
const int commonTheme2 = 0xFFC83333;

// méthode qui renvoie une image basé sur un booléen
Image currentLogo(bool darkMode) {
  Image image;
  darkMode
      ? image = Image.asset('assets/lyceelogoWHITE.png')
      : image = Image.asset('assets/lyceelogo.png');
  return image;
}

//données de couleur pour le mode lumineux
ThemeData lightTheme = ThemeData(
  //décrit les couleurs pour une majorité des éléments pour rapport à leur couche du mode lumineux
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    surface: Color(lightThemePrim),
    onSurface: Color(lightThemeSeco),
    primary: Color(lightThemeSeco),
    onPrimary: Color(lightThemePrim),
    secondary: Color(lightThemePrim),
    onSecondary: Color(lightThemeSeco),
    error: Color(commonTheme),
    onError: Color(commonTheme2),
  ),
  //décrit les couleurs pour les ElevatedButtons du mode lumineux
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(commonTheme),
      iconColor: Color(lightThemeSeco),
    ),
  ),
  //décrit les couleurs pour tous les types d'écritures du mode lumineux
  textTheme: TextTheme(
    titleSmall: TextStyle(color: Color(lightThemeText)),
    titleMedium: TextStyle(color: Color(lightThemeText)),
    titleLarge: TextStyle(color: Color(lightThemeText)),
    headlineSmall: TextStyle(color: Color(lightThemeText)),
    headlineMedium: TextStyle(color: Color(lightThemeText)),
    headlineLarge: TextStyle(color: Color(lightThemeText)),
    bodySmall: TextStyle(color: Color(lightThemeText)),
    bodyMedium: TextStyle(color: Color(lightThemeText)),
    bodyLarge: TextStyle(color: Color(lightThemeText)),
    displaySmall: TextStyle(color: Color(lightThemeText)),
    displayMedium: TextStyle(color: Color(lightThemeText)),
    displayLarge: TextStyle(color: Color(lightThemeText)),
    labelSmall: TextStyle(color: Color(lightThemeText)),
    labelMedium: TextStyle(color: Color(lightThemeText)),
    labelLarge: TextStyle(color: Color(lightThemeText)),
  ),
  //décrit la palette de couleur pour les BoxDecoration pour le mode lumineux
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(color: Color(lightThemeText), fontSize: 20),
    fillColor: Color(lightThemePrim),
    filled: true,
    counterStyle: TextStyle(color: Color(darkThemeText)),
    focusColor: Color(lightThemePrim),
  ),
);
//données de couleur pour le mode sombre
ThemeData darkTheme = ThemeData(
  //décrit les couleurs pour une majorité des éléments pour rapport à leur couche du mode sombre
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    surface: Color(darkThemePrim),
    onSurface: Color(darkThemeSeco),
    primary: Color(darkThemeSeco),
    onPrimary: Color(darkThemePrim),
    secondary: Color(darkThemePrim),
    onSecondary: Color(darkThemeSeco),
    error: Color(commonTheme),
    onError: Color(commonTheme2),
  ),
  //décrit les couleurs pour les ElevatedButtons du mode sombre
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(commonTheme),
      iconColor: Colors.white,
    ),
  ),
  //décrit les couleurs pour tous les types d'écritures du mode sombre
  textTheme: TextTheme(
    titleSmall: TextStyle(color: Color(darkThemeText)),
    titleMedium: TextStyle(color: Color(darkThemeText)),
    titleLarge: TextStyle(color: Color(darkThemeText)),
    headlineSmall: TextStyle(color: Color(darkThemeText)),
    headlineMedium: TextStyle(color: Color(darkThemeText)),
    headlineLarge: TextStyle(color: Color(darkThemeText)),
    bodySmall: TextStyle(color: Color(darkThemeText)),
    bodyMedium: TextStyle(color: Color(darkThemeText)),
    bodyLarge: TextStyle(color: Color(darkThemeText)),
    displaySmall: TextStyle(color: Color(darkThemeText)),
    displayMedium: TextStyle(color: Color(darkThemeText)),
    displayLarge: TextStyle(color: Color(darkThemeText)),
    labelSmall: TextStyle(color: Color(darkThemeText)),
    labelMedium: TextStyle(color: Color(darkThemeText)),
    labelLarge: TextStyle(color: Color(darkThemeText)),
  ),
  //décrit la palette de couleur pour les BoxDecoration pour le mode sombre
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(color: Color(darkThemeText), fontSize: 20),
    fillColor: Color(darkThemePrim),
    filled: true,
    counterStyle: TextStyle(color: Color(darkThemeText)),
    focusColor: Color(darkThemePrim),
  ),
);

//Pages utiliser pour la bar de navigation
const List<Widget> btmPages = [
  PFMP(),
  Ressources(),
  MainScreen(),
  Messages(),
  Profil(),
];
