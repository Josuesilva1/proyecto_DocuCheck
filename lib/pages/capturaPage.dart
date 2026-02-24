import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import '../helpers/drawer.dart';
import '../helpers/document.dart';

class CapturaPage extends StatefulWidget {
  const CapturaPage({super.key});

  @override
  State<CapturaPage> createState() => _CapturaPageState();
}

class _CapturaPageState extends State<CapturaPage> {
  File? _imagenArchivo;
  String textoExtraido = '';

  final ImagePicker _picker = ImagePicker();
  final TextEditingController textoController = TextEditingController();

  Documento? documentoActual;

  @override
  void initState() {
    super.initState();
    documentoActual = Documento(texto: '', fecha: DateTime.now());
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _imagenArchivo = File(pickedFile.path));
      _processImage();
    }
  }

  Future<void> _pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() => _imagenArchivo = File(pickedFile.path));
      _processImage();
    }
  }

  Future<void> _processImage() async {
    if (_imagenArchivo == null) return;

    final inputImage = InputImage.fromFilePath(_imagenArchivo!.path);
    final textRecognizer = TextRecognizer();
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    setState(() {
      textoExtraido = recognizedText.text;
      textoController.text = textoExtraido;
    });

    textRecognizer.close();
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

            // BOTONES OCR
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

            // BYN GUARDAR DOCUMENTO
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
