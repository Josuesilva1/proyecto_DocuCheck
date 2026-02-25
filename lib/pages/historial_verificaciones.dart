import 'package:flutter/material.dart';
import '../helpers/drawer.dart';
import '../services/verificacion_service.dart';
import '../models/verificacion_model.dart';

class HistorialVerificaciones extends StatefulWidget {
  const HistorialVerificaciones({super.key});

  @override
  State<HistorialVerificaciones> createState() =>
      _HistorialVerificacionesState();
}

class _HistorialVerificacionesState extends State<HistorialVerificaciones> {
  final VerificacionService _historico = VerificacionService();
  late Future<List<VerificacionModel>> futurosHistorial;

  @override
  void initState() {
    super.initState();
    _cargarHistorial();
  }

  void _cargarHistorial() {
    futurosHistorial = _historico.obtenerVerificaciones();
  }

  @override
  Widget build(BuildContext context) {
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
        child: FutureBuilder<List<VerificacionModel>>(
          future: futurosHistorial,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No hay documentos aún'));
            } else {
              final historial = snapshot.data!;
              return Column(
                children: [
                  _buildContador(historial),
                  const SizedBox(height: 15),
                  Expanded(child: _buildLista(historial)),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildContador(List<VerificacionModel> historial) {
    return Container(
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
    );
  }

  Widget _buildLista(List<VerificacionModel> historial) {
    return ListView.builder(
      itemCount: historial.length,
      itemBuilder: (context, index) {
        final doc = historial[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: doc.valido ? Colors.green : Colors.red,
              child: Icon(doc.valido ? Icons.check : Icons.close,
                  color: Colors.white),
            ),
            title: Text(doc.texto,
                maxLines: 2, overflow: TextOverflow.ellipsis),
            subtitle: Text(_formatearFecha(doc.fecha)),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: doc.valido ? Colors.green : Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(doc.valido ? 'Válido' : 'Inválido',
                  style: const TextStyle(color: Colors.white, fontSize: 12)),
            ),
          ),
        );
      },
    );
  }

  String _formatearFecha(DateTime fecha) {
    return '${fecha.day}/${fecha.month}/${fecha.year}  ${fecha.hour}:${fecha.minute.toString().padLeft(2, '0')}';
  }
}