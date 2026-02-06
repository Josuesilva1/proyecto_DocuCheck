import 'package:flutter/material.dart';
import '../helpers/menuItems.dart';
import '../routes/appRoutes.dart';

class MenuPrincipal extends StatelessWidget {
  const MenuPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Validador de Documentos'),
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          menuItems(context, Icons.camera_alt, 'Cámara', AppRoutes.capturaImage),
          /*enuItems(context, Icons.data_exploration, "Reporte", () {}),
          menuItems(context, Icons.history, "Historial", () {}),*/
          //menuItems(context, Icons.camera_alt, "Cámara", AppRoutes.capturaImage),
          menuItems(context, Icons.data_exploration, "Reporte", AppRoutes.capturaImage),
          menuItems(context, Icons.history, "Historial", AppRoutes.capturaImage),
        ],
      ),
    );
  }
}