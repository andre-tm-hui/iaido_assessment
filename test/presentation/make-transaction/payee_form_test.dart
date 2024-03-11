import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:iaido_test/application/transaction_form_controller.dart';
import 'package:iaido_test/presentation/make_transaction/payee_form.dart';
import 'package:mocktail/mocktail.dart';

class MockTransactionFormController extends GetxService
    with Mock
    implements TransactionFormController {
  @override
  var state = TransactionFormControllerState.initial.obs;
}

void main() {
  group('PayeeForm', () {
    late MockTransactionFormController controller;

    setUp(() {
      controller = MockTransactionFormController();
      Get.put<TransactionFormController>(controller);

      TextEditingController payeeController = TextEditingController();
      payeeController.text = 'John Doe';

      when(() => controller.payeeController).thenAnswer(
        (_) => payeeController,
      );
      when(() => controller.pushTransaction()).thenAnswer((_) async {});
      when(() => controller.isPayeeValid).thenAnswer((_) => true.obs);
    });

    tearDown(() {
      Get.reset();
    });

    testWidgets('should show loading indicator when state is loading',
        (WidgetTester tester) async {
      controller.state.value = TransactionFormControllerState.loading;

      await tester.pumpWidget(
        const GetMaterialApp(
          home: PayeeForm(),
        ),
      );

      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should show success snackbar when state is success',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const GetMaterialApp(
          home: PayeeForm(),
        ),
      );

      controller.state.value = TransactionFormControllerState.success;

      await tester.pump();

      expect(find.text('Success'), findsOneWidget);
      expect(find.text('Transaction made successfully!'), findsOneWidget);
      expect(find.byIcon(Icons.check), findsOneWidget);

      await tester.pumpAndSettle();
    });

    testWidgets('should show error message when state is error',
        (WidgetTester tester) async {
      controller.state.value = TransactionFormControllerState.error;

      when(() => controller.error).thenAnswer(
        (_) => 'Some error message'.obs,
      );
      when(() => controller.isPayeeValid).thenAnswer((_) => true.obs);

      await tester.pumpWidget(
        const GetMaterialApp(
          home: PayeeForm(),
        ),
      );

      expect(find.text('Some error message'), findsOneWidget);
    });

    testWidgets('should call pushTransaction when Send button is pressed',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const GetMaterialApp(
          home: PayeeForm(),
        ),
      );

      await tester.tap(find.text('Send'));
      await tester.pump();

      verify(() => controller.pushTransaction()).called(1);
    });

    testWidgets('send button should be disabled when payee is not valid',
        (WidgetTester tester) async {
      when(() => controller.isPayeeValid).thenAnswer((_) => false.obs);

      await tester.pumpWidget(
        const GetMaterialApp(
          home: PayeeForm(),
        ),
      );

      await tester.tap(find.text('Send'));
      await tester.pump();

      verifyNever(() => controller.pushTransaction());
    });
  });
}
