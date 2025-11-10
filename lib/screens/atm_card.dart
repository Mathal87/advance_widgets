// widgets/atm_card.dart

import 'package:flutter/material.dart';
import '../screens/card_detail_screen.dart'; 

class AtmCard extends StatelessWidget {
  final String bankName;
  final String cardNumber;
  final String balance;
  final Color color1;
  final Color color2;
  // === 1. PROPERTY DITAMBAHKAN ===
  final String cardHolderName; 
  // ===============================

  const AtmCard({
    super.key,
    required this.bankName,
    required this.cardNumber,
    required this.balance,
    required this.color1,
    required this.color2,
    // === 2. ARGUMEN DIMASUKKAN KE CONSTRUCTOR ===
    required this.cardHolderName, 
    // ===========================================
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector( 
      onTap: () {
        // Asumsi CardDetailScreen ada, ini hanya placeholder navigasi
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CardDetailScreen(cardTitle: bankName),
          ),
        );
      },
      child: Container(
        width: 300,
        margin: const EdgeInsets.only(right: 16),
        // Padding disesuaikan agar tidak overflow
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            colors: [color1, color2],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
          boxShadow: [
            BoxShadow(
              color: color1.withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. BANK NAME
            Text(
              bankName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17, 
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 15), 
            
            // 2. CHIP ATM (Diubah sedikit ukurannya)
            Container(
              width: 50,
              height: 30, 
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
                gradient: const LinearGradient(
                  colors: [Color(0xFFE0C340), Color(0xFFF2E6B6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            
            const Spacer(),
            
            // 3. BALANCE LABEL
            const Text(
              'Current Balance',
              style: TextStyle(color: Colors.white70, fontSize: 13),
            ),
            
            // 4. BALANCE AMOUNT
            Text(
              balance,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24, 
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 5), 
            
            // === 3. PROPERTY cardHolderName DITAMPILKAN ===
            Text(
              cardHolderName.toUpperCase(), // Menampilkan nama pemilik
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            // =============================================

            // 5. CARD NUMBER & ICON
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  cardNumber,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16, 
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2,
                  ),
                ),
                Icon(
                  Icons.account_balance_wallet_rounded, 
                  color: Colors.white.withOpacity(0.8),
                  size: 25, 
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}