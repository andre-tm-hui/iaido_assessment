import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iaido_test/common/widgets/submit_button.dart';

void main() {
  testWidgets('SubmitButton should call onPressed when pressed',
      (WidgetTester tester) async {
    bool onPressedCalled = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SubmitButton(
            text: 'Submit',
            onPressed: () {
              onPressedCalled = true;
            },
          ),
        ),
      ),
    );

    final submitButtonFinder = find.byType(ElevatedButton);
    expect(submitButtonFinder, findsOneWidget);

    await tester.tap(submitButtonFinder);
    await tester.pump();

    expect(onPressedCalled, true);
  });
}
