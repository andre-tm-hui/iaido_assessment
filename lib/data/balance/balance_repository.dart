import 'package:iaido_test/data/balance/balance_source.dart';

class BalanceRepository {
  final BalanceSource _source;

  BalanceRepository(this._source);

  double getBalance() {
    return _source.amount;
  }

  Future<void> setBalance(double amount) async {
    _source.amount = amount;
  }

  Future<void> addBalance(double amount) async {
    _source.amount += amount;
  }
}
