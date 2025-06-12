import 'package:flutter/material.dart';

//Initie un TextField customiser
class CustomTF extends StatelessWidget {
  final String? labelText;
  final TextEditingController controller;
  final BuildContext context;
  final String hintText;
  final String? helperText;
  final bool? cacher;
  final int? maxLines;
  const CustomTF({
    super.key,
    this.labelText,
    required this.controller,
    required this.context,
    required this.hintText,
    this.helperText,
    this.cacher,
    this.maxLines
  });
  @override
  Widget build(context) {
    return Center(
      child: TextField(
        controller: controller,
        maxLines: cacher == true ? 1 : maxLines,
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
        obscureText: cacher ?? false,
      ),
    );
  }
}
