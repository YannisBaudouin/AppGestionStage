import 'package:flutter/material.dart';
import '../global_var.dart' as global;

class CustomEB extends StatelessWidget {
  final String text;
  final String title = 'AppPage';
  final direction;
  final BuildContext context;
  const CustomEB({
    super.key,
    required this.text,
    required this.direction,
    required this.context,
  });
  @override
  Widget build(context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => direction(title: title)),
          );
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

class CustomEBS extends StatelessWidget {
  final String text;
  final String title = 'AppPage';
  final direction;
  final shapeButton;
  final BuildContext context;
  const CustomEBS({
    super.key,
    required this.text,
    required this.direction,
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
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => direction(title: title)),
          );
        },
        style: ElevatedButton.styleFrom(
          shape: shapeButton,
          backgroundColor: isDarkMode
              ? Color(global.darkThemePrim)
              : Color(global.lightThemePrim),
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
