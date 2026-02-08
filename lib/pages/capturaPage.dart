import 'dart:io'; //librearia para herramientas internas y externas
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import '../helpers/menuItems.dart';

class CapturaPage extends StatefulWidget {
  const CapturaPage({super.key});

  @override
  State<CapturaPage> createState() => _CapturaPageState();
}

class _CapturaPageState extends State<CapturaPage> {
  File? _imagenArchivo;
  String _textoExtraido = "";

  final ImagePicker _picker = ImagePicker();
  //instancias

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagenArchivo = File(pickedFile.path);
      });
      _processImage();
    }
  } // funcion asincrona para abrir galeria

  Future<void> _pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _imagenArchivo = File(pickedFile.path);
      });
      _processImage();
    }
  } //funcion para la camara

  Future<void> _processImage() async {
    if (_imagenArchivo == null) return;

    final inputImage = InputImage.fromFilePath(_imagenArchivo!.path);
    final textRecognizer = TextRecognizer();
    final RecognizedText recognizedText = await textRecognizer.processImage(
      inputImage,
    );

    setState(() {
      _textoExtraido = recognizedText.text;
    });

    textRecognizer.close();
    //liberar recursos opcional
  } // Procesar imagen con OCR

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarService.buildAppBar(
        title: 'Captura de Imagen',
        hamburger: true,
        context: context,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                _textoExtraido.isEmpty
                    ? 'No hay texto extraído aún.'
                    : _textoExtraido,
                style: const TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    onPressed: _pickImageFromCamera,
                    icon: const Icon(Icons.camera_alt, color: Colors.red),
                    label: const Text(
                      'Abrir Cámara',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    onPressed: _pickImageFromGallery,
                    icon: const Icon(
                      Icons.insert_drive_file,
                      color: Colors.red,
                    ),
                    label: const Text(
                      'Abrir Galeriia',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
