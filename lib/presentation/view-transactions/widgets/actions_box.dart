import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iaido_test/constants/colors.dart';
import 'package:iaido_test/presentation/make_transaction/amount_form.dart';
import 'package:iaido_test/presentation/view-transactions/widgets/action_button.dart';

class ActionsBox extends StatelessWidget {
  final double padding = 16;
  final double height = 100;

  const ActionsBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
                width: double.infinity,
                height: height / 2,
                decoration: const BoxDecoration(color: accent)),
            SizedBox(width: double.infinity, height: height / 2),
          ],
        ),
        Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 512),
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: padding),
            padding: const EdgeInsets.symmetric(horizontal: 48),
            width: double.infinity,
            height: height,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ActionButton(
                  icon: Icons.shopping_cart_checkout,
                  text: 'Pay',
                  onPressed: () {
                    Get.to(
                      () => const AmountForm(),
                    );
                  },
                ),
                ActionButton(
                  icon: Icons.wallet,
                  text: 'Top up',
                  onPressed: () {
                    Get.to(
                      () => const AmountForm(isTopUp: true),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
