library;

import 'package:flutter/material.dart';
import 'home.dart';
import 'profil.dart';
import 'ressources.dart';
import 'pfmp.dart';
import 'messages.dart';

int selectedIndex = 2;

Image currentLogo(bool darkMode) {
  Image image;
  darkMode
      ? image = Image.asset('assets/lyceelogoWHITE.png')
      : image = Image.asset('assets/lyceelogo.png');
  return image;
}

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: Colors.white,
    onPrimary: Colors.black,
    secondary: Colors.red,
    onSecondary: Colors.black,
    error: Colors.blue,
    onError: Colors.red,
    surface: Colors.white,
    onSurface: Colors.black,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.black,
      iconColor: Colors.red,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
  ),
  textTheme: TextTheme(
      titleLarge: TextStyle(
    color: Colors.black,
  )),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 18),
  ),
);
ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    surface: Colors.black,
    onSurface: Colors.white,
    primary: Colors.white,
    onPrimary: Colors.red,
    secondary: Colors.white,
    onSecondary: Colors.black,
    error: Colors.red,
    onError: Colors.blue,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      iconColor: Colors.red,
    ),
  ),
  textTheme: TextTheme(
    titleLarge: TextStyle(
      color: Colors.white,
    ),
    headlineMedium: TextStyle(
      color: Colors.white,
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black,
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
  ),
);

const List<Widget> btmPages = [
  PFMP(),
  Ressources(),
  MainScreen(),
  Messages(),
  Profil(),
];
