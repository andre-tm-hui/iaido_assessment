import 'package:drift/drift.dart';
import 'package:iaido_test/data/transactions/sources/transactions_database.dart';
import 'package:iaido_test/domain/transaction.dart';

part 'transactions_dao.g.dart';

@DriftAccessor(tables: [Transactions])
class TransactionsDao extends DatabaseAccessor<TransactionsDatabase>
    with _$TransactionsDaoMixin {
  TransactionsDao(super.db);

  Future<List<Transaction>> getAllTransactions() => (select(transactions)
        ..orderBy(
          [
            (t) => OrderingTerm(
                  expression: t.date,
                  mode: OrderingMode.desc,
                )
          ],
        ))
      .get();

  Future<int> insertTransaction(Transaction transaction) async =>
      await into(transactions).insert(
        TransactionsCompanion.insert(
          payee: Value(transaction.payee),
          amount: transaction.amount,
          date: transaction.date ?? DateTime.now(),
        ),
      );
}
