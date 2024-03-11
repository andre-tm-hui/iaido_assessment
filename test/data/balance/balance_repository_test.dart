import 'package:flutter_test/flutter_test.dart';
import 'package:iaido_test/data/balance/balance_repository.dart';
import 'package:iaido_test/data/balance/balance_source.dart';
import 'package:mocktail/mocktail.dart';

class MockBalanceSource extends Mock implements BalanceSource {}

void main() {
  group('BalanceRepository', () {
    late MockBalanceSource source;
    late BalanceRepository repository;

    setUp(() {
      source = MockBalanceSource();
      repository = BalanceRepository(source);
    });

    test('getBalance should return the amount from the source', () {
      when(() => source.amount).thenReturn(100.00);

      expect(repository.getBalance(), 100.00);
    });

    test('setBalance should set the amount in the source', () async {
      await repository.setBalance(100.00);

      verify(() => source.amount = 100.00);
    });

    test('addBalance should add the amount to the source', () async {
      when(() => source.amount).thenReturn(0.00);

      await repository.addBalance(100.00);

      verify(() => source.amount += 100.00);
    });
  });
}
