import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iaido_test/constants/colors.dart';
import 'package:iaido_test/presentation/view-transactions/widgets/transaction_row.dart';

void main() {
  group('TransactionRow', () {
    testWidgets('should display payee name', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TransactionRow(
              payee: 'John Doe',
              amount: 100.0,
            ),
          ),
        ),
      );

      expect(find.text('John Doe'), findsOneWidget);
    });

    testWidgets('should display top-up text if payee is null',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TransactionRow(
              payee: null,
              amount: 100.0,
            ),
          ),
        ),
      );

      expect(find.text('Top Up'), findsOneWidget);
    });

    testWidgets('should display positive amount in accent color',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TransactionRow(
              payee: 'John Doe',
              amount: 100.0,
            ),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.byType(Text).last);
      expect(textWidget.style?.color, equals(accent));
    });

    testWidgets('should display negative amount in black color',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TransactionRow(
              payee: 'John Doe',
              amount: -100.0,
            ),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.byType(Text).last);
      expect(textWidget.style?.color, equals(Colors.black));
    });
  });
}
