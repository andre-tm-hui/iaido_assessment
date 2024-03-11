import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// default is 2.0, but for some reason it's not accurate
const cursorWidth = 3.0;

double getTextWidth(text, textStyle) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: textStyle),
    textDirection: TextDirection.ltr,
  )..layout(minWidth: 0, maxWidth: double.infinity);
  return textPainter.width + cursorWidth;
}

class ExpandingTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextStyle? style;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const ExpandingTextField({
    super.key,
    required this.controller,
    this.style,
    this.keyboardType,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (BuildContext context, TextEditingValue value, Widget? child) {
        return Container(
          width: getTextWidth(value.text, style),
          constraints: const BoxConstraints(
            minWidth: cursorWidth,
          ),
          child: TextField(
              controller: controller,
              autofocus: true,
              textAlign: TextAlign.right,
              style: style,
              keyboardType: keyboardType,
              inputFormatters: inputFormatters,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              )),
        );
      },
    );
  }
}
