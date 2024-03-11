import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iaido_test/common/util.dart';
import 'package:iaido_test/common/widgets/expanding_text_field.dart';
import 'package:iaido_test/common/widgets/submit_button.dart';
import 'package:iaido_test/constants/colors.dart';
import 'package:iaido_test/application/transaction_form_controller.dart';
import 'package:iaido_test/presentation/make_transaction/payee_form.dart';

class AmountForm extends StatelessWidget {
  final bool isTopUp;

  const AmountForm({super.key, this.isTopUp = false});

  @override
  Widget build(BuildContext context) {
    final controller = TransactionFormController(isTopUp: isTopUp);
    Get.put(controller);

    ever(controller.state, (state) {
      if (state == TransactionFormControllerState.success) {
        Get.offAllNamed('/');
        if (isTopUp) {
          Get.snackbar(
            'Success',
            'Transaction made successfully!',
            icon: const Icon(Icons.check),
            backgroundColor: Colors.white,
          );
        }
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(isTopUp ? 'Top Up' : 'Send money'),
        backgroundColor: accent,
        foregroundColor: foreground,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 128),
        child: Obx(() {
          if (controller.state.value ==
              TransactionFormControllerState.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Enter the amount',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  const Text('£'),
                  const SizedBox(width: 4),
                  ExpandingTextField(
                    controller: controller.amountController,
                    style: Theme.of(context).textTheme.headlineMedium,
                    keyboardType: TextInputType.number,
                    inputFormatters: moneyInputFormatter,
                  ),
                ],
              ),
              if (!controller.isAmountValid.value)
                Text(
                  controller.amountError.value,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: warning,
                      ),
                ),
              const SizedBox(height: 16),
              SubmitButton(
                onPressed: controller.isAmountValid.value
                    ? () {
                        isTopUp
                            ? controller.pushTransaction()
                            : Get.to(() => const PayeeForm());
                      }
                    : null,
                text: isTopUp ? 'Top up' : 'Next',
              ),
              if (controller.state.value ==
                  TransactionFormControllerState.error)
                Text(
                  controller.error.value,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: warning,
                      ),
                ),
            ],
          );
        }),
      ),
    );
  }
}
