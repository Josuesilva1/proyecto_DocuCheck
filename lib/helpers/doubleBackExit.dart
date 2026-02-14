import 'package:flutter/material.dart';

class DoubleBackExit extends StatefulWidget {
  final Widget child; // Pantalla a envolver
  final String mensaje; // Mensaje del SnackBar
  final int duracion; // Duración del SnackBar en segundos

  const DoubleBackExit({
    super.key,
    required this.child,
    this.mensaje = 'Presiona de nuevo para salir',
    this.duracion = 2,
  });

  @override
  State<DoubleBackExit> createState() => _DoubleBackExitState();
}

class _DoubleBackExitState extends State<DoubleBackExit> {
  DateTime? lastBackPressed;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final now = DateTime.now();
        final backButtonNotRecentlyPressed =
            lastBackPressed == null ||
            now.difference(lastBackPressed!) > Duration(seconds: widget.duracion);

        if (backButtonNotRecentlyPressed) {
          lastBackPressed = now;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(widget.mensaje),
              duration: Duration(seconds: widget.duracion),
            ),
          );
          return false; // No salir aún
        }
        return true; // Salir de la app
      },
      child: widget.child,
    );
  }
}