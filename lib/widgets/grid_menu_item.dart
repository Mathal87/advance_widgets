// widgets/grid_menu_item.dart

import 'package:flutter/material.dart';
// GANTI import '../screens/transaction_detail_screen.dart'; 
// DENGAN:

import '../screens/grid_menu_detail_screen.dart'; // Import layar detail khusus Grid Menu

// Warna Tema Tosca (untuk konsistensi)
const Color _primaryTosca = Color(0xFF00A89E); 

class GridMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const GridMenuItem({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, 
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          // LOGIKA NAVIGASI MENGGUNAKAN LAYAR BARU
          Navigator.push(
            context,
            MaterialPageRoute(
              // MENGGUNAKAN GridMenuDetailScreen YANG HANYA MEMINTA 'menuTitle' (label)
              builder: (context) => GridMenuDetailScreen(menuTitle: label), 
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _primaryTosca.withOpacity(0.15), 
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 30,
                  color: _primaryTosca, 
                ),
              ),
              const SizedBox(height: 10),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}