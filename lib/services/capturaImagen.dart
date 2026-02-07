import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CapturaImagen {
  final ImagePicker _picker = ImagePicker();

  Future<File?> capturarImagen(BuildContext context) async {
    try {
      final XFile? imagen = await _picker.pickImage(source: ImageSource.camera);
      
      if (imagen != null) {
        return File(imagen.path);
      }
    } catch (e) {
      print ('Error al capturar imagen: $e');
      rethrow;
    }
    return null;
  }

  Future<File?> seleccionarImagenGaleria() async {
    try {
      final XFile? imagen = await _picker.pickImage(source: ImageSource.gallery);
      
      if (imagen != null) {
        return File(imagen.path);
      }
    } catch (e) {
      print('Error al seleccionar imagen de la galería: $e');
      rethrow;
    }
    return null;
  }
}