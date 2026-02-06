import 'package:flutter/material.dart';
import '../helpers/menuItems.dart';

class HistorialVerificaciones extends StatefulWidget {
  const HistorialVerificaciones({super.key});

  @override
  State<HistorialVerificaciones> createState() => _HistorialVerificacionesState();
}

class _HistorialVerificacionesState extends State<HistorialVerificaciones> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarService.buildAppBar(
        title: 'Historial de Verificaciones',
        hamburger: true,
        context: context,
      ),
      body: Center(child: Text('Contenido de historial de verificaciones')),
    );
  }
}