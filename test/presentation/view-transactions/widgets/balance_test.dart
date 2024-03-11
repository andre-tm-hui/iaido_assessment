import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:iaido_test/application/balance_controller.dart';
import 'package:iaido_test/presentation/view-transactions/widgets/balance.dart';
import 'package:mocktail/mocktail.dart';

class MockBalanceController extends GetxService
    with Mock
    implements BalanceController {}

void main() {
  group('Balance Widget', () {
    late MockBalanceController controller;

    setUp(() {
      controller = MockBalanceController();
      Get.put<BalanceController>(controller);

      when(() => controller.balance).thenAnswer((_) => 0.0.obs);
    });

    tearDown(() {
      Get.reset();
    });

    testWidgets('Should display balance correctly',
        (WidgetTester tester) async {
      when(() => controller.balance).thenAnswer((_) => 100.0.obs);

      await tester.pumpWidget(
        const MaterialApp(
          home: Balance(),
        ),
      );

      expect(find.text('100.00'), findsOneWidget);
    });

    testWidgets('Should display overdrawn message when balance is negative',
        (WidgetTester tester) async {
      when(() => controller.balance).thenAnswer((_) => (-50.0).obs);

      await tester.pumpWidget(
        const MaterialApp(
          home: Balance(),
        ),
      );

      expect(find.text('You are overdrawn'), findsOneWidget);
    });
  });
}
