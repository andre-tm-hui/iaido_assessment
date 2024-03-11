import 'package:flutter/material.dart';
import 'package:iaido_test/constants/colors.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final IconData? icon;
  final double iconSize = 56;

  const ActionButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onPressed(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon != null
              ? Icon(icon, size: iconSize, color: accent)
              : SizedBox(width: iconSize, height: iconSize),
          Text(text),
        ],
      ),
    );
  }
}
