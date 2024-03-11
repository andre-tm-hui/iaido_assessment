import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iaido_test/common/util.dart';

void main() {
  group('getDayDifference', () {
    test('should return the correct day difference', () {
      DateTime date1 = DateTime(2022, 1, 1);
      DateTime date2 = DateTime(2022, 1, 3);
      expect(getDayDifference(date1, date2), -2);
    });
  });

  group('getDividerLabel', () {
    test('should return "TODAY" when the date is today', () {
      DateTime today = DateTime.now();
      expect(getDividerLabel(today), 'TODAY');
    });

    test('should return "YESTERDAY" when the date is yesterday', () {
      DateTime yesterday = DateTime.now().subtract(Duration(days: 1));
      expect(getDividerLabel(yesterday), 'YESTERDAY');
    });

    test(
        'should return the formatted date when the date is not today or yesterday',
        () {
      DateTime date = DateTime(2022, 1, 1);
      expect(getDividerLabel(date), '1 JANUARY');
    });
  });

  group('moneyInputFormatter', () {
    test('should remove leading zeros when the input starts with "0"', () {
      final formatter = moneyInputFormatter[0];
      const oldValue = TextEditingValue(
          text: '0123', selection: TextSelection.collapsed(offset: 4));
      const newValue = TextEditingValue(
          text: '123', selection: TextSelection.collapsed(offset: 3));
      expect(formatter.formatEditUpdate(oldValue, newValue), newValue);
    });

    test('should allow only valid money input', () {
      final formatter = moneyInputFormatter[1];
      const oldValue = TextEditingValue(
          text: '12.34', selection: TextSelection.collapsed(offset: 5));
      const newValue = TextEditingValue(
          text: '12.34', selection: TextSelection.collapsed(offset: 5));
      expect(formatter.formatEditUpdate(oldValue, newValue), newValue);
    });

    test('should add leading zero when the input starts with "."', () {
      final formatter = moneyInputFormatter[2];
      const oldValue = TextEditingValue(
          text: '.12', selection: TextSelection.collapsed(offset: 2));
      const newValue = TextEditingValue(
          text: '0.12', selection: TextSelection.collapsed(offset: 3));
      expect(formatter.formatEditUpdate(oldValue, newValue), newValue);
    });

    test('should not allow more than one decimal point', () {
      final formatter = moneyInputFormatter[2];
      const oldValue = TextEditingValue(
          text: '12.34.56', selection: TextSelection.collapsed(offset: 8));
      const newValue = TextEditingValue(
          text: '12.34.56', selection: TextSelection.collapsed(offset: 8));
      expect(formatter.formatEditUpdate(oldValue, newValue), oldValue);
    });
  });
}
