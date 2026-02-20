import 'package:flutter/material.dart';

Widget menuItems(
  BuildContext context,
  IconData icon,
  String title,
  String route,
) {
  return InkWell(
    onTap: () {
      Navigator.pushNamed(context, route);
    },
    borderRadius: BorderRadius.circular(16),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.black,
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 48, color: Colors.red),
          SizedBox(width: 6),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}

int getCrossAxisCount(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  return width < 500 ? 1 : 2;
}


Widget bulletItem(String text) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(Icons.circle, size: 8),
      SizedBox(width: 8),
      Expanded(
        child: Text(
          text,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
      ),
    ],
  );
}

Widget bulletSubItem(String text) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Icon(Icons.circle_outlined, size: 8),
      const SizedBox(width: 8),
      Expanded(
        child: Text(
          text,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
      ),
    ],
  );
}



//callBack action para mandar a llamar las funciones de los bonontes
//y construir aqui las propiedades.
Widget setButton({
  required VoidCallback onCameraPressed,
  required VoidCallback onGalleryPressed,
  required VoidCallback onSavePressed,
  required VoidCallback onWhatsappPressed,
}) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            onPressed: onCameraPressed,
            icon: const Icon(Icons.camera_alt, color: Colors.red),
            label: const Text(
              'Abrir Cámara',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 20),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            onPressed: onGalleryPressed,
            icon: const Icon(Icons.insert_drive_file, color: Colors.red),
            label: const Text(
              'Abrir Galería',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      const SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            onPressed: onSavePressed,
            icon: const Icon(Icons.save, color: Colors.blue),
            label: const Text('Guardar', style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(width: 20),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            onPressed: onWhatsappPressed,
            icon: const Icon(Icons.phone, color: Colors.green),
            label: const Text(
              'Enviar por WhatsApp',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    ],
  );
}