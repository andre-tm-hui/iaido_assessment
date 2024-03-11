import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:iaido_test/application/balance_controller.dart';
import 'package:iaido_test/presentation/make_transaction/amount_form.dart';
import 'package:iaido_test/application/transactions_controller.dart';
import 'package:iaido_test/presentation/view-transactions/widgets/action_button.dart';
import 'package:iaido_test/presentation/view-transactions/widgets/actions_box.dart';
import 'package:mocktail/mocktail.dart';

class MockTransactionsController extends GetxService
    with Mock
    implements TransactionsController {}

class MockBalanceController extends GetxService
    with Mock
    implements BalanceController {}

void main() {
  group('ActionsBox', () {
    setUp(() {
      Get.put<TransactionsController>(MockTransactionsController());
      Get.put<BalanceController>(MockBalanceController());
    });

    tearDown(() {
      Get.reset();
    });

    testWidgets('renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const GetMaterialApp(
          home: Scaffold(
            body: ActionsBox(),
          ),
        ),
      );

      expect(find.byType(ActionButton), findsNWidgets(2));
    });

    testWidgets('navigates to AmountForm when Pay button is pressed',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const GetMaterialApp(
          home: Scaffold(
            body: ActionsBox(),
          ),
        ),
      );

      await tester.tap(find.text('Pay'));
      await tester.pumpAndSettle();

      expect(find.byType(AmountForm), findsOneWidget);
    });

    testWidgets(
        'navigates to AmountForm with isTopUp set to true when Top up button is pressed',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const GetMaterialApp(
          home: Scaffold(
            body: ActionsBox(),
          ),
        ),
      );

      await tester.tap(find.text('Top up'));
      await tester.pumpAndSettle();

      expect(find.byType(AmountForm), findsOneWidget);
      final amountFormWidget =
          tester.widget<AmountForm>(find.byType(AmountForm));
      expect(amountFormWidget.isTopUp, true);
    });
  });
}
