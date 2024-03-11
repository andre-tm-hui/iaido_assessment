import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:iaido_test/application/balance_controller.dart';
import 'package:iaido_test/domain/transaction.dart';
import 'package:iaido_test/application/transactions_controller.dart';
import 'package:iaido_test/presentation/view-transactions/transactions_page.dart';
import 'package:iaido_test/presentation/view-transactions/widgets/actions_box.dart';
import 'package:iaido_test/presentation/view-transactions/widgets/balance.dart';
import 'package:iaido_test/presentation/view-transactions/widgets/transactions_list.dart';
import 'package:mocktail/mocktail.dart';

class MockTransactionsController extends GetxService
    with Mock
    implements TransactionsController {}

class MockBalanceController extends GetxService
    with Mock
    implements BalanceController {}

void main() {
  testWidgets('TransactionsPage should render correctly',
      (WidgetTester tester) async {
    TestWidgetsFlutterBinding.ensureInitialized();
    MockTransactionsController transactionsController =
        MockTransactionsController();
    Get.put<TransactionsController>(transactionsController);
    MockBalanceController balanceController = MockBalanceController();
    Get.put<BalanceController>(balanceController);

    when(() => balanceController.balance).thenReturn(0.0.obs);
    when(() => transactionsController.transactions).thenReturn(
      <Transaction>[].obs,
    );
    when(() => transactionsController.isLoading).thenReturn(false.obs);
    when(() => transactionsController.error).thenReturn(''.obs);

    await tester.pumpWidget(const GetMaterialApp(home: TransactionsPage()));

    expect(find.text('Dashboard'), findsOneWidget);

    expect(find.byType(Balance), findsOneWidget);

    expect(find.byType(ActionsBox), findsOneWidget);

    expect(find.text('Recent Activity'), findsOneWidget);

    expect(find.byType(TransactionsList), findsOneWidget);

    Get.reset();
  });
}
