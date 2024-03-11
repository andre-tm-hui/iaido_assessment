import 'package:flutter_test/flutter_test.dart';
import 'package:iaido_test/data/transactions/sources/transactions_dao.dart';
import 'package:iaido_test/data/transactions/sources/transactions_database.dart';
import 'package:iaido_test/data/transactions/transaction_repository.dart';
import 'package:iaido_test/domain/transaction.dart';
import 'package:mocktail/mocktail.dart';

class MockTransactionsDao extends Mock implements TransactionsDao {}

class MockTransactionsDatabase extends Mock implements TransactionsDatabase {}

void main() {
  group('TransactionRepository', () {
    late TransactionRepository transactionRepository;
    late MockTransactionsDao mockTransactionsDao;

    setUp(() {
      mockTransactionsDao = MockTransactionsDao();
      transactionRepository = TransactionRepository(mockTransactionsDao);
    });

    test('getAllTransactions should return a list of transactions', () async {
      final transactions = [
        Transaction(id: 1, amount: 10.0),
        Transaction(id: 2, amount: 20.0),
      ];

      when(() => mockTransactionsDao.getAllTransactions()).thenAnswer(
        (_) async => transactions,
      );

      final result = await transactionRepository.getAllTransactions();

      expect(result, transactions);
    });

    test('insertTransaction calls transactionsDao.insertTransaction', () async {
      final transaction = Transaction(id: 1, amount: 10.0);

      when(
        () => mockTransactionsDao.insertTransaction(
          transaction,
        ),
      ).thenAnswer(
        (_) async => 1,
      );

      await transactionRepository.insertTransaction(transaction);

      verify(
        () => mockTransactionsDao.insertTransaction(transaction),
      ).called(1);
    });

    test('getBalance calls transactionsDao.getBalance', () async {
      final transactions = [
        Transaction(id: 1, amount: 10.0),
        Transaction(id: 2, amount: 20.0),
      ];
      when(() => mockTransactionsDao.getAllTransactions())
          .thenAnswer((_) async => transactions);

      final result = await transactionRepository.getBalance();

      expect(result, 30.0);
    });
  });
}
