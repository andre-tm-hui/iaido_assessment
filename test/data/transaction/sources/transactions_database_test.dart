import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iaido_test/constants/initial_data.dart';
import 'package:iaido_test/data/transactions/sources/transactions_database.dart';
import 'package:iaido_test/domain/transaction.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final database = TransactionsDatabase();

  group('TransactionsDatabase and DAO', skip: true, () {
    test('Insert transaction', () {
      final transaction =
          Transaction(payee: 'Test', amount: 100.00, date: DateTime.now());

      database.transactionsDao.insertTransaction(
        transaction,
      );

      database.select(database.transactions).get().then((transactions) {
        expect(transactions.length, 1 + initialDatabase.length);
      });
    });

    test('Get all transactions', () {
      for (int i = 0; i < 5; i++) {
        database.transactionsDao.insertTransaction(
          Transaction(
            amount: 100.0,
            date: DateTime.now().add(
              Duration(days: i),
            ),
          ),
        );
      }

      database.transactionsDao.getAllTransactions().then((transactions) {
        expect(
          transactions.length,
          5 + 1 + initialDatabase.length,
        ); // +1 accounting for the previous test
        for (int i = 0; i < 4; i++) {
          expect(
            transactions[i].date!.microsecondsSinceEpoch -
                    transactions[i + 1].date!.microsecondsSinceEpoch >=
                0,
            true,
          );
        }
      });
    });
  });
}
