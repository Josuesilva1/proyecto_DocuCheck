import 'dart:io';
import 'package:flutter/material.dart';
import '../helpers/drawer.dart';
import '../models/document.dart';
import '../helpers/imageExtrac.dart';
import '../models/verificacion_model.dart';
import '../services/verificacion_service.dart';
import '../routes/appRoutes.dart';

class CapturaPage extends StatefulWidget {
  const CapturaPage({super.key});

  @override
  State<CapturaPage> createState() => _CapturaPageState();
}

class _CapturaPageState extends State<CapturaPage> {
  final ImageExtrac _imageExtrac = ImageExtrac();
  final VerificacionService _verificacionService = VerificacionService();
  File? _imagenArchivo;
  String textoExtraido = '';
  final TextEditingController textoController = TextEditingController();
  Documento? documentoActual;

  @override
  void initState() {
    super.initState();
    documentoActual = Documento(texto: '', fecha: DateTime.now());
  }

  Future<void> _pickImageFromGallery() async {
    final file = await _imageExtrac.pickImageFromGallery();
    if (file != null) {
      setState(() => _imagenArchivo = file);
      _processImage(file);
    }
  }

  Future<void> _pickImageFromCamera() async {
    final file = await _imageExtrac.pickImageFromCamera();
    if (file != null) {
      setState(() => _imagenArchivo = file);
      _processImage(file);
    }
  }

  Future<void> _processImage(File file) async {
    final text = await _imageExtrac.processImage(file);
    setState(() {
      textoExtraido = text;
      textoController.text = textoExtraido;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9DDCD),
      appBar: AppBar(
        title: const Text('Escanear documento'),
        centerTitle: true,
        backgroundColor: const Color(0xFF1C3166),
      ),
      drawer: buildDrawer(context),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // PREVIEW DE IMAGEN
            if (_imagenArchivo != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(_imagenArchivo!, height: 200),
              ),

            const SizedBox(height: 20),

            // CAMPO TEXTO OCR
            TextField(
              controller: textoController,
              maxLines: 6,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Texto reconocido aparecerá aquí...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF268FBE),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: _pickImageFromCamera,
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Cámara'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1C3166),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: _pickImageFromGallery,
                    icon: const Icon(Icons.photo),
                    label: const Text('Galería'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            //guardar
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  bool esValido = textoController.text.trim().isNotEmpty;

                  if (!esValido) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('No se pudo extraer texto válido del documento.')),
                    ); 
                  }

                  //en lugar del document se llena el modelo de validacion
                  var validacion = VerificacionModel(
                    texto: textoController.text,
                    valido: esValido,
                    fecha: DateTime.now(),
                  );

                  //se inserta en la base
                  await _verificacionService.insertarVerificacion(validacion);

                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Documento guardado'),
                        content: const Text('¿Qué deseas hacer ahora?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              textoController.clear();
                              setState(() {
                                textoExtraido = '';
                                _imagenArchivo = null;
                              });
                              Navigator.pop(context);
                            },
                            child: const Text('Seguir capturando'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pushNamed(
                                context,
                                AppRoutes.reportesPage,
                              );
                            },
                            child: const Text('reportes'),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(Icons.save),
                label: const Text('Guardar documento'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
