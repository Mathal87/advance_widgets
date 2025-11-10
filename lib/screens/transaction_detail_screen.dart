// screens/transaction_detail_screen.dart

import 'package:flutter/material.dart';
import '../models/transaction.dart'; 

class TransactionDetailScreen extends StatelessWidget {
  final TransactionModel transaction; 

  const TransactionDetailScreen({super.key, required this.transaction});

  // ... (buildDetailRow Widget tetap sama)

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    bool isIncome = transaction.amount.startsWith('+');
    Color amountColor = isIncome ? primaryColor : Colors.red.shade400;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Transaksi'),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                transaction.amount,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: amountColor,
                ),
              ),
            ),
            const Divider(height: 30),
            
            // Detail Transaksi
            _buildDetailRow('Keterangan', transaction.title),
            _buildDetailRow('Kategori', transaction.category),
            _buildDetailRow('Tipe', isIncome ? 'Pemasukan' : 'Pengeluaran'),
            _buildDetailRow('Tanggal & Waktu', '08 Nov 2025, 14:00 WIB'),
            _buildDetailRow('Lokasi/Sumber', isIncome ? 'Bank A (Transfer)' : 'Coffee Shop X'),

            const SizedBox(height: 40),

            // Tombol Edit/Download
            Center(
              child: Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // Logika untuk mengedit/mendownload bukti
                    },
                    icon: const Icon(Icons.file_download),
                    label: const Text('Unduh Bukti Transaksi'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15)
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}