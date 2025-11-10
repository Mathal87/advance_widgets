// models/transaction.dart

class TransactionModel {
  final String title;
  final String amount;
  final String category;

  const TransactionModel({
    required this.title,
    required this.amount,
    required this.category,
  });
}