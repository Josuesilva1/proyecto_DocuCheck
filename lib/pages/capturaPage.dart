import 'dart:io';
import 'package:flutter/material.dart';
import '../helpers/drawer.dart';
import '../helpers/document.dart';
import '../helpers/imageExtrac.dart';

class CapturaPage extends StatefulWidget {
  const CapturaPage({super.key});

  @override
  State<CapturaPage> createState() => _CapturaPageState();
}

class _CapturaPageState extends State<CapturaPage> {
  final ImageExtrac _imageExtrac = ImageExtrac();
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
                onPressed: () {
                  if (textoController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('No hay texto')),
                    );
                    return;
                  }

                  documentoActual = Documento(
                    texto: textoController.text,
                    fecha: DateTime.now(),
                  );

                  documentos.add(documentoActual!);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Documento guardado')),
                  );

                  // Limpiar campos
                  textoController.clear();
                  setState(() {
                    textoExtraido = "";
                    _imagenArchivo = null;
                  });

                  // Navegar a reportes
                  Navigator.pushNamed(context, '/reportesPage');
                  //aqui habia configurado yo para poder ver los reportes en la pagina de Andrea, reportes
                }, //pero ella lo ha cambiado.
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
