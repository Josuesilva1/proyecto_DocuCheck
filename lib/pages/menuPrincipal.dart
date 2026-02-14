import 'package:flutter/material.dart';
import 'package:flutter_app_docucheck/helpers/doubleBackExit.dart';
import '../helpers/drawer.dart';
import '../helpers/menuItems.dart';
import '../routes/appRoutes.dart';

class MenuPrincipal extends StatelessWidget {
  const MenuPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return DoubleBackExit(
      child: Scaffold(
        appBar: AppBar(title: Text('Menú Principal'), centerTitle: true),
        drawer: buildDrawer(context),
        body: GridView.count(
          crossAxisCount: getCrossAxisCount(context),
          childAspectRatio: getCrossAxisCount(context) == 1 ? 1.55 : 1,
          padding: EdgeInsets.all(12),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            menuItems(
              context,
              Icons.camera_alt,
              'Cámara',
              AppRoutes.capturaImage,
            ),
            menuItems(
              context,
              Icons.data_saver_on,
              "Reportes",
              AppRoutes.reportesPage,
            ),
            menuItems(
              context,
              Icons.history,
              "Historial",
              AppRoutes.historialVerificaciones,
            ),
          ],
        ),
      ),
    );
  }
}
