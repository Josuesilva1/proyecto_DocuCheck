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
        appBar: AppBar(
          title: const Text('DocuCheck'),
          centerTitle: true,
        ),
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
              childAspectRatio:
                  getCrossAxisCount(context) == 1 ? 1.4 : 1,

              crossAxisSpacing: 15,
              mainAxisSpacing: 15,

              children: [

                _cardMenu(
                  context,
                  Icons.camera_alt,
                  'Escanear documento',
                  AppRoutes.capturaImage,
                ),

                _cardMenu(
                  context,
                  Icons.analytics,
                  "Reportes",
                  AppRoutes.reportesPage,
                ),

                _cardMenu(
                  context,
                  Icons.history,
                  "Historial",
                  AppRoutes.historialVerificaciones,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Función que hace que el grid se adapte a diferentes tamaños de pantalla
  Widget _cardMenu(
    BuildContext context,
    IconData icon,
    String title,
    String route,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () => Navigator.pushNamed(context, route),

      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Icon(
              icon,
              size: 48,
              color: const Color(0xFF1C3166),
            ),

            const SizedBox(height: 12),

            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}