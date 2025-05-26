import 'package:flutter/material.dart';
import '../global_var.dart';

class DarkMode {
  static late bool isDarkMode;
  static late Image currentLogo;
  static init() {
    isDarkMode = darkTheme.brightness == lightTheme.brightness ? false : true;
    Image logoNOIR = Image.asset(
      "assets/lyceelogo.png",
      height: 175.0,
      width: 300.0,
    );
    Image logoBLANC = Image.asset(
      "assets/lyceelogoWHITE.png",
      height: 175.0,
      width: 300.0,
    );
    currentLogo = isDarkMode ? logoBLANC : logoNOIR;
  }

  static Image getWhiteLogo = init().logoBLANC;
  static Image getBlackLogo = init().logoNOIR;
  static bool getDarkMode = isDarkMode;
}