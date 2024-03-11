import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:iaido_test/application/balance_controller.dart';
import 'package:iaido_test/data/transactions/transaction_repository.dart';
import 'package:iaido_test/domain/transaction.dart';
import 'package:iaido_test/application/transaction_form_controller.dart';
import 'package:iaido_test/application/transactions_controller.dart';
import 'package:mocktail/mocktail.dart';

class MockTransactionRepository extends GetxService
    with Mock
    implements TransactionRepository {}

class MockBalanceController extends GetxService
    with Mock
    implements BalanceController {}

void main() {
  group('TransactionFormController', () {
    late TransactionsController transactionsController;
    late MockBalanceController balanceController;
    late TransactionFormController controller;
    late MockTransactionRepository mockTransactionRepository;

    setUp(() {
      Get.testMode = true;
      registerFallbackValue(
        Transaction(
            amount: 100, payee: 'John Doe', date: DateTime.now(), id: 0),
      );

      mockTransactionRepository = MockTransactionRepository();
      transactionsController =
          TransactionsController(mockTransactionRepository);
      Get.put(transactionsController);
      balanceController = MockBalanceController();
      Get.put<BalanceController>(balanceController);
      controller = TransactionFormController(isTopUp: true);
      Get.put(controller);
    });

    tearDown(() {
      Get.reset();
    });

    test('Initial state should be correct', () {
      expect(controller.state.value, TransactionFormControllerState.initial);
      expect(controller.error.value, '');
      expect(controller.isAmountValid.value, false);
      expect(controller.isPayeeValid.value, false);
    });

    test('Amount validation should work correctly', () {
      controller.amountController.text = '100';
      controller.amountController.notifyListeners();
      expect(controller.isAmountValid.value, true);

      controller.amountController.text = '';
      controller.amountController.notifyListeners();
      expect(controller.isAmountValid.value, false);
    });

    test('Payee validation should work correctly', () {
      controller.payeeController.text = 'John Doe';
      controller.payeeController.notifyListeners();
      expect(controller.isPayeeValid.value, true);

      controller.payeeController.text = '';
      controller.payeeController.notifyListeners();
      expect(controller.isPayeeValid.value, false);
    });

    test('Pushing a transaction should update state and call repository',
        () async {
      final mockTransaction = Transaction(amount: 100, payee: 'John Doe');

      controller.amountController.text = mockTransaction.amount.toString();

      when(() => mockTransactionRepository.insertTransaction(any())).thenAnswer(
        (_) async => 0,
      );
      when(() => balanceController.addBalance(any())).thenAnswer(
        (invocation) async {},
      );

      await controller.pushTransaction();

      expect(controller.state.value, TransactionFormControllerState.success);
      verify(() => mockTransactionRepository.insertTransaction(any()))
          .called(1);
      verify(() => transactionsController.fetchTransactions())
          .called(2); // 1 from setup, 1 from pushTransaction
    });

    test('Pushing a transaction should handle errors correctly', () async {
      const errorMessage = 'Error occurred';

      controller.amountController.text = '100';
      controller.payeeController.text = 'John Doe';

      when(() => mockTransactionRepository.insertTransaction(any()))
          .thenThrow(errorMessage);

      await controller.pushTransaction();

      expect(controller.state.value, TransactionFormControllerState.error);
      expect(controller.error.value, errorMessage);
    });
  });

  group('TransactionFormController Modes', () {
    late TransactionsController transactionsController;
    late MockBalanceController balanceController;
    late MockTransactionRepository mockTransactionRepository;

    setUp(() {
      registerFallbackValue(
        Transaction(
            amount: 100, payee: 'John Doe', date: DateTime.now(), id: 0),
      );

      mockTransactionRepository = MockTransactionRepository();
      transactionsController =
          TransactionsController(mockTransactionRepository);
      Get.put(transactionsController);
      balanceController = MockBalanceController();
      Get.put<BalanceController>(balanceController);

      when(() => mockTransactionRepository.insertTransaction(any()))
          .thenAnswer((_) async => 0);
      when(() => mockTransactionRepository.getAllTransactions())
          .thenAnswer((_) async => <Transaction>[]);
      when(() => balanceController.addBalance(any())).thenAnswer(
        (invocation) async {},
      );
    });

    tearDown(() {
      Get.reset();
    });

    test(
        'Pushing a transaction should update state and call repository in top up mode',
        () async {
      final controller = TransactionFormController(isTopUp: true);
      Get.put(controller);

      final mockTransaction = Transaction(amount: 100, payee: 'John Doe');

      controller.amountController.text = mockTransaction.amount.toString();

      await controller.pushTransaction();

      expect(controller.state.value, TransactionFormControllerState.success);
      verify(() => mockTransactionRepository.insertTransaction(any()))
          .called(1);
      verify(() => transactionsController.fetchTransactions())
          .called(2); // 1 from setup, 1 from pushTransaction
    });

    test(
        'Pushing a transaction should update state and call repository in pay mode',
        () async {
      final controller = TransactionFormController(isTopUp: false);
      Get.put(controller);

      final mockTransaction = Transaction(amount: 100, payee: 'John Doe');

      controller.amountController.text = mockTransaction.amount.toString();
      controller.payeeController.text = mockTransaction.payee!;

      await controller.pushTransaction();

      expect(controller.state.value, TransactionFormControllerState.success);
      verify(() => mockTransactionRepository.insertTransaction(any()))
          .called(1);
      verify(() => transactionsController.fetchTransactions())
          .called(2); // 1 from setup, 1 from pushTransaction
    });
  });
}
