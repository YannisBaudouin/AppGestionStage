import 'package:flutter/material.dart';

class DarkMode {
  static late bool isDarkMode;
  static late Image currentLogo;
  static init(BuildContext context) {
    isDarkMode = Theme.of(context).brightness == Brightness.dark;

    Image logoNOIR = Image.asset(
      "assets/lyceelogo.png",
    );
    Image logoBLANC = Image.asset(
      "assets/lyceelogoWHITE.png",
    );
    currentLogo = isDarkMode ? logoBLANC : logoNOIR;
  }

  static Image getLogo = currentLogo;

  static bool getDarkMode = isDarkMode;
}
