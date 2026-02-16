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
      appBar: AppBar(title: const Text('Historial de verificaciones')),
      drawer: buildDrawer(context),

      body: Padding( // PADDING PARA LECTURA
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // BOTÓN PARA LIMPIAR TODO EL HISTORIAL
            SizedBox(
              width: double.infinity, //||> BOTÓN DE ANCHO de acuerdo a la pantalla
              child: ElevatedButton.icon(
                icon: const Icon(Icons.delete, color: Colors.white),
                label: const Text('Limpiar historial', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),

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
                          onPressed: () => Navigator.pop(context), // Cerrar diálogo
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

            const SizedBox(height: 15), // ESPACIO ENTRE BOTÓN Y LISTA

            // SI NO HAY DOCUMENTOS
            if (historial.isEmpty)
              const Center(
                child: Text(
                  'No hay documentos verificados',
                  style: TextStyle(fontSize: 16),
                ),
              ),

            // LISTA DE DOCUMENTOS
            Expanded(
              child: ListView.builder(
                itemCount: historial.length,
                itemBuilder: (context, index) {
                  final doc = historial[index];

                  return Card(
                    child: ListTile(
                      // ÍCONO VERDE O ROJO SEGÚN RESULTADO
                      leading: Icon(
                        doc.valido ? Icons.check_circle : Icons.cancel,
                        color: doc.valido ? Colors.green : Colors.red,
                      ),

                      // TEXTO DEL DOCUMENTO
                      title: Text(doc.texto),

                      // FECHA DE VERIFICACIÓN
                      subtitle: Text(doc.fecha.toString()),

                      // TEXTO VÁLIDO / INVÁLIDO
                      trailing: Text( // Para ver si el documento es válido o no
                        doc.valido ? 'Válido' : 'Inválido',
                        //doc.valido nos sirve para cambiar el color del texto según el resultado
                        style: TextStyle(
                            color:
                                doc.valido ? Colors.green : Colors.red),
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
}


