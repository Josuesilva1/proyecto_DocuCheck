/*import 'dart:io'; //librearia para herramientas internas y externas
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';


class Imageextrac extends StatefulWidget {
  const Imageextrac({super.key});

  @override
  State<Imageextrac> createState() => _ImageextracState();
}

class _ImageextracState extends State<Imageextrac> {
  @override

File? imagenArchivo;
final ImagePicker picker = ImagePicker();
String textoExtraido = "";

  Future<void> pickImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      @override 
      setState(() {
        imagenArchivo = File(pickedFile.path);
      });
      processImage();
    }
  }

  Future<void> pickImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      @override 
      setState(() {
        imagenArchivo = File(pickedFile.path);
      });
      processImage();
    }
  } //funcion para la camara

    Future<void> processImage() async {
    if (imagenArchivo == null) return;

    final inputImage = InputImage.fromFilePath(imagenArchivo!.path);
    final textRecognizer = TextRecognizer();
    final RecognizedText recognizedText = await textRecognizer.processImage(
      inputImage,
    );
    @override 
    setState(() {
      textoExtraido = recognizedText.text;
    });

    textRecognizer.close();//liberar recursos opcional
  } // Procesar imagen con OCR

  Widget build(BuildContext context) {
    return Container();
  }
}
**/