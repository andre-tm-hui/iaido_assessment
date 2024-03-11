import 'package:iaido_test/data/transactions/sources/transactions_dao.dart';
import 'package:iaido_test/domain/transaction.dart';

class TransactionRepository {
  final TransactionsDao _dao;

  TransactionRepository(this._dao);

  Future<List<Transaction>> getAllTransactions() async {
    return _dao.getAllTransactions();
  }

  Future<int> insertTransaction(Transaction transaction) {
    return _dao.insertTransaction(transaction);
  }

  Future<double> getBalance() async {
    final transactions = await _dao.getAllTransactions();
    return transactions.fold<double>(
        0, (previousValue, element) => previousValue + element.amount);
  }
}
