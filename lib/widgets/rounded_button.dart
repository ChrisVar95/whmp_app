import 'package:flutter/material.dart';

import '../app/core/values/colors.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {super.key,
      required this.textString,
      required this.buttonFunction,
      this.background = kPurpleDark});

  final String textString;
  final Color background;
  //TODO
  final VoidCallback buttonFunction;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            backgroundColor: background,
          ),
          onPressed: buttonFunction,
          child: Text(textString)),
    );
  }
}
