// main.dart

import 'package:flutter/material.dart';
// MENGGUNAKAN NAMA PACKAGE: finance_m
import 'package:finance_m/screens/splash_screen.dart'; 

// Definisi Warna Tosca Kustom
const Color _primaryTosca = Color(0xFF00A89E); // Tosca yang adem
const Color _accentLightBlue = Color(0xFF48D1CC); // Warna Aksen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finance Mate',
      debugShowCheckedModeBanner: false, 
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: _primaryTosca,
          primary: _primaryTosca,
          secondary: _accentLightBlue,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: Colors.grey.shade50,
        appBarTheme: const AppBarTheme(
          backgroundColor: _primaryTosca,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}