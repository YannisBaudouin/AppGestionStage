import 'package:flutter/material.dart';

class CustomRT extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final BuildContext context;
  const CustomRT({
    super.key,
    required this.text,
    required this.style,
    required this.context,
  });
  @override
  Widget build(context) {
    return Center(
      child: RichText(
        text: TextSpan(text: text, style: style),
      ),
    );
  }
}
