import 'package:flutter_test/flutter_test.dart';
import 'package:iaido_test/data/balance/balance_source.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('BalanceSource', () {
    test('amount should be equal to value passed in', () {
      final source = BalanceSource(0.00);

      expect(source.amount, 0.00);
    });

    test('amount should be set to 100.00', () {
      final source = BalanceSource(0.00);
      source.amount = 100.00;

      expect(source.amount, 100.00);
    });
  });
}
