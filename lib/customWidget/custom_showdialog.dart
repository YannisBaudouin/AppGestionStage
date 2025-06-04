import 'package:flutter/material.dart';

void customShowDialog(
  BuildContext context,
  String title,
  String content,
  List<Widget> action,
  //Map<String, VoidCallback> options
) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: RichText(
        text: TextSpan(
          text: title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      content: RichText(
        text: TextSpan(
          text: content,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      actions: action,
    ),
  );
}
