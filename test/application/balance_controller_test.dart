import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:iaido_test/application/balance_controller.dart';
import 'package:iaido_test/data/balance/balance_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockBalanceRepository extends GetxService
    with Mock
    implements BalanceRepository {}

void main() {
  group('BalanceController', () {
    late MockBalanceRepository repository;
    late BalanceController controller;

    setUp(() {
      repository = MockBalanceRepository();
      controller = BalanceController(repository);
    });

    test('getBalance should return the amount from the source', () {
      when(() => repository.getBalance()).thenReturn(100.00);

      expect(controller.balance, 100.00.obs);
    });

    test('setBalance should set the amount in the source', () {
      when(() => repository.setBalance(100.00)).thenAnswer((_) async {});

      controller.setBalance(100.00);

      verify(() => repository.setBalance(100.00));
    });

    test('addBalance should add the amount to the source', () {
      when(() => repository.addBalance(100.00)).thenAnswer((_) async {});

      controller.addBalance(100.00);

      verify(() => repository.addBalance(100.00));
    });
  });
}
