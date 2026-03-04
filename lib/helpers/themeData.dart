import 'package:flutter/material.dart';

// ===== TEMA GLOBAL DE LA APP =====
final ThemeData appTheme = ThemeData(
  // Colores base
  scaffoldBackgroundColor: const Color(0xFFD9DDCD),
  primaryColor: const Color(0xFF1C3166),

  //estos se utilizaran en el card
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF1C3166),
    primary: const Color(0xFF1C3166),
    secondary: const Color(0xFF268FBE),
    tertiary: const Color.fromARGB(255, 38, 190, 94),
  ),

  // AppBar
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1C3166),
    foregroundColor: Colors.white,
    centerTitle: true,
  ),

  // Botones elevados
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF268FBE),
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),

  // Botones outline
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: const Color(0xFF1C3166),
      side: const BorderSide(color: Color(0xFF1C3166)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  //cards
  cardTheme: const CardThemeData(
    elevation: 4,
    margin: EdgeInsets.all(12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
  ),

  // Textos
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Color(0xFF1C3166)),
    titleMedium: TextStyle(
      fontWeight: FontWeight.bold,
      color: Color(0xFF1C3166),
    ),
  ),
);
