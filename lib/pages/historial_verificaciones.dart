import 'package:flutter/material.dart';
import '../helpers/drawer.dart';
import '../services/historial_service.dart';

class HistorialVerificaciones extends StatefulWidget {
  const HistorialVerificaciones({super.key});

  @override
  State<HistorialVerificaciones> createState() =>
      _HistorialVerificacionesState();
}

class _HistorialVerificacionesState extends State<HistorialVerificaciones> {
  @override
  Widget build(BuildContext context) {
    final historial = HistorialService.historial;

    return Scaffold(
      backgroundColor: const Color(0xFFD9DDCD),
      appBar: AppBar(
        title: const Text('Historial'),
        backgroundColor: const Color(0xFF1C3166),
        centerTitle: true,
      ),
      drawer: buildDrawer(context),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // ===== CONTADOR SUPERIOR =====
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Documentos verificados',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(historial.length.toString()),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // ===== BOTÓN LIMPIAR =====
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.delete, color: Colors.white),
                label: const Text(
                  'Limpiar historial',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),

                // Confirmación antes de borrar
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Confirmar'),
                      content: const Text(
                          '¿Deseas eliminar todo el historial?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              HistorialService.limpiar();
                            });
                            Navigator.pop(context);
                          },
                          child: const Text('Eliminar'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 15),

            // ===== SI NO HAY DATOS =====
            if (historial.isEmpty)
              const Padding(
                padding: EdgeInsets.only(top: 40),
                child: Text(
                  'No hay documentos aún',
                  style: TextStyle(fontSize: 16),
                ),
              ),

            // ===== LISTA =====
            Expanded(
              child: ListView.builder(
                itemCount: historial.length,
                itemBuilder: (context, index) {
                  final doc = historial[index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: ListTile(

                      // ICONO SEGÚN RESULTADO
                      leading: CircleAvatar(
                        backgroundColor:
                            doc.valido ? Colors.green : Colors.red,
                        child: Icon(
                          doc.valido ? Icons.check : Icons.close,
                          color: Colors.white,
                        ),
                      ),

                      // TEXTO OCR (limitado)
                      title: Text(
                        doc.texto,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      // FECHA
                      subtitle: Text(
                        _formatearFecha(doc.fecha),
                      ),

                      // BADGE VALIDO / INVALIDO
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color:
                              doc.valido ? Colors.green : Colors.red,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          doc.valido ? 'Válido' : 'Inválido',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===== FORMATEA FECHA BONITA =====
  String _formatearFecha(DateTime fecha) {
    return '${fecha.day}/${fecha.month}/${fecha.year}  ${fecha.hour}:${fecha.minute.toString().padLeft(2, '0')}';
  }
}