import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;

  SubmitButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      width: double.infinity,
      height: 64,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
