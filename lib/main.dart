import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iaido_test/application/balance_controller.dart';
import 'package:iaido_test/constants/theme.dart';
import 'package:iaido_test/data/balance/balance_repository.dart';
import 'package:iaido_test/data/balance/balance_source.dart';
import 'package:iaido_test/data/balance/loader/shared.dart';
import 'package:iaido_test/data/transactions/sources/transactions_database.dart';
import 'package:iaido_test/data/transactions/transaction_repository.dart';
import 'package:iaido_test/application/transactions_controller.dart';
import 'package:iaido_test/presentation/view-transactions/transactions_page.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'iaido Wallet',
      theme: themeData,
      home: FutureBuilder(
        future: getInitialBalance(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          final database = TransactionsDatabase();
          final repository = TransactionRepository(database.transactionsDao);

          Get.put(TransactionsController(repository));

          Get.put(
            BalanceController(
              BalanceRepository(
                BalanceSource(snapshot.data!),
              ),
            ),
          );

          return const TransactionsPage();
        },
      ),
    );
  }
}
