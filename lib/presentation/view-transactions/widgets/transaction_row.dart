import 'package:flutter/material.dart';
import 'package:iaido_test/constants/colors.dart';

class TransactionRow extends StatelessWidget {
  final String? payee;
  final double amount;
  final bool isTopUp;
  late final TextStyle amountTextStyle;

  TransactionRow({
    super.key,
    this.payee,
    required this.amount,
  }) : isTopUp = amount > 0 {
    amountTextStyle = TextStyle(
      color: isTopUp ? accent : Colors.black,
      fontWeight: isTopUp ? FontWeight.w400 : FontWeight.w300,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: foreground,
      width: double.infinity,
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1024),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: accent,
                ),
                padding: const EdgeInsets.all(2),
                child: Icon(
                  isTopUp
                      ? Icons.add_circle_outline
                      : Icons.shopping_bag_outlined,
                  color: foreground,
                  size: 20,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                payee ?? 'Top Up',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const Expanded(child: SizedBox.shrink()),
              Row(
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Text(
                    '${isTopUp ? '+' : ''}${amount.abs().floor().toStringAsFixed(0)}.',
                    style: amountTextStyle.copyWith(fontSize: 24),
                  ),
                  Text(
                    (amount.abs() - amount.abs().floor())
                        .toStringAsFixed(2)
                        .substring(2),
                    style: amountTextStyle.copyWith(fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
