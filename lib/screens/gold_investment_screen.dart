// screens/gold_investment_screen.dart

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart'; 

class GoldInvestmentScreen extends StatefulWidget {
  final Function(TransactionModel) addTransaction;

  const GoldInvestmentScreen({super.key, required this.addTransaction});

  @override
  State<GoldInvestmentScreen> createState() => _GoldInvestmentScreenState();
}

class _GoldInvestmentScreenState extends State<GoldInvestmentScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _goldGramController = TextEditingController();
  
  // Harga emas per gram (placeholder)
  final double _goldPricePerGram = 1150000; 

  @override
  void dispose() {
    _amountController.dispose();
    _goldGramController.dispose();
    super.dispose();
  }

  // Helper untuk memformat angka menjadi Rupiah (tanpa simbol Rp)
  String _formatNumber(double amount) {
    final formatter = NumberFormat('#,##0', 'id_ID');
    return formatter.format(amount);
  }

  // Fungsi untuk simulasi pembelian
  void _buyGold() {
    final amountText = _amountController.text.replaceAll(RegExp(r'[^\d]'), '');
    final double? amount = double.tryParse(amountText);
    
    if (amount == null || amount <= 0) {
      _showAlertDialog('Input Error', 'Pastikan Anda mengisi nominal pembelian yang valid.');
      return;
    }

    final purchasedGram = amount / _goldPricePerGram;
    
    final formattedAmount = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    ).format(amount);
    
    // Tambahkan transaksi ke list
    final newTx = TransactionModel(
      title: 'Beli Emas (${purchasedGram.toStringAsFixed(3)} gr)',
      amount: '- $formattedAmount',
      category: 'Investment',
    );

    widget.addTransaction(newTx);
    
    _showAlertDialog('Pembelian Sukses', 'Anda berhasil membeli emas senilai $formattedAmount (${purchasedGram.toStringAsFixed(3)} gram)!');
    
    _amountController.clear();
    _goldGramController.clear();
    Navigator.of(context).pop();
  }

  void _showAlertDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Investasi Emas Digital'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Beli Emas Sekarang',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.amber.shade300),
              ),
              child: Text(
                'Harga Emas hari ini: Rp${_formatNumber(_goldPricePerGram)} / gram (data placeholder)',
                style: TextStyle(color: Colors.amber.shade800, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),

            // Input Nominal Pembelian
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                // Sederhana: update gram berdasarkan nominal
                final rawValue = value.replaceAll(RegExp(r'[^\d]'), '');
                final double? number = double.tryParse(rawValue);
                if (number != null) {
                  final formatted = _formatNumber(number);
                  _amountController.value = TextEditingValue(
                    text: formatted,
                    selection: TextSelection.collapsed(offset: formatted.length),
                  );
                  // Update gram
                  final gram = number / _goldPricePerGram;
                  _goldGramController.text = '${gram.toStringAsFixed(4)} gram';
                } else {
                  _goldGramController.text = '';
                }
              },
              decoration: const InputDecoration(
                labelText: 'Nominal Pembelian (Rp)',
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                prefixText: 'Rp ',
                prefixIcon: Icon(Icons.monetization_on),
              ),
            ),
            const SizedBox(height: 15),

            // Display Jumlah Gram
            TextField(
              controller: _goldGramController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Estimasi Emas Didapatkan',
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                prefixIcon: Icon(Icons.scale),
              ),
            ),

            const SizedBox(height: 30),

            // Tombol Konfirmasi Pembelian
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _buyGold,
                icon: const Icon(Icons.attach_money_rounded, color: Colors.white),
                label: const Text(
                  'Beli Emas Sekarang',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}