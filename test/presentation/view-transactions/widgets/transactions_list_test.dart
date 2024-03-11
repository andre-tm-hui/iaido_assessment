import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:iaido_test/common/util.dart';
import 'package:iaido_test/domain/transaction.dart';
import 'package:iaido_test/application/transactions_controller.dart';
import 'package:iaido_test/presentation/view-transactions/widgets/date_label.dart';
import 'package:iaido_test/presentation/view-transactions/widgets/transaction_row.dart';
import 'package:iaido_test/presentation/view-transactions/widgets/transactions_list.dart';
import 'package:mocktail/mocktail.dart';

class MockTransactionsController extends GetxService
    with Mock
    implements TransactionsController {}

void main() {
  group('TransactionsList', () {
    late MockTransactionsController transactionsController;

    setUp(() {
      transactionsController = MockTransactionsController();
      Get.put<TransactionsController>(transactionsController);

      when(() => transactionsController.error).thenAnswer((_) => ''.obs);
      when(() => transactionsController.isLoading).thenAnswer((_) => false.obs);
      when(() => transactionsController.transactions).thenAnswer(
        (_) => <Transaction>[].obs,
      );
    });

    tearDown(() {
      Get.reset();
    });

    testWidgets('should show CircularProgressIndicator when loading',
        (WidgetTester tester) async {
      when(() => transactionsController.isLoading).thenAnswer((_) => true.obs);

      await tester.pumpWidget(const MaterialApp(home: TransactionsList()));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should show error message when there is an error',
        (WidgetTester tester) async {
      const error = 'Some error message';
      when(() => transactionsController.error).thenAnswer((_) => error.obs);

      await tester.pumpWidget(const MaterialApp(home: TransactionsList()));

      expect(find.text('Error: $error'), findsOneWidget);
    });

    testWidgets('should show "No transactions yet" when transactions is empty',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: TransactionsList()));

      expect(find.text('No transactions yet'), findsOneWidget);
    });

    testWidgets('should show transactions grouped by date',
        (WidgetTester tester) async {
      List<Transaction> transactions = [
        Transaction(date: DateTime.now(), payee: 'Payee 1', amount: 10),
        Transaction(date: DateTime.now(), payee: 'Payee 2', amount: 20),
        Transaction(
          date: DateTime.now().subtract(const Duration(days: 1)),
          payee: 'Payee 3',
          amount: 30,
        ),
        Transaction(
          date: DateTime.now().subtract(const Duration(days: 2)),
          payee: 'Payee 4',
          amount: 40,
        ),
      ];

      transactions.sort((a, b) => b.date!.compareTo(a.date!));

      when(() => transactionsController.transactions).thenAnswer(
        (_) => transactions.obs,
      );

      await tester.pumpWidget(const MaterialApp(home: TransactionsList()));

      expect(find.byType(DateLabel), findsNWidgets(3));
      expect(find.text('TODAY'), findsOneWidget);
      expect(find.text('YESTERDAY'), findsOneWidget);
      expect(find.text(getDividerLabel(transactions[3].date!)), findsOneWidget);

      expect(find.byType(TransactionRow), findsNWidgets(4));
    });

    testWidgets('drag down to refresh', (WidgetTester tester) async {
      List<Transaction> transactions = [
        Transaction(date: DateTime.now(), payee: 'Payee 1', amount: 10),
      ];

      when(() => transactionsController.transactions).thenAnswer(
        (_) => transactions.obs,
      );

      when(() => transactionsController.fetchTransactions()).thenAnswer(
        (_) async {},
      );

      await tester.pumpWidget(const MaterialApp(home: TransactionsList()));

      await tester.drag(find.byType(TransactionsList), const Offset(0, 300));

      await tester.pumpAndSettle();

      verify(() => transactionsController.fetchTransactions()).called(1);
    });
  });
}
