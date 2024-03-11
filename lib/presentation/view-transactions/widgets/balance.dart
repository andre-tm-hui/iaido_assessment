import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iaido_test/application/balance_controller.dart';
import 'package:iaido_test/constants/colors.dart';

class Balance extends StatelessWidget {
  const Balance({super.key});

  @override
  Widget build(BuildContext context) {
    final BalanceController controller = Get.find<BalanceController>();

    return Obx(
      () {
        final double balance = controller.balance.value;
        final bool overdrawn = balance < 0;

        return Container(
          decoration: const BoxDecoration(
            color: accent,
          ),
          padding: const EdgeInsets.fromLTRB(16, 36, 16, 48),
          width: double.infinity,
          child: Center(
            child: Column(children: [
              if (overdrawn)
                Text(
                  'You are overdrawn',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: warning,
                      ),
                ),
              Row(
                textBaseline: TextBaseline.alphabetic,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Text(
                    '£',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: overdrawn ? warning : foreground,
                        ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    balance.abs().toStringAsFixed(2),
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: overdrawn ? warning : accentForeground,
                        ),
                  ),
                ],
              ),
            ]),
          ),
        );
      },
    );
  }
}
