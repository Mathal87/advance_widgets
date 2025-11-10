// screens/grid_menu_detail_screen.dart

import 'package:flutter/material.dart';

class GridMenuDetailScreen extends StatelessWidget {
  final String menuTitle;

  const GridMenuDetailScreen({super.key, required this.menuTitle});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Detail: $menuTitle'),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Fitur: $menuTitle',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            const Divider(),
            
            const Text(
              'Masukkan Detail untuk Melanjutkan:',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 15),

            // Simulasi Input Form
            TextField(
              decoration: InputDecoration(
                labelText: 'Jumlah atau Item',
                hintText: 'Misalnya: Rp50.000 atau Nama Produk',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                prefixIcon: Icon(Icons.input, color: primaryColor),
              ),
            ),
            const SizedBox(height: 20),

            // Tombol Utama (Aksi)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Logika untuk mengeksekusi fitur (Beli, Bayar, dll.)
                },
                icon: const Icon(Icons.check_circle),
                label: Text('Laksanakan Aksi $menuTitle'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}