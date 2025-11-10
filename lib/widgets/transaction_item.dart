// widgets/transaction_item.dart

import 'package:flutter/material.dart';
// Jalur import model harus disesuaikan dengan struktur Anda (kemungkinan '../models/transaction.dart')
import '../models/transaction.dart'; 

// Warna Tema
const Color _primaryTosca = Color(0xFF00A89E); 
const Color _expenseRed = Color(0xFFE57373); 

class TransactionItem extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionItem({super.key, required this.transaction});

  // Helper function untuk menentukan ikon berdasarkan kategori
  IconData _getIconForCategory(String category) {
    // Sesuaikan dengan kategori yang ada di home_screens.dart
    switch (category) {
      case 'Food':
        return Icons.fastfood_rounded;
      case 'Travel':
        return Icons.flight_takeoff_rounded;
      case 'Health':
        return Icons.health_and_safety_rounded;
      case 'Event':
        return Icons.event_note_rounded;
      case 'Income':
        return Icons.account_balance_wallet_rounded;
      default:
        return Icons.local_activity_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Tentukan apakah itu pemasukan atau pengeluaran
    // Kita cek apakah amount diawali dengan '+'
    bool isIncome = transaction.amount.startsWith('+');
    Color amountColor = isIncome ? _primaryTosca : _expenseRed;
    IconData categoryIcon = _getIconForCategory(transaction.category);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        // Shadow tipis agar terasa 'floating'
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // 1. Icon Kategori dengan background pudar
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isIncome ? _primaryTosca.withOpacity(0.1) : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              categoryIcon,
              color: isIncome ? _primaryTosca : Colors.grey.shade700,
              size: 24,
            ),
          ),
          
          const SizedBox(width: 15),

          // 2. Judul dan Kategori
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.grey.shade800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  transaction.category,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          
          // 3. Jumlah (Amount)
          Text(
            transaction.amount,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: amountColor, // Warna sesuai income/expense
            ),
          ),
        ],
      ),
    );
  }
}