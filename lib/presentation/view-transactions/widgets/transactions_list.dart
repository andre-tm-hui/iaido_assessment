import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:iaido_test/presentation/view-transactions/widgets/date_label.dart';
import 'package:get/get.dart';
import 'package:iaido_test/common/util.dart';
import 'package:iaido_test/application/transactions_controller.dart';
import 'package:iaido_test/presentation/view-transactions/widgets/transaction_row.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionsController = Get.find<TransactionsController>();
    final transactions = transactionsController.transactions;

    return Obx(() {
      if (transactionsController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (transactionsController.error.isNotEmpty) {
        return Center(child: Text('Error: ${transactionsController.error}'));
      }

      if (transactions.isEmpty) {
        return const Center(child: Text('No transactions yet'));
      }

      final groupedTransactions =
          groupBy(transactions, (t) => getDividerLabel(t.date!));

      List<Widget> slivers = [];

      groupedTransactions.forEach((date, transactions) {
        slivers.add(
          SliverStickyHeader(
            header: DateLabel(label: date),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final transaction = transactions[index];
                  return TransactionRow(
                    payee: transaction.payee,
                    amount: transaction.amount,
                  );
                },
                childCount: transactions.length,
              ),
            ),
          ),
        );
      });

      return RefreshIndicator(
        onRefresh: () async => transactionsController.fetchTransactions(),
        child: CustomScrollView(
          slivers: slivers,
        ),
      );
    });
  }
}
