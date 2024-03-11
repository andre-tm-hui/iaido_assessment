import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iaido_test/common/widgets/expanding_text_field.dart';
import 'package:iaido_test/common/widgets/submit_button.dart';
import 'package:iaido_test/constants/colors.dart';
import 'package:iaido_test/application/transaction_form_controller.dart';

class PayeeForm extends StatelessWidget {
  const PayeeForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TransactionFormController>();

    ever(controller.state, (state) {
      if (state == TransactionFormControllerState.success) {
        Get.offAllNamed('/');
        Get.snackbar(
          'Success',
          'Transaction made successfully!',
          icon: const Icon(Icons.check),
          backgroundColor: Colors.white,
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Send money'),
        backgroundColor: accent,
        foregroundColor: foreground,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 128),
        child: Obx(
          () {
            if (controller.state.value ==
                TransactionFormControllerState.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Enter the recipient name',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                const SizedBox(height: 16),
                ExpandingTextField(
                  controller: controller.payeeController,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 16),
                SubmitButton(
                  onPressed: controller.isPayeeValid.value
                      ? () {
                          controller.pushTransaction();
                        }
                      : null,
                  text: 'Send',
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
          },
        ),
      ),
    );
  }
}
