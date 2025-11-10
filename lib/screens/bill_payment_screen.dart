// screens/bill_payment_screen.dart

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart'; // Untuk format Rupiah

class BillPaymentScreen extends StatefulWidget {
  final Function(TransactionModel) addTransaction;

  const BillPaymentScreen({super.key, required this.addTransaction});

  @override
  State<BillPaymentScreen> createState() => _BillPaymentScreenState();
}

class _BillPaymentScreenState extends State<BillPaymentScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _accountController = TextEditingController();
  String _selectedNominal = '';
  
  // Nominal Cepat untuk Transfer
  final List<double> _quickNominals = [
    50000, 
    100000, 
    1000000, 
    10000000, 
    100000000
  ];

  @override
  void dispose() {
    _amountController.dispose();
    _accountController.dispose();
    super.dispose();
  }

  // Helper untuk memformat angka menjadi Rupiah (tanpa simbol Rp)
  String _formatNumber(double amount) {
    final formatter = NumberFormat('#,##0', 'id_ID');
    return formatter.format(amount);
  }

  // Fungsi untuk menangani transfer
  void _submitTransfer() {
    final account = _accountController.text;
    final amountText = _amountController.text.replaceAll(RegExp(r'[^\d]'), '');
    final double? amount = double.tryParse(amountText);

    if (account.isEmpty || amount == null || amount <= 0) {
      // Tampilkan dialog error jika input tidak valid
      _showAlertDialog('Input Error', 'Pastikan Anda mengisi nomor rekening dan nominal transfer yang valid.');
      return;
    }

    final formattedAmount = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    ).format(amount);

    // Tambahkan transaksi ke list (sebagai pengeluaran/Debit)
    final newTx = TransactionModel(
      title: 'Transfer ke $account',
      amount: '- $formattedAmount',
      category: 'Transfer',
    );

    widget.addTransaction(newTx);
    
    // Tampilkan dialog sukses
    _showAlertDialog('Transfer Sukses', 'Transfer sebesar $formattedAmount ke rekening $account berhasil!');
    
    // Bersihkan field dan kembali
    _amountController.clear();
    _accountController.clear();
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
        title: const Text('Transfer / Bayar Tagihan'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Detail Transfer',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),

            // Input Nomor Rekening
            TextField(
              controller: _accountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Nomor Rekening Tujuan',
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                prefixIcon: Icon(Icons.account_balance),
              ),
            ),
            const SizedBox(height: 20),

            // Input Nominal Transfer
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                // Logika format mata uang saat diketik (sederhana)
                if (value.isNotEmpty) {
                  final rawValue = value.replaceAll(RegExp(r'[^\d]'), '');
                  final double? number = double.tryParse(rawValue);
                  if (number != null) {
                    final formatted = _formatNumber(number);
                    _amountController.value = TextEditingValue(
                      text: formatted,
                      selection: TextSelection.collapsed(offset: formatted.length),
                    );
                  }
                }
                setState(() {
                  _selectedNominal = ''; // Reset pilihan cepat saat mengetik manual
                });
              },
              decoration: const InputDecoration(
                labelText: 'Nominal Transfer (Rp)',
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                prefixText: 'Rp ',
                prefixIcon: Icon(Icons.money),
              ),
            ),
            const SizedBox(height: 20),

            // === BARU: Opsi Nominal Transfer Cepat ===
            const Text(
              'Pilihan Nominal Cepat',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            
            Wrap(
              spacing: 8.0, // Jarak horizontal
              runSpacing: 8.0, // Jarak vertikal
              children: _quickNominals.map((amount) {
                final formatted = _formatNumber(amount);
                final isSelected = amount == double.tryParse(_amountController.text.replaceAll(RegExp(r'[^\d]'), ''));

                return InkWell(
                  onTap: () {
                    // Isi field input dengan nominal yang dipilih
                    setState(() {
                      final formattedValue = _formatNumber(amount);
                      _amountController.value = TextEditingValue(
                        text: formattedValue,
                        selection: TextSelection.collapsed(offset: formattedValue.length),
                      );
                      _selectedNominal = formattedValue;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? Theme.of(context).primaryColor : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? Theme.of(context).primaryColor : Colors.grey.shade400,
                      ),
                    ),
                    child: Text(
                      formatted,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            // === AKHIR OPSI NOMINAL TRANSFER CEEPAT ===
            
            const SizedBox(height: 30),

            // Tombol Konfirmasi Transfer
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _submitTransfer,
                icon: const Icon(Icons.send_rounded, color: Colors.white),
                label: const Text(
                  'Konfirmasi Transfer',
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