import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:iaido_test/application/balance_controller.dart';
import 'package:iaido_test/application/transaction_form_controller.dart';
import 'package:iaido_test/presentation/make_transaction/amount_form.dart';
import 'package:iaido_test/presentation/make_transaction/payee_form.dart';
import 'package:iaido_test/application/transactions_controller.dart';
import 'package:mocktail/mocktail.dart';

class MockTransactionsController extends GetxService
    with Mock
    implements TransactionsController {}

class MockBalanceController extends GetxService
    with Mock
    implements BalanceController {}

void main() {
  group('AmountForm', () {
    late MockTransactionsController transactionController;
    late MockBalanceController balanceController;

    setUp(() {
      transactionController = MockTransactionsController();
      Get.put<TransactionsController>(transactionController);
      balanceController = MockBalanceController();
      Get.put<BalanceController>(balanceController);

      when(() => balanceController.balance).thenReturn(0.00.obs);
    });

    tearDown(() {
      Get.reset();
    });

    testWidgets('should show loading indicator when state is loading',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const GetMaterialApp(
          home: AmountForm(),
        ),
      );

      var controller = Get.find<TransactionFormController>();
      controller.state.value = TransactionFormControllerState.loading;

      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets(
        'should show success snackbar when state is success and isTopUp is true',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const GetMaterialApp(
          home: AmountForm(
            isTopUp: true,
          ),
        ),
      );

      var controller = Get.find<TransactionFormController>();
      controller.state.value = TransactionFormControllerState.success;

      await tester.pump();

      expect(find.text('Success'), findsOneWidget);
      expect(find.text('Transaction made successfully!'), findsOneWidget);
      expect(find.byIcon(Icons.check), findsOneWidget);

      await tester.pumpAndSettle();
    });

    testWidgets('should show error message when state is error',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const GetMaterialApp(
          home: AmountForm(),
        ),
      );

      var controller = Get.find<TransactionFormController>();
      controller.state.value = TransactionFormControllerState.error;
      controller.error.value = 'Some error message';

      await tester.pump();

      expect(find.text('Some error message'), findsOneWidget);
    });

    testWidgets(
        'should call pushTransaction when button is pressed and isTopUp is true',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const GetMaterialApp(
          home: AmountForm(isTopUp: true),
        ),
      );

      var controller = Get.find<TransactionFormController>();
      controller.state.value = TransactionFormControllerState.initial;
      controller.isAmountValid.value = true;

      await tester.pump();

      await tester.tap(find.text('Top up'));
      await tester.pumpAndSettle();

      expect(
        controller.state.value,
        isNot(TransactionFormControllerState.initial),
      );
    });

    testWidgets(
        'should go to PayeeForm when button is pressed and isTopUp is false',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const GetMaterialApp(
          home: AmountForm(isTopUp: false),
        ),
      );

      var controller = Get.find<TransactionFormController>();
      controller.isAmountValid.value = true;

      await tester.pump();

      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();

      expect(find.byType(PayeeForm), findsOneWidget);
    });

    testWidgets(
        'should show error when topUp is false and amountError isn\'t empty',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const GetMaterialApp(
          home: AmountForm(isTopUp: false),
        ),
      );

      var controller = Get.find<TransactionFormController>();
      controller.isAmountValid.value = false;
      controller.amountError.value = 'Insufficient funds';

      await tester.pump();

      expect(find.text('Insufficient funds'), findsOneWidget);
    });
  });
}
