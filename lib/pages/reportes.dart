import 'package:flutter/material.dart';
import '../helpers/drawer.dart';
import '../services/historial_service.dart';
import '../helpers/document.dart';

class ReportesPage extends StatefulWidget {
  const ReportesPage({super.key});

  @override
  State<ReportesPage> createState() => _ReportesPageState();
}

class _ReportesPageState extends State<ReportesPage> {
  String resumen = '';

  // Genera el resumen del reporte usando los datos del historial
  void generarReporte() {
    final historial = HistorialService.historial;

    final total = historial.length;
    final validos = historial.where((e) => e.valido).length;
    final invalidos = historial.where((e) => !e.valido).length;

    setState(() {
      resumen =
          'Fecha: ${DateTime.now()}\n\n'
          'Total documentos: $total\n'
          'Válidos: $validos\n'
          'Inválidos: $invalidos';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Reporte generado')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final historial = HistorialService.historial;

    final total = historial.length;
    final validos = historial.where((e) => e.valido).length;
    final invalidos = historial.where((e) => !e.valido).length;

    return Scaffold(
      appBar: AppBar(title: const Text('Reportes')),
      drawer: buildDrawer(context),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            // TITULO
            const Text(
              'Resumen general',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            // TARJETAS DE RESUMEN, que es lo que se muestra en la parte superior del reporte, con el total de documentos, los válidos y los inválidos
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _card(Icons.description, 'Total', total.toString()),
                _card(Icons.check_circle, 'Válidos', validos.toString(),
                    color: Colors.green),
                _card(Icons.cancel, 'Inválidos', invalidos.toString(),
                    color: Colors.red),
              ],
            ),

            const SizedBox(height: 30),

            // BOTONES PRINCIPALES
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
                      Navigator.pushNamed(context, '/historialVerificaciones');
                    },
                    icon: const Icon(Icons.history),
                    label: const Text('Ver historial'),
                  ),
                ),

                const SizedBox(height: 10),

                SizedBox(
                  width: double.infinity, //||> BOTÓN DE ANCHO de acuerdo a la pantalla
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        HistorialService.limpiar();
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

            // RESUMEN GENERADO
            if (resumen.isNotEmpty) //Solo se va a mostrar el resumen si ya se ha generado
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(resumen),
                ),
              ),

            const Divider(),

            // LISTA DE DOCUMENTOS
            const Text(
              'Documentos verificados',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            ...historial.map( // Para mostrar cada documento del historial
              (e) => ListTile(
                leading: Icon(
                  e.valido ? Icons.check : Icons.close,
                  color: e.valido ? Colors.green : Colors.red,
                ),
                title: Text(e.texto),
                subtitle: Text(e.fecha.toString()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _card(IconData icon, String title, String value, //Seria para que se muestre el total de documentos, los válidos y los inválidos
      {Color color = Colors.blue}) {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reportes'), centerTitle: true),
      drawer: buildDrawer(context),
      body: ListView.builder(
        itemCount: documentos.length,
        itemBuilder: (context, index) {
          final doc = documentos[index];
          return ListTile(
            title: Text(doc.texto),
            subtitle: Text(doc.fecha.toString()),
          );
        },
      ),
    );
  }
}
