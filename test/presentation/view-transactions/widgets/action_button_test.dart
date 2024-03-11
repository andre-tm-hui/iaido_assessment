import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iaido_test/presentation/view-transactions/widgets/action_button.dart';

void main() {
  group('ActionButton', () {
    late Function onPressed;
    late IconData icon;
    late String text;

    setUp(() {
      onPressed = () {};
      icon = Icons.add;
      text = 'Add';
    });

    testWidgets('should display icon and text', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ActionButton(
              text: text,
              onPressed: onPressed,
              icon: icon,
            ),
          ),
        ),
      );

      expect(find.byIcon(icon), findsOneWidget);
      expect(find.text(text), findsOneWidget);
    });

    testWidgets('should display empty icon and text',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ActionButton(
              text: text,
              onPressed: onPressed,
            ),
          ),
        ),
      );

      expect(find.byType(SizedBox), findsOneWidget);
      expect(find.text(text), findsOneWidget);
    });

    testWidgets('should call onPressed when button is pressed',
        (WidgetTester tester) async {
      bool onPressedCalled = false;

      onPressed = () {
        onPressedCalled = true;
      };

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ActionButton(
              text: text,
              onPressed: onPressed,
              icon: icon,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(TextButton));
      await tester.pump();

      expect(onPressedCalled, true);
    });
  });
}
