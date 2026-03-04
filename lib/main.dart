import 'package:flutter/material.dart';
import 'routes/appRoutes.dart';
import 'package:flutter_app_docucheck/helpers/themeData.dart';

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
      theme: appTheme,
    );
  }
}
