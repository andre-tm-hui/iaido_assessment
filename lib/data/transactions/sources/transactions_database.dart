import 'package:drift/drift.dart';
import 'package:iaido_test/data/transactions/sources/database/shared.dart';
import 'package:iaido_test/constants/initial_data.dart';
import 'package:iaido_test/data/transactions/sources/transactions_dao.dart';
import 'package:iaido_test/domain/transaction.dart';

part 'transactions_database.g.dart';

@UseRowClass(Transaction)
class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get payee => text().nullable().withLength(max: 50)();
  RealColumn get amount => real()();
  DateTimeColumn get date => dateTime()();
}

@DriftDatabase(tables: [Transactions], daos: [TransactionsDao])
class TransactionsDatabase extends _$TransactionsDatabase {
  TransactionsDatabase() : super(connect());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();

          for (Transaction transaction in initialDatabase) {
            await into(transactions).insert(
              TransactionsCompanion.insert(
                payee: Value(transaction.payee),
                amount: transaction.amount,
                date: transaction.date!,
              ),
            );
          }
        },
      );
}
