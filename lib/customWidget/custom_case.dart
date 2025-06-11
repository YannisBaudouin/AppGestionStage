import 'package:flutter/material.dart';
import 'package:app_gestion_stage/global_var.dart' as global;

class CustomETC extends StatelessWidget {
  final Widget enfant;
  final BuildContext context;
  const CustomETC({super.key, required this.enfant, required this.context});
  @override
  Widget build(context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: isDarkMode
                ? Color(global.lightThemePrim)
                : Color(global.darkThemePrim),
          ),
        ),
        child: enfant,
      ),
    );
  }
}
