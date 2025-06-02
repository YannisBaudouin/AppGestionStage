import 'package:flutter/material.dart';
import '../global_var.dart' as global;

class CustomEBSI extends StatelessWidget {
  final IconData selectedIcon;
  final String title = 'AppPage';
  final pressed;
  final OutlinedBorder shapeButton;
  final BuildContext context;
  const CustomEBSI({
    super.key,
    required this.selectedIcon,
    required this.pressed,
    required this.shapeButton,
    required this.context,
  });
  @override
  Widget build(context) {
    //Booléen qui change par rapport au thème
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: ElevatedButton(
        onPressed: () {
          pressed;
        },
        style: ElevatedButton.styleFrom(
          shape: shapeButton,
          backgroundColor: isDarkMode
              ? Color(global.darkThemePrim)
              : Color(global.lightThemePrim),
          iconColor: Color(global.commonTheme),
        ),
        child: Icon(selectedIcon, size: 35),
      ),
    );
  }
}
