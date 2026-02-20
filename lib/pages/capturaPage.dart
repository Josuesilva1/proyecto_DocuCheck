import 'dart:io'; //librearia para herramientas internas y externas
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import '../helpers/drawer.dart';
import '../helpers/menuItems.dart';
import '../helpers/document.dart';

class CapturaPage extends StatefulWidget {
  const CapturaPage({super.key});

  @override
  State<CapturaPage> createState() => _CapturaPageState();
}

class _CapturaPageState extends State<CapturaPage> {
  File? _imagenArchivo;
  String textoExtraido = "";

  final ImagePicker _picker = ImagePicker();
  final TextEditingController textoController = TextEditingController();

  //logica para enviar a reportes e historial
  Documento? documentoActual;

  @override
  void initState() {
    super.initState();
    documentoActual = Documento(texto: '', fecha: DateTime.now());
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagenArchivo = File(pickedFile.path);
      });
      _processImage();
    }
  }

  Future<void> _pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _imagenArchivo = File(pickedFile.path);
      });
      _processImage();
    }
  }

  Future<void> _processImage() async {
    if (_imagenArchivo == null) return;

    final inputImage = InputImage.fromFilePath(_imagenArchivo!.path);
    final textRecognizer = TextRecognizer();
    final RecognizedText recognizedText = await textRecognizer.processImage(
      inputImage,
    );

    setState(() {
      textoExtraido = recognizedText.text;
      textoController.text = textoExtraido;
    });

    textRecognizer.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Captura de Imagen'), centerTitle: true),
      drawer: buildDrawer(context),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              /* Text(
                textoExtraido.isEmpty
                    ? 'No hay texto extraído aún.'
                    : 'Texto extraído exitosamente',
                style: const TextStyle(fontSize: 16),
              ),**/
              const SizedBox(height: 30),

              Container(
                width: 300,
                child: TextField(
                  controller: textoController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'No hay texto extraído aún',
                    hintText: 'Ingrese o edite el texto',
                  ),
                  maxLines: null,
                ),
              ),
              const SizedBox(height: 30),

              // Aqui se pasa las funciones como parámetros
              setButton(
                onCameraPressed: _pickImageFromCamera,
                onGalleryPressed: _pickImageFromGallery,

                onSavePressed: () {
                  if (textoController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('No se guardó el texto')),
                    );
                  } else {
                    documentoActual = Documento(
                      texto: textoController.text,
                      fecha: DateTime.now(),
                    );
                    documentos.add(documentoActual!);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Guardado exitosamente')),
                    );
                  }
                },

                onWhatsappPressed: () {
                  // lógica para enviar por WhatsApp
                  print("Enviar por WhatsApp: ${textoController.text}");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
