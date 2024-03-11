import 'package:flutter/material.dart';

class DateLabel extends StatelessWidget {
  final String label;

  const DateLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      alignment: Alignment.centerLeft,
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1024),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ),
    );
  }
}
