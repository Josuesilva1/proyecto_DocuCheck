import 'package:flutter/material.dart';

Future<void> mostrarErrorPopUp({
  required BuildContext context,
  required String mensaje,
}) {
  return showDialog(
    context: context, 
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: Colors.red, width: 3),
        ),
        title: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error, color: const Color.fromARGB(255, 189, 0, 0),),
              SizedBox(width: 10),
              Text(
                'Error',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22, 
                  fontWeight: FontWeight.bold,
                  ),
                ),
            ]
            )
          ),
        content: Text(mensaje,
        style: TextStyle(fontSize: 18),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cerrar'),
          ),
        ],
      );
    },
    );
}