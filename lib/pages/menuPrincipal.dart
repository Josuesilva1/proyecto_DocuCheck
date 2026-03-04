// Función que hace que el grid se adapte a diferentes tamaños de pantalla
import 'dart:ui'; // necesario para ImageFilter
import 'package:flutter/material.dart';
import 'package:flutter_app_docucheck/helpers/doubleBackExit.dart';
import '../helpers/drawer.dart';
import '../helpers/menuItems.dart';
import '../routes/appRoutes.dart';

class MenuPrincipal extends StatelessWidget {
  const MenuPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return DoubleBackExit(
      child: Scaffold(
        appBar: AppBar(title: const Text('DocuCheck'), centerTitle: true),
        drawer: buildDrawer(context),

        body: Padding(
          padding: const EdgeInsets.all(12),

          // Animación suave al cargar
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(milliseconds: 600),
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(0, 30 * (1 - value)),
                  child: child,
                ),
              );
            },
            child: GridView.count(
              crossAxisCount: getCrossAxisCount(context),
              childAspectRatio: getCrossAxisCount(context) == 1 ? 1.4 : 1,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              children: [
                blurredGradientCard(
                  context,
                  'Escanear documento',
                  AppRoutes.capturaImage,
                  [Colors.blueAccent, Colors.indigo],
                  'images/camara.jpg',
                ),
                blurredGradientCard(
                  context,
                  'Reportes',
                  AppRoutes.reportesPage,
                  [Colors.teal, Colors.greenAccent],
                  'images/documento.jpg',
                ),
                blurredGradientCard(
                  context,
                  'Historial',
                  AppRoutes.historialVerificaciones,
                  [Colors.deepOrange, Colors.amber],
                  'images/historial.png',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget blurredGradientCard(
    BuildContext context,
    String title,
    String route,
    List<Color> gradientColors,
    String assetImage,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () => Navigator.pushNamed(context, route),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Stack(
          children: [
            // Imagen de fondo
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.asset(
                assetImage,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),

            // Capa difuminada + degradado encima de la imagen
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: gradientColors
                          .map((c) => c.withOpacity(0.6))
                          .toList(),
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),

            // Overlay oscuro ligero
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Container(
                color: Colors.black.withOpacity(0.2),
                width: double.infinity,
                height: double.infinity,
              ),
            ),

            // Contenido texto
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 12),
                  Text(
                    title,
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
