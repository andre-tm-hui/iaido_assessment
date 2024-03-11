import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iaido_test/common/util.dart';
import 'package:iaido_test/common/widgets/expanding_text_field.dart';

void main() {
  group('ExpandingTextField', () {
    testWidgets('Renders correctly', (WidgetTester tester) async {
      final controller = TextEditingController();
      const style = TextStyle(fontSize: 16);
      const keyboardType = TextInputType.text;
      final inputFormatters = moneyInputFormatter;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpandingTextField(
              controller: controller,
              style: style,
              keyboardType: keyboardType,
              inputFormatters: inputFormatters,
            ),
          ),
        ),
      );

      expect(find.byType(ExpandingTextField), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('Updates width when text changes', (WidgetTester tester) async {
      final controller = TextEditingController();
      const style = TextStyle(fontSize: 16);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpandingTextField(
              controller: controller,
              style: style,
            ),
          ),
        ),
      );

      expect(tester.getSize(find.byType(TextField)).width,
          cursorWidth); // minimum width

      controller.text = 'Hello';
      await tester.pump();

      expect(tester.getSize(find.byType(TextField)).width,
          getTextWidth('Hello', style));
    });
  });
}
