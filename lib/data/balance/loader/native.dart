import 'dart:io';

import 'package:iaido_test/constants/initial_data.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

Future<double> getInitialBalance() async {
  final dir = await getApplicationDocumentsDirectory();
  final file = File(p.join(dir.path, 'balance.txt'));

  try {
    final content = await file.readAsString();
    return double.parse(content);
  } catch (e) {
    return initialBalance;
  }
}

Future<void> saveBalance(double amount) async {
  final dir = await getApplicationDocumentsDirectory();
  final file = File(p.join(dir.path, 'balance.txt'));

  await file.writeAsString(amount.toString());
}
