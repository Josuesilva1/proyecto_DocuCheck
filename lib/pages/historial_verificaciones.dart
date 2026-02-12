import 'package:flutter/material.dart';
import '../helpers/drawer.dart';

class HistorialVerificaciones extends StatefulWidget {
  const HistorialVerificaciones({super.key});

  @override
  State<HistorialVerificaciones> createState() => _HistorialVerificacionesState();
}

class _HistorialVerificacionesState extends State<HistorialVerificaciones> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menú Principal'),
        centerTitle: true,
      ),
      drawer: buildDrawer(context),
      body: Center(child: Text('Contenido de historial de verificaciones')),
    );
  }
}