// screens/home_screens.dart

import 'package:flutter/material.dart';
// Import Layar Fitur Baru
import 'bill_payment_screen.dart'; 
import 'gold_investment_screen.dart'; 

import '../widgets/atm_card.dart'; 
import '../widgets/transaction_item.dart';
import '../models/transaction.dart';
import '../widgets/grid_menu_item.dart'; 

// Definisi Warna Tema (diperlukan untuk warna kartu)
const Color _primaryTosca = Color(0xFF00A89E);
const Color _accentLightBlue = Color(0xFF48D1CC);
const Color _darkTeal = Color(0xFF00796B); 
const Color _darkPurple = Color(0xFF673AB7); 
const Color _indigo = Color(0xFF3F51B5);


// --- STATEFUL WIDGET UNTUK DYNAMIC TRANSACTIONS ---
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Data Transaksi awal
  List<TransactionModel> _transactions = [
    const TransactionModel(title: 'Coffee Shop', amount: '-Rp35.000', category: 'Food'),
    const TransactionModel(title: 'Grab Ride', amount: '-Rp25.000', category: 'Travel'),
    const TransactionModel(title: 'Gaji Bulanan', amount: '+Rp5.000.000', category: 'Income'),
    const TransactionModel(title: 'Gym Membership', amount: '-Rp150.000', category: 'Health'),
    const TransactionModel(title: 'Movie Ticket', amount: '-Rp60.000', category: 'Event'),
  ];

  // FUNGSI CALLBACK: Untuk menambah transaksi baru dari layar lain
  void _addNewTransaction(TransactionModel newTx) {
    setState(() {
      _transactions.insert(0, newTx); // Tambahkan di paling atas
    });
  }

  @override
  Widget build(BuildContext context) {
    // === Nama Pemilik Kartu (sudah benar) ===
    final String cardHolder = 'Mathal Milano Albasyara';

    // Data Kartu ATM (sudah benar mengirim cardHolderName)
    final List<Map<String, dynamic>> atmCards = [
      {'bankName': 'Bank A (Saving)', 'cardNumber': '**** 2345', 'balance': 'Rp12.500.000', 'color1': _primaryTosca, 'color2': _accentLightBlue, 'cardHolderName': cardHolder},
      {'bankName': 'Bank B (Debit)', 'cardNumber': '**** 8765', 'balance': 'Rp5.350.000', 'color1': _darkPurple, 'color2': _indigo, 'cardHolderName': cardHolder},
      {'bankName': 'Wallet Digital', 'cardNumber': '**** 0012', 'balance': 'Rp850.000', 'color1': _darkTeal, 'color2': Colors.teal.shade600, 'cardHolderName': cardHolder},
      {'bankName': 'Credit Card C', 'cardNumber': '**** 9010', 'balance': 'Rp1.200.000', 'color1': Colors.cyan.shade200, 'color2': _accentLightBlue, 'cardHolderName': cardHolder},
    ];

    // Data Grid Menu
    final List<Map<String, dynamic>> menuItems = [
      {'icon': Icons.health_and_safety, 'label': 'Health'},
      {'icon': Icons.travel_explore, 'label': 'Travel'},
      {'icon': Icons.fastfood, 'label': 'Food'},
      {'icon': Icons.event, 'label': 'Event'},
      {'icon': Icons.swap_horiz_rounded, 'label': 'Transfer'},
      {'icon': Icons.account_balance_rounded, 'label': 'Bayar Tagihan'},
      {'icon': Icons.monetization_on_rounded, 'label': 'Beli Emas'},
      {'icon': Icons.more_horiz_rounded, 'label': 'Lainnya'},
    ];


    return Scaffold(
      appBar: AppBar(
        title: const Text('Finance Mate'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== Title =====
            const Text(
              'My Cards',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // ===== Banner Cards (4 Kartu ATM) =====
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: atmCards.length,
                itemBuilder: (context, index) {
                  final card = atmCards[index];
                  return AtmCard(
                    bankName: card['bankName'],
                    cardNumber: card['cardNumber'],
                    balance: card['balance'],
                    color1: card['color1'],
                    color2: card['color2'],
                    // Pemanggilan cardHolderName sudah benar
                    cardHolderName: card['cardHolderName'], 
                  );
                },
              ),
            ),
            
            const SizedBox(height: 20),

            // Tambahan: Action Buttons (Transfer & Emas)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionButton(
                  context,
                  icon: Icons.swap_horiz_rounded,
                  label: 'Transfer/Bayar',
                  destination: BillPaymentScreen(addTransaction: _addNewTransaction), 
                ),
                _buildActionButton(
                  context,
                  icon: Icons.account_balance_rounded,
                  label: 'Investasi Emas',
                  destination: GoldInvestmentScreen(addTransaction: _addNewTransaction),
                ),
              ],
            ),
            
            const SizedBox(height: 24),

            // ===== Grid Menu =====
            GridView.count(
              crossAxisCount: 4, 
              shrinkWrap: true,
              crossAxisSpacing: 10, 
              mainAxisSpacing: 10, 
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 0.8, 
              children: menuItems.map((item) {
                return GridMenuItem(
                  icon: item['icon'],
                  label: item['label'],
                );
              }).toList(),
            ),
            
            const SizedBox(height: 24),

            // ===== Transaction List =====
            const Text(
              'Recent Transactions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Menggunakan State Transaksi
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _transactions.length,
              itemBuilder: (context, index) {
                return TransactionItem(transaction: _transactions[index]);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Helper Widget untuk Tombol Aksi (tidak berubah)
  Widget _buildActionButton(BuildContext context, {required IconData icon, required String label, required Widget destination}) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: primaryColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.3),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(height: 6),
          Text(label, style: TextStyle(fontSize: 12, color: primaryColor)),
        ],
      ),
    );
  }
}