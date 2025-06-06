import 'package:flutter/material.dart';
import '../global_var.dart' as global;

//ElevationButton avec un styleform et une icône customiser
class CustomEBSI extends StatelessWidget {
  final IconData selectedIcon;
  final VoidCallback? pressed;
  final OutlinedBorder shapeButton;
  final BuildContext context;
  final Color colorDark;
  final Color colorLight;
  const CustomEBSI({
    super.key,
    required this.selectedIcon,
    required this.pressed,
    required this.shapeButton,
    required this.context,
    required this.colorDark,
    required this.colorLight,
  });
  @override
  Widget build(context) {
    //Booléen qui change par rapport au thème
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    ThemeData dataTheme = isDarkMode ? global.darkTheme : global.lightTheme;
    ThemeData() = dataTheme;
    return Center(
      child: ElevatedButton(
        onPressed: pressed,
        style: ElevatedButton.styleFrom(
          shape: shapeButton,
          backgroundColor: isDarkMode ? colorDark : colorLight,
          iconColor: Color(global.commonTheme),
        ),
        child: Icon(selectedIcon, size: 35),
      ),
    );
  }
}

//ElevationButton.icon customiser
class CustomEBI extends StatelessWidget {
  final String labelText;
  final IconData selectedIcon;
  final VoidCallback pressed;
  final BuildContext context;
  const CustomEBI({
    super.key,
    required this.labelText,
    required this.selectedIcon,
    required this.pressed,
    required this.context,
  });
  @override
  Widget build(context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    ThemeData dataTheme = isDarkMode ? global.darkTheme : global.lightTheme;
    ThemeData() = dataTheme;
    return Center(
      child: ElevatedButton.icon(
        onPressed: pressed,
        label: RichText(
          text: TextSpan(
            text: labelText,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        icon: Icon(selectedIcon),
        iconAlignment: IconAlignment.end,
      ),
    );
  }
}

class CustomTBI extends StatelessWidget {
  final String text;
  final VoidCallback pressed;
  final IconData selectedIcon;
  const CustomTBI({
    super.key,
    required this.text,
    required this.pressed,
    required this.selectedIcon,
  });
  @override
  Widget build(context) {
    return Center(
      child: TextButton.icon(
        onPressed: pressed,
        icon: Icon(selectedIcon, size: 35, color: Color(global.commonTheme)),
        iconAlignment: IconAlignment.end,
        label: RichText(
          text: TextSpan(
            text: text,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
    );
  }
}
