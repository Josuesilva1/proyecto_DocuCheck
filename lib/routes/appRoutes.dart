import 'package:flutter/material.dart';
import '../pages/menuPrincipal.dart';
import '../pages/capturaPage.dart';
import '../pages/reportes.dart';
import '../pages/historial_verificaciones.dart';
import '../pages/acercaDe.dart';

class AppRoutes {
  static const String menuPrincipal = '/menuPrincipal';
  static const String capturaImage = '/capturaPage';
  static const String reportesPage = '/reportesPage';
  static const String historialVerificaciones = '/historialVerificaciones';
  static const String acercaDe = '/acercaDe';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      menuPrincipal: (context) => const MenuPrincipal(),
      capturaImage: (context) => const CapturaPage(),
      reportesPage: (context) => const ReportesPage(),
      historialVerificaciones: (context) => const HistorialVerificaciones(),
      acercaDe: (context) => const Acercade(),
    };
  }
}