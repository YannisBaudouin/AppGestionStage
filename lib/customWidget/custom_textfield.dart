import 'package:flutter/material.dart';

//Initie un TextField customiser
class CustomTF extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final BuildContext context;
  final String hintText;
  final String? helperText;
  final bool cacher;
  const CustomTF({
    super.key,
    required this.labelText,
    required this.controller,
    required this.context,
    required this.hintText,
    required this.helperText,
    required this.cacher,
  });
  @override
  Widget build(context) {
    return Center(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
          hint: RichText(
            text: TextSpan(
              text: hintText,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          helperText: helperText,
        ),
        obscureText: cacher,
      ),
    );
  }
}
