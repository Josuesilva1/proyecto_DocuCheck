import 'package:flutter/material.dart';
import '../routes/appRoutes.dart';

Drawer buildDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 89, 90, 88),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.verified, color: Colors.blue, size: 50),
              Text(
                'DocuCheck',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Inicio'),
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.menuPrincipal);
          },
        ),
        ListTile(
          leading: const Icon(Icons.camera),
          title: const Text('Captura de Imagen'),
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.capturaImage);
          },
        ),
        ListTile(
          leading: const Icon(Icons.history),
          title: const Text('Historial'),
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.historialVerificaciones);
          },
        ),
        ListTile(
          leading: const Icon(Icons.report),
          title: const Text('Reportes'),
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.reportesPage);
          },
        ),
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text('Acerca De'),
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.acercaDe);
          },
        ),
      ],
    ),
  );
}