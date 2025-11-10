// screens/card_detail_screen.dart

import 'package:flutter/material.dart';

class CardDetailScreen extends StatelessWidget {
  final String cardTitle;

  const CardDetailScreen({super.key, required this.cardTitle});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Kartu: $cardTitle'),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Saldo Besar (Simulasi)
            Center(
              child: Text(
                'Rp12.500.000', // Mock Balance
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Center(
              child: Text('Saldo Tersedia', style: TextStyle(color: Colors.grey)),
            ),
            
            const Divider(height: 40),

            // Bagian Tombol Aksi
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionChip(primaryColor, Icons.swap_horiz, 'Transfer'),
                _buildActionChip(primaryColor, Icons.settings, 'Atur Kartu'),
                _buildActionChip(primaryColor, Icons.lock_open, 'Blokir Sementara'),
              ],
            ),
            
            const Divider(height: 40),

            // Riwayat Singkat (Simulasi)
            Text(
              'Riwayat 30 Hari Terakhir',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey.shade700),
            ),
            const SizedBox(height: 10),
            
            // Item Riwayat Mockup
            const ListTile(
              leading: Icon(Icons.shopping_cart, color: Colors.redAccent),
              title: Text('Pembelian Online'),
              trailing: Text('-Rp350.000', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent)),
            ),
            const ListTile(
              leading: Icon(Icons.atm, color: Colors.green),
              title: Text('Penarikan Tunai'),
              trailing: Text('-Rp500.000', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent)),
            ),

          ],
        ),
      ),
    );
  }
  
  // Widget Pembantu untuk Chip Aksi
  Widget _buildActionChip(Color color, IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        const SizedBox(height: 5),
        Text(label, style: TextStyle(fontSize: 12, color: color)),
      ],
    );
  }
}