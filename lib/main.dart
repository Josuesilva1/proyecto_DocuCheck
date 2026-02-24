import 'package:flutter/material.dart';
import 'routes/appRoutes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // RUTAS
      initialRoute: AppRoutes.menuPrincipal,
      routes: AppRoutes.getRoutes(),

      // ===== TEMA GLOBAL DE LA APP =====
      theme: ThemeData(

        // Colores base
        scaffoldBackgroundColor: const Color(0xFFD9DDCD),
        primaryColor: const Color(0xFF1C3166),

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1C3166),
          primary: const Color(0xFF1C3166),
          secondary: const Color(0xFF268FBE),
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),

        // Botones outline
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF1C3166),
            side: const BorderSide(color: Color(0xFF1C3166)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),

        // Cards
        

        // Textos
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Color(0xFF1C3166)),
          titleMedium: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF1C3166),
          ),
        ),
      ),
    );
  }
}


