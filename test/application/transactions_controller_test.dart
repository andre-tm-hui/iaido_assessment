import 'package:flutter_test/flutter_test.dart';
import 'package:iaido_test/data/transactions/transaction_repository.dart';
import 'package:iaido_test/domain/transaction.dart';
import 'package:iaido_test/application/transactions_controller.dart';
import 'package:mocktail/mocktail.dart';

class MockTransactionRepository extends Mock implements TransactionRepository {}

void main() {
  group('TransactionRepository', () {
    late TransactionsController controller;
    late MockTransactionRepository mockRepository;

    setUp(() {
      mockRepository = MockTransactionRepository();
      controller = TransactionsController(mockRepository);
    });

    test('fetchTransactions should update transactions', () async {
      final mockTransactions = [Transaction(amount: 100.00, payee: "John Doe")];

      when(() => mockRepository.getAllTransactions())
          .thenAnswer((_) async => mockTransactions);

      await controller.fetchTransactions();

      expect(controller.transactions, mockTransactions);
      expect(controller.isLoading.value, false);
      expect(controller.error.value, '');
    });

    test('fetchTransactions should set error when repository throws an error',
        () async {
      const errorMessage = 'Failed to fetch transactions';

      when(() => mockRepository.getAllTransactions()).thenThrow(errorMessage);

      controller.fetchTransactions();

      expect(controller.transactions, []);
      expect(controller.isLoading.value, false);
      expect(controller.error.value, errorMessage);
    });
  });
}
