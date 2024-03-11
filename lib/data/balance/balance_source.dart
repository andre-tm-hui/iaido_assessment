import 'package:iaido_test/data/balance/loader/shared.dart';

class BalanceSource {
  late double _amount;
  double get amount => _amount;
  set amount(value) {
    _amount = value;
    _saveBalance();
  }

  BalanceSource(double amount) {
    _amount = amount;
  }

  Future<void> _saveBalance() async {
    saveBalance(amount);
  }
}
