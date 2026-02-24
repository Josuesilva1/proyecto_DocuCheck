import '../models/verificacion_model.dart';

class HistorialService {

  static List<VerificacionModel> historial = [];

  static void agregar(String texto, bool valido) {
    historial.add(
      VerificacionModel(
        texto: texto,
        fecha: DateTime.now(),
        valido: valido,
      ),
    );
  }

  static void limpiar() {
    historial.clear();
  }
}
