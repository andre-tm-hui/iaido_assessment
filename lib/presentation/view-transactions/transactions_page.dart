import 'package:flutter/material.dart';
import 'package:iaido_test/constants/colors.dart';
import 'package:iaido_test/presentation/view-transactions/widgets/actions_box.dart';
import 'package:iaido_test/presentation/view-transactions/widgets/balance.dart';
import 'package:iaido_test/presentation/view-transactions/widgets/transactions_list.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: accent,
        foregroundColor: foreground,
        title: const Center(child: Text('Dashboard')),
      ),
      body: Container(
        child: Column(
          children: [
            const Balance(),
            const ActionsBox(),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
              alignment: Alignment.centerLeft,
              constraints: const BoxConstraints(maxWidth: 1024),
              child: Text(
                'Recent Activity',
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall,
              ),
            ),
            const Expanded(
              child: TransactionsList(),
            ),
          ],
        ),
      ),
    );
  }
}
