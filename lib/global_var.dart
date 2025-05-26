library;

import 'package:flutter/material.dart';
import 'home.dart';
import 'profil.dart';
import 'ressources.dart';
import 'pfmp.dart';
import 'messages.dart';

int selectedIndex = 2;

const int lightThemePrim = 0xFFF1F1F1;
const int lightThemeSeco = 0xFFFFFFFF;
const int lightThemeText = 0xFF434343;

const int darkThemePrim = 0xFF2B2B2B;
const int darkThemeSeco = 0xFF424242;
const int darkThemeText = 0xFFD3D3D3;

const int commonTheme = 0xFFDC3C3C;
const int commonTheme2 = 0xFFC83333;

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
    surface: Color(lightThemePrim),
    onSurface: Color(lightThemeSeco),
    primary: Colors.white,
    onPrimary: Colors.black,
    secondary: Color(commonTheme),
    onSecondary: Colors.black,
    error: Colors.blue,
    onError: Color(commonTheme),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(commonTheme),
      iconColor: Color(lightThemeSeco),
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(lightThemeSeco),
  ),
  textTheme: TextTheme(
      titleSmall: TextStyle(
        color: Color(lightThemeText),
      ),
      titleMedium: TextStyle(
        color: Color(lightThemeText),
      ),
      titleLarge: TextStyle(
        color: Color(lightThemeText),
      ),
      headlineSmall: TextStyle(
        color: Color(lightThemeText),
      ),
      headlineMedium: TextStyle(
        color: Color(lightThemeText),
      ),
      headlineLarge: TextStyle(
        color: Color(lightThemeText),
      ),
      bodySmall: TextStyle(
        color: Color(lightThemeText),
      ),
      bodyMedium: TextStyle(
        color: Color(lightThemeText),
      ),
      bodyLarge: TextStyle(
        color: Color(lightThemeText),
      ),
      displaySmall: TextStyle(
        color: Color(lightThemeText),
      ),
      displayMedium: TextStyle(
        color: Color(lightThemeText),
      ),
      displayLarge: TextStyle(
        color: Color(lightThemeText),
      ),
      labelSmall: TextStyle(
        color: Color(lightThemeText),
      ),
      labelMedium: TextStyle(
        color: Color(lightThemeText),
      ),
      labelLarge: TextStyle(
        color: Color(lightThemeText),
      )),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(lightThemeSeco),
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 18),
  ),
);
ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      surface: Color(darkThemePrim),
      onSurface: Color(darkThemeSeco),
      primary: Colors.white,
      onPrimary: Color(commonTheme),
      secondary: Colors.white,
      onSecondary: Colors.black,
      error: Color(commonTheme),
      onError: Colors.blue,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(commonTheme),
        iconColor: Colors.white,
      ),
    ),
    textTheme: TextTheme(
        titleSmall: TextStyle(
          color: Color(darkThemeText),
        ),
        titleMedium: TextStyle(
          color: Color(darkThemeText),
        ),
        titleLarge: TextStyle(
          color: Color(darkThemeText),
        ),
        headlineSmall: TextStyle(
          color: Color(darkThemeText),
        ),
        headlineMedium: TextStyle(
          color: Color(darkThemeText),
        ),
        headlineLarge: TextStyle(
          color: Color(darkThemeText),
        ),
        bodySmall: TextStyle(
          color: Color(darkThemeText),
        ),
        bodyMedium: TextStyle(
          color: Color(darkThemeText),
        ),
        bodyLarge: TextStyle(
          color: Color(darkThemeText),
        ),
        displaySmall: TextStyle(
          color: Color(darkThemeText),
        ),
        displayMedium: TextStyle(
          color: Color(darkThemeText),
        ),
        displayLarge: TextStyle(
          color: Color(darkThemeText),
        ),
        labelSmall: TextStyle(
          color: Color(darkThemeText),
        ),
        labelMedium: TextStyle(
          color: Color(darkThemeText),
        ),
        labelLarge: TextStyle(
          color: Color(darkThemeText),
        )),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(darkThemeSeco),
      titleTextStyle: TextStyle(color: Color(darkThemeText), fontSize: 18),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(darkThemeSeco),
    ));

const List<Widget> btmPages = [
  PFMP(),
  Ressources(),
  MainScreen(),
  Messages(),
  Profil(),
];
