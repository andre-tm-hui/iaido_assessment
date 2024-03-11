import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iaido_test/application/balance_controller.dart';
import 'package:iaido_test/domain/transaction.dart';
import 'package:iaido_test/application/transactions_controller.dart';

enum TransactionFormControllerState { initial, loading, success, error }

class TransactionFormController extends GetxController {
  final TransactionsController transactionsController =
      Get.find<TransactionsController>();
  final BalanceController balanceController = Get.find<BalanceController>();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController payeeController = TextEditingController();

  final bool isTopUp;
  Rx<TransactionFormControllerState> state;
  Rx<String> error;
  Rx<bool> isAmountValid;
  Rx<String> amountError;
  Rx<bool> isPayeeValid;

  TransactionFormController({required this.isTopUp})
      : state = TransactionFormControllerState.initial.obs,
        error = ''.obs,
        isAmountValid = false.obs,
        amountError = ''.obs,
        isPayeeValid = false.obs;

  @override
  void onInit() {
    super.onInit();
    amountController.addListener(() {
      isAmountValid.value = amountController.value.text.isNotEmpty &&
          (!isTopUp
              ? double.parse(amountController.value.text) <
                  balanceController.balance()
              : true);
      amountError.value = !isAmountValid.value &&
              !isTopUp &&
              amountController.value.text.isNotEmpty
          ? 'Insufficient funds'
          : '';
    });
    payeeController.addListener(() {
      isPayeeValid.value = payeeController.value.text.isNotEmpty;
    });
  }

  Future<void> pushTransaction() async {
    try {
      state.value = TransactionFormControllerState.loading;
      double amount = double.parse(amountController.value.text);
      await transactionsController.transactionRepository.insertTransaction(
        Transaction(
          amount: isTopUp ? amount : -amount,
          payee: isTopUp ? null : payeeController.value.text,
        ),
      );
      await balanceController.addBalance(isTopUp ? amount : -amount);
      await transactionsController.fetchTransactions();
      state.value = TransactionFormControllerState.success;
    } catch (e) {
      error.value = e.toString();
      state.value = TransactionFormControllerState.error;
    }
  }
}
