import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

Future<void> pickImageFromGallery(
  ImageSource source,
) async {
  final pickedFile = await pickImageFromGallery(source);
  if (pickedFile != null) {
    setState(() {
      imagenArchivo = File(pickedFile.path);
    });
    processImage();
  }
}
