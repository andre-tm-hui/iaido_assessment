import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iaido_test/presentation/view-transactions/widgets/date_label.dart';

void main() {
  testWidgets('DateLabel displays the correct label',
      (WidgetTester tester) async {
    const String label = '2022-01-01';

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: DateLabel(label: label),
        ),
      ),
    );

    expect(find.text(label), findsOneWidget);
  });
}
