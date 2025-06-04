import 'package:flutter/material.dart';
import '../global_var.dart' as global;

//ElevationButton classique customiser
class CustomEB extends StatelessWidget {
  final String text;
  final VoidCallback pressed;
  final BuildContext context;
  const CustomEB({
    super.key,
    required this.text,
    required this.pressed,
    required this.context,
  });
  @override
  Widget build(context) {
    return Center(
      child: ElevatedButton(
        onPressed: pressed,
        child: RichText(
          text: TextSpan(
            text: text,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ),
    );
  }
}

//ElevationButton retour customiser
class CustomREB extends StatelessWidget {
  final String text;
  final BuildContext context;
  const CustomREB({super.key, required this.text, required this.context});
  @override
  Widget build(context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: RichText(
          text: TextSpan(
            text: text,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ),
    );
  }
}

//ElevationButton avec un styleform customiser
class CustomEBS extends StatelessWidget {
  final String text;
  final VoidCallback pressed;
  final OutlinedBorder shapeButton;
  final BuildContext context;
  final Color colorDark;
  final Color colorLight;
  const CustomEBS({
    super.key,
    required this.text,
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
    return Center(
      child: ElevatedButton(
        onPressed: pressed,
        style: ElevatedButton.styleFrom(
          shape: shapeButton,
          backgroundColor: isDarkMode ? colorDark : colorLight,
          iconColor: Color(global.commonTheme),
        ),
        child: RichText(
          text: TextSpan(
            text: text,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ),
    );
  }
}

class CustomTB extends StatelessWidget {
  final String text;
  final VoidCallback pressed;
  const CustomTB({super.key, required this.text, required this.pressed});
  @override
  Widget build(context) {
    return Center(
      child: TextButton(
        onPressed: pressed,
        child: RichText(
          text: TextSpan(
            text: text,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ),
    );
  }
}

class CustomRTB extends StatelessWidget {
  final String text;
  const CustomRTB({super.key, required this.text});
  @override
  Widget build(context) {
    return Center(
      child: TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: RichText(
          text: TextSpan(
            text: text,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ),
    );
  }
}
