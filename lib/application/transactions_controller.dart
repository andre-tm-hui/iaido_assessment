import 'package:get/get.dart';
import 'package:iaido_test/data/transactions/transaction_repository.dart';
import 'package:iaido_test/domain/transaction.dart';

class TransactionsController extends GetxController {
  final TransactionRepository transactionRepository;
  RxList<Transaction> transactions;
  Rx<bool> isLoading;
  Rx<String> error;

  TransactionsController(this.transactionRepository)
      : transactions = <Transaction>[].obs,
        isLoading = false.obs,
        error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTransactions();
  }

  Future<void> fetchTransactions() async {
    try {
      isLoading.value = true;
      transactions.value = await transactionRepository.getAllTransactions();
    } catch (e) {
      error.value = 'Failed to fetch transactions';
    } finally {
      isLoading.value = false;
    }
  }
}
