import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomCheckboxLabel extends StatelessWidget {
  final String? labelText;
  final Function(bool?)? onChanged;
  bool? value;
  bool? tristate;

  CustomCheckboxLabel({
    super.key,
    required this.labelText,
    required this.onChanged,
    this.tristate,
    this.value
  });

  @override
  Widget build(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(tristate: tristate ?? false, value: tristate != true && value == null ? false : value, onChanged: onChanged),
        RichText(
          text: TextSpan(text: labelText),
        ),
      ],
    );
  }
}
