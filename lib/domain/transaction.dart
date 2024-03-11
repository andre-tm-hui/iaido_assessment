class Transaction {
  final int? id;
  final String? payee;
  final double amount;
  final DateTime? date;

  Transaction({
    this.id,
    this.payee,
    required this.amount,
    this.date,
  });
}
