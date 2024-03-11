import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

int getDayDifference(DateTime date1, DateTime date2) {
  date1 = DateTime(date1.year, date1.month, date1.day);
  date2 = DateTime(date2.year, date2.month, date2.day);
  return date1.difference(date2).inDays;
}

String getDividerLabel(DateTime date) {
  String dividerLabel;
  switch (getDayDifference(DateTime.now(), date)) {
    case 0:
      dividerLabel = 'TODAY';
      break;
    case 1:
      dividerLabel = 'YESTERDAY';
      break;
    default:
      dividerLabel = DateFormat('d MMMM').format(date).toUpperCase();
  }
  return dividerLabel;
}

List<TextInputFormatter> moneyInputFormatter = [
  TextInputFormatter.withFunction((oldValue, newValue) {
    if (newValue.text.startsWith('0') &&
        newValue.text.length > 1 &&
        newValue.text[1] != '.') {
      return TextEditingValue(
        text: newValue.text.substring(1),
        selection: newValue.selection.copyWith(
          baseOffset: newValue.selection.start - 1,
          extentOffset: newValue.selection.end - 1,
        ),
      );
    }
    return newValue;
  }),
  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
  TextInputFormatter.withFunction((oldValue, newValue) {
    if (newValue.text.startsWith('.')) {
      return TextEditingValue(
        text: '0${newValue.text}',
        selection: newValue.selection.copyWith(
          baseOffset: newValue.selection.start + 1,
          extentOffset: newValue.selection.end + 1,
        ),
      );
    } else if (newValue.text.split('.').length - 1 > 1) {
      return oldValue;
    }
    return newValue;
  }),
];
