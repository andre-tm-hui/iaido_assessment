import 'package:get/get.dart';
import 'package:iaido_test/data/balance/balance_repository.dart';

class BalanceController extends GetxController {
  final BalanceRepository balanceRepository;

  Rx<double> get balance => balanceRepository.getBalance().obs;

  BalanceController(this.balanceRepository);

  Future<void> setBalance(double amount) async {
    await balanceRepository.setBalance(amount);
  }

  Future<void> addBalance(double amount) async {
    await balanceRepository.addBalance(amount);
  }
}
