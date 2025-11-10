import 'package:flutter/material.dart';
import '../screens/card_detail_screen.dart'; 

class AtmCard extends StatelessWidget {
  final String bankName;
  final String cardNumber;
  final String balance;
  final Color color1;
  final Color color2;
  final String cardHolderName; // Properti baru

  const AtmCard({
    super.key,
    required this.bankName,
    required this.cardNumber,
    required this.balance,
    required this.color1,
    required this.color2,
    required this.cardHolderName, 
  });

  @override
  Widget build(BuildContext context) {
    // 1. Tambahkan AspectRatio untuk memastikan kartu memiliki rasio lebar:tinggi yang konsisten
    // Rasio standar kartu (sekitar 1.58), kita gunakan 1.6 untuk tampilan modern
    return AspectRatio(
      aspectRatio: 1.6, 
      child: GestureDetector( 
        onTap: () {
          // Navigasi ke detail kartu (hanya placeholder)
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CardDetailScreen(cardTitle: bankName),
            ),
          );
        },
        child: Container(
          // Hapus width: 300; biarkan AspectRatio mengontrol ukuran lebar berdasarkan parent
          margin: const EdgeInsets.only(right: 16),
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
            // Hapus mainAxisSize: MainAxisSize.min; kita ingin Column memenuhi Container.
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
              
              // Jarak
              const SizedBox(height: 12), 
              
              // 2. CHIP ATM
              Container(
                width: 45, 
                height: 25, 
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE0C340), Color(0xFFF2E6B6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
              ),
              
              // 3. SPACER (Mendorong semua elemen di bawah ke dasar kartu)
              // Ini yang menghilangkan overflow vertikal.
              const Spacer(), 
              
              // 4. BALANCE LABEL
              const Text(
                'Current Balance',
                style: TextStyle(color: Colors.white70, fontSize: 13), 
              ),
              
              // 5. BALANCE AMOUNT
              Padding(
                // Tambahkan padding vertikal minimal untuk jarak yang konsisten
                padding: const EdgeInsets.only(top: 2, bottom: 4),
                child: Text(
                  balance,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24, // Font sedikit dinaikkan agar lebih jelas
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              
              // 6. CARD HOLDER NAME (Wrap dengan Flexible)
              // Jika nama terlalu panjang, ia akan otomatis dipotong tanpa overflow
              Flexible( 
                child: Text(
                  cardHolderName.toUpperCase(), 
                  maxLines: 1, // Pastikan hanya satu baris
                  overflow: TextOverflow.ellipsis, // Potong jika terlalu panjang
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14, 
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              
              // Jarak sangat kecil
              const SizedBox(height: 8),

              // 7. CARD NUMBER & ICON
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
      ),
    );
  }
}