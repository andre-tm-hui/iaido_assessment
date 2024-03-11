import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';

DatabaseConnection connect() {
  return DatabaseConnection.delayed(Future(() async {
    final result = await WasmDatabase.open(
      databaseName: 'transactions_db',
      sqlite3Uri: Uri.parse('sqlite3.wasm'),
      driftWorkerUri: Uri.parse('drift_worker.dart.js'),
    );

    return result.resolvedExecutor;
  }));
}
