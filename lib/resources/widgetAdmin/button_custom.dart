import 'package:flutter/material.dart';

class ButtomCustom extends StatelessWidget {
  const ButtomCustom(
      {super.key,
      required this.text,
      this.onPressed,
      required this.color,
      this.textStyle});

  final String text;
  final Color color;
  final TextStyle? textStyle;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(color)),
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }
}
