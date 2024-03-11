import 'package:iaido_test/domain/transaction.dart';

List<Transaction> initialDatabase = [
  Transaction(amount: -32.00, date: DateTime.now(), payee: 'eBay'),
  Transaction(amount: -65.00, date: DateTime.now(), payee: 'Merton Council'),
  Transaction(amount: 150.00, date: DateTime.now()),
  Transaction(
    amount: -32.00,
    date: DateTime.now().subtract(const Duration(days: 1)),
    payee: 'Amazon',
  ),
  Transaction(
    amount: -1400.00,
    date: DateTime.now().subtract(const Duration(days: 1)),
    payee: 'John Snow',
  ),
  Transaction(
    amount: -200.00,
    date: DateTime.now().subtract(const Duration(days: 1)),
  ),
];

const double initialBalance = 150.25;
