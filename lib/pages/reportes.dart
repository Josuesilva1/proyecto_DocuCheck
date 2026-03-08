import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../helpers/drawer.dart';
import '../services/verificacion_service.dart';
import '../models/verificacion_model.dart';
import '../routes/appRoutes.dart';

class ReportesPage extends StatefulWidget {
  const ReportesPage({super.key});

  @override
  State<ReportesPage> createState() => _ReportesPageState();
}

class _ReportesPageState extends State<ReportesPage> {
  final VerificacionService _listadodiario = VerificacionService();
  List<VerificacionModel> reporte = [];
  String resumen = '';

  // Genera el resumen del reporte usando los datos de la base para el dia
  Future<void> generarReporte() async {
    final datos = await _listadodiario.obtenerVerificacionesDelDia();

    setState(() {
      reporte = datos;

      final total = reporte.length;
      final validos = reporte.where((e) => e.valido).length;
      final invalidos = reporte.where((e) => !e.valido).length;

      resumen =
          'Fecha: ${DateTime.now()}\n\n'
          'Total documentos: $total\n'
          'Válidos: $validos\n'
          'Inválidos: $invalidos';
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Reporte generado')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reportes')),
      drawer: buildDrawer(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // TÍTULO
            const Text(
              'Resumen',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            // TARJETAS SUPERIORES
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _card(Icons.description, 'Total', reporte.length.toString()),
                _card(
                  Icons.check_circle,
                  'Válidos',
                  reporte.where((e) => e.valido).length.toString(),
                  color: Colors.green,
                ),
                _card(
                  Icons.cancel,
                  'Inválidos',
                  reporte.where((e) => !e.valido).length.toString(),
                  color: Colors.red,
                ),
              ],
            ),
            const SizedBox(height: 30),
            // BOTONES
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: generarReporte,
                    icon: const Icon(Icons.analytics),
                    label: const Text('Generar reporte'),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.deepPurple,
                      side: const BorderSide(color: Colors.deepPurple),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.historialVerificaciones,
                      );
                    },
                    icon: const Icon(Icons.history),
                    label: const Text('Ver historial'),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        reporte = [];
                        resumen = '';
                      });
                    },
                    icon: const Icon(Icons.delete),
                    label: const Text('Reiniciar reportes'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            // RESUMEN
            /*if (resumen.isNotEmpty)
              Card(
                color: Colors.deepPurple[50],
                margin: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Resumen del día',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple[800],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(resumen, style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
              ),*/
            const Divider(),
            // LISTA DE DOCUMENTOS
            const Text(
              'Documentos verificados',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...reporte.map(
              (e) => ListTile(
                leading: Icon(
                  e.valido ? Icons.check : Icons.close,
                  color: e.valido ? Colors.green : Colors.red,
                ),
                title: Text(e.texto),
                subtitle: Text(DateFormat('dd/MM/yyyy HH:mm').format(e.fecha)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Tarjetas pequeñas de resumen
  Widget _card(
    IconData icon,
    String title,
    String value, {
    Color color = Colors.blue,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Icon(icon, color: color),
            Text(title),
            Text(
              value,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
