import 'package:flutter/material.dart';
import '../pages/menuPrincipal.dart';
import '../pages/capturaPage.dart';

class AppRoutes {
  static const String menuPrincipal = '/menuPrincipal';
  static const String capturaImage = '/capturaPage';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      menuPrincipal: (context) => const MenuPrincipal(),
      capturaImage: (context) => const CapturaPage(),
    };
  }
}